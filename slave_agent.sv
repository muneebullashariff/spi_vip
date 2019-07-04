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

`ifndef _SLAVE_AGENT_INCLUDED_
`define _SLAVE_AGENT_INCLUDED_



//-----------------------------------------------------------------------------
// Class: SLAVE_AGENT
// Description of the class.
// this class contains active components like driver sequencer and monitor
//-----------------------------------------------------------------------------
class slave_agent extends uvm_agent;

//register with factory so can use create uvm_method 
//and override in future if necessary 


`uvm_component_utils(slave_agent)

//declaring handles for agent config driver monitor and sequencer
   
slave_agent_config s_cfg;
slave_driver s_drv;
slave_monitor s_mon;
slave_sequencer s_seqrh;


  
//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new(string name="slave_agent", uvm_component parent); 
extern  function void build_phase(uvm_phase phase);
extern  function void connect_phase(uvm_phase phase);

endclass: slave_agent


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_mon class object
//
// Parameters:
//  name - instance name of the slave_mon
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function slave_agent::new(string name="slave_agent", uvm_component parent); 
  super.new(name,parent); 
endfunction: new 

//-----------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
function void slave_agent::build_phase(uvm_phase phase);
 
  super.build_phase(phase);
           
         if(!uvm_config_db #(slave_agent_config)::get(this,"","slave_agent_config",s_cfg))
          begin
           `uvm_fatal("config","cannotget()s_cfg from uvm_config_db.have you set it?.")
          end
//creating slave monitor
s_mon=slave_monitor::type_id::create("s_mon",this);
      s_cfg=new();

//If the master agent is made active in master_configuration
// class create driver and sequence
if(s_cfg.is_active==UVM_ACTIVE)
 begin
   s_drv=slave_driver::type_id::create("s_drv",this);
   s_seqrh=slave_sequencer::type_id::create("s_seqrh",this);
 end

     
endfunction: build_phase  
//-----------------------------------------------------------------------------
// Function: connect_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------

function void slave_agent::connect_phase(uvm_phase phase);
	if(s_cfg.is_active==UVM_ACTIVE)
         begin
       	  s_drv.seq_item_port.connect(s_seqrh.seq_item_export);
         end
endfunction
//------------------------------------------------------------------------------
`endif
