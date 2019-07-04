//  ###########################################################################
//
//  Licensed to the Apache Software Foundation (ASF) under one
//  or more contributor license agreements.  See the NOTICE file
//  distributed with this work for additional information
//  regarding copyright ownership.  The ASF licenses this file
//  to you under the Apache License, Version 2.0 (the
//  "License"); you may not use this file except in compliance
//  with the License.  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.
//
//  ###########################################################################

`ifndef _MASTER_MONITOR_INCLUDED_
`define _MASTER_MONITOR_INCLUDED_


//-----------------------------------------------------------------------------
// Class: master_monitor
// Description of the class.
//Monitor is written by extending uvm_monitor,uvm_monitor is inherited from uvm_component, 
//A monitor is a passive entity that samples the DUT signals through virtual interface and 
//converts the signal level activity to transaction level,monitor samples DUT signals but does not drive them.
//Monitor should have analysis port (TLM port) and virtual interface handle that points to DUT signal
//------------------------------------------------------------------------------
class master_monitor extends uvm_monitor;

//register with factory so can use create uvm_method and
// override in future if necessary 

 `uvm_component_utils(master_monitor)

//declaring virtual interface
virtual spi_if.MMON_CB vif;

//declaring handle for master config class
 master_agent_config  m_cfg;

//declaring analysis port for the monitor port
uvm_analysis_port #(master_xtn)monitor_port;
 



//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
 extern function new(string name = "master_monitor", uvm_component parent); 
 extern function void build_phase(uvm_phase phase);
 extern function void connect_phase(uvm_phase phase);
 extern task run_phase(uvm_phase phase);
 extern task collect_data();

 
endclass: master_monitor

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_monitor class component
//
// Parameters:
//  name - instance name of the config_template
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function master_monitor::new(string name="master_monitor", uvm_component parent); 
  super.new(name,parent); 

//creating monitor port
monitor_port=new("monitor_port",this);

endfunction: new 

//-----------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
function void master_monitor::build_phase(uvm_phase phase);

    super.build_phase(phase);

  
      if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",m_cfg))
       begin
	`uvm_fatal("TB CONFIG","cannot get() m_cfg from uvm_config");
       end
 
endfunction: build_phase
//-----------------------------------------------------------------------------

//function: connect_phase
//connecting virtual interface with master agent config

//-----------------------------------------------------------------------------

function void master_monitor::connect_phase(uvm_phase phase);
	vif = m_cfg.vif;
endfunction

//------------------------------------------------------------------------------
//task: run_phase
//collecting data in run phase

//------------------------------------------------------------------------------
task master_monitor::run_phase(uvm_phase phase);
    forever
      begin
      collect_data();
      end
endtask:run_phase

//------------------------------------------------------------------------------
//task: collect_phase
//creating a handle for master transaction 
//connecting pin level to transaction level
//-------------------------------------------------------------------------------
task master_monitor::collect_data();
       
      master_xtn data_sent;
      
     data_sent = master_xtn::type_id::create("data_sent");

     fork
      begin
      // @(vif.mmon_cb);

       //  data_sent.sclk = vif.mmon_cb.sclk;
      //   data_sent.ss = vif.mmon_cb.ss;
        
      /*   data_sent.mosi0 = vif.mmon_cb.mosi0;
         data_sent.mosi1 = vif.mmon_cb.mosi1;
         data_sent.mosi2 = vif.mmon_cb.mosi2;
         data_sent.mosi3 = vif.mmon_cb.mosi3;

         data_sent.miso0 =vif.mmon_cb.miso0;  
         data_sent.miso1 =vif.mmon_cb.miso1; 
         data_sent.miso2 =vif.mmon_cb.miso2; 
         data_sent.miso3 =vif.mmon_cb.miso3; */
       end
   join
//implementing write method 
 monitor_port.write(data_sent);


       `uvm_info("MASTER_MONITOR",$sformatf("printing from monitor \n %s", data_sent.sprint()),UVM_LOW)

endtask:collect_data
//------------------------------------------------------------------------------------
`endif  




 
 
