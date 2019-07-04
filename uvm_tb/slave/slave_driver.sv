//1) License copy
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

`ifndef _SLAVE_DRIVER_INCLUDED_
`define _SLAVE_DRIVER_INCLUDED_



//-----------------------------------------------------------------------------
// Class: slave_driver
// Description of the class.
// This class provides the conversion of transaction level to pin level
//-----------------------------------------------------------------------------
class slave_driver extends uvm_driver #(slave_xtn);

//register with factory so can use create uvm_method and
// override in future if necessary 
 `uvm_component_utils(slave_driver)



//declaring the handles of virtual interface and slave agent config 
  virtual spi_if.SDR_MP vif;
  slave_agent_config s_cfg;

//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new(string name="slave_driver", uvm_component parent); 
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task data_rec(slave_xtn xtn);


endclass: slave_driver


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_driver class component
//
// Parameters:
//  name - instance name of the slave_driver
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function slave_driver::new(string name="slave_driver", uvm_component parent); 
  super.new(name,parent); 
endfunction: new 

//-----------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
function void slave_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);

        if(!uvm_config_db #(slave_agent_config)::get(this,"","slave_agent_config",s_cfg))
         begin

	 `uvm_fatal("CONFIG","Cannot get() s_cfg fron uvm_config_db. have you set it?")

         end

 endfunction: build_phase
//------------------------------------------------------------------------------
//function:connect phase
//
//connecting slave agent config with virtual interface 
//------------------------------------------------------------------------------

 function void slave_driver::connect_phase(uvm_phase phase);
	 vif=s_cfg.vif;
endfunction:connect_phase
//------------------------------------------------------------------------------
//task: run phase
//getting the item from the sequence and giving acknowledgement as item done
//to sequence
//------------------------------------------------------------------------------
task slave_driver::run_phase(uvm_phase phase);
  
     forever
 
	 begin
	   seq_item_port.get_next_item(req);
	    data_rec(req);
	   seq_item_port.item_done();
	end
endtask:run_phase
//------------------------------------------------------------------------------
//task: send to dut
//converting transaction level to pin level

//-------------------------------------------------------------------------------

task slave_driver::data_rec(slave_xtn xtn);


        @(negedge vif.sclk);
          begin

      for(int i=0;i<xtn.data_in_miso;i++)
       begin

          xtn.data_in_mosi[0]=vif.sdr_cb.miso;

           $display("right shift operation",xtn.data_in_mosi << 1'b1);

          vif.MDR_CB.mosi=xtn.data_in_miso;
        end

        //	vif.sdr_cb.miso0 <= xtn.miso0;
         //	vif.sdr_cb.mosi0 <= xtn.mosi0;
  
 	  end


	`uvm_info("slave_driver",$sformatf("printin from slave_driver \n %s",xtn.sprint()),UVM_LOW)
endtask:data_rec
//----------------------------------------------------------------------------------------

`endif


	


	

	

