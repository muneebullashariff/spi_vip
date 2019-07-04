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

`ifndef _SLAVE_MONITOR_INCLUDED_
`define _SLAVE_MONITOR_INCLUDED_




//-----------------------------------------------------------------------------
// Class: SLAVE_MONITOR
// Description of the class.
// This class collects data from dut and transmits it to the scoreboard
// through analysis port

//-----------------------------------------------------------------------------
class slave_monitor extends uvm_monitor;

//register with factory so can use create uvm_method and
// override in future if necessary 

 `uvm_component_utils(slave_monitor)


//declaring the handles of virtual interface and slave agent config and
//analysis port
 virtual spi_if.SMON_CB vif;
 
 slave_agent_config s_cfg;

//declaring analysis port for the monitor port

uvm_analysis_port #(slave_xtn) monitor_port;



//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new(string name="slave_monitor", uvm_component parent); 
extern  function void build_phase(uvm_phase phase);
extern  function void connect_phase(uvm_phase phase);
extern  task run_phase(uvm_phase phase);
extern task collect_data;


endclass: slave_monitor


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_monitor class component
//
// Parameters:
//  name - instance name of the slave_monitor
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function slave_monitor::new(string name="slave_monitor", uvm_component parent); 
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
function void slave_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);

        if(!uvm_config_db #(slave_agent_config)::get(this,"","slave_agent_config",s_cfg))
	begin
	  `uvm_fatal("CONFIG","Cannot get() s_cfg from uvm_config_db.Have you set it?")
	end
	

 
 endfunction: build_phase
//-----------------------------------------------------------------------------
// Function: connect_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------

function void slave_monitor::connect_phase(uvm_phase phase);
	vif=s_cfg.vif;
endfunction:connect_phase

//-----------------------------------------------------------------------------
// Task: run_phase
// Waits for reset and initiates the main montoring task 
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
task slave_monitor::run_phase(uvm_phase phase);
  forever
  	begin
         collect_data();
        end
 endtask:run_phase 
//-----------------------------------------------------------------------------
// Task: send_to_dut
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------

task slave_monitor::collect_data;

    slave_xtn data_sent;
  
   data_sent=slave_xtn::type_id::create("data_sent");

         
 fork
      begin
     /*  @(vif.smon_cb);

         data_sent.sclk = vif.smon_cb.sclk;
         data_sent.ss = vif.smon_cb.ss;
        
         data_sent.mosi0 = vif.smon_cb.mosi0;
         data_sent.mosi1 = vif.smon_cb.mosi1;
         data_sent.mosi2 = vif.smon_cb.mosi2;
         data_sent.mosi3 = vif.smon_cb.mosi3;

         data_sent.miso0 =vif.smon_cb.miso0;  
         data_sent.miso1 =vif.smon_cb.miso1; 
         data_sent.miso2 =vif.smon_cb.miso2; 
         data_sent.miso3 =vif.smon_cb.miso3; */
       end
   join
//implementing write method 
 monitor_port.write(data_sent);

  // `uvm_info("SLAVE_monitor",$sformatf("printing from monitor \n %s"),UVM_LOW) 

endtask:collect_data
//----------------------------------------------------------------------------------------------
`endif





    

