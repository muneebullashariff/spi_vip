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

`ifndef _SLAVE_AGENT_TOP_INCLUDED_
`define _SLAVE_AGENT_TOP_INCLUDED_



//-----------------------------------------------------------------------------
// Class: SLAVE_AGENT_TOP
// Description of the class.
// this class is used to get env_config and set the agent config
//-----------------------------------------------------------------------------
class slave_agent_top extends uvm_env;

//register with factory so can use create uvm_method
// and override in future if necessary
 `uvm_component_utils(slave_agent_top)

//declaring handles for agent config driver monitor and sequencer
   
 slave_agent s_agt[];
 env_config e_cfg;

//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new(string name="slave_agent_top", uvm_component parent); 
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass: slave_agent_top



 
 

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_agent_top class component
//
// Parameters:
//  name - instance name of the slave_agent_top
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function slave_agent_top::new(string name="slave_agent_top", uvm_component parent); 
  super.new(name,parent); 
endfunction: new 

//-----------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
function void slave_agent_top::build_phase(uvm_phase phase);

  super.build_phase(phase);

             if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
             begin
            `uvm_fatal("config","cannotget()e_cfg from uvm_config_db.have you set it?.")
             end

       s_agt =new[e_cfg.no_of_sagent];

       foreach(s_agt[i])
	begin
           uvm_config_db #(slave_agent_config)::set(this,$sformatf("s_agt[%0d]*",i),"slave_agent_config",e_cfg.s_cfg[i]);
           s_agt[i]=slave_agent::type_id::create($sformatf("s_agt[%0d]",i), this);
	end
 endfunction: build_phase
//-----------------------------------------------------------------
//task:run phase
//printing topology
//----------------------------------------------------------------
 task slave_agent_top::run_phase(uvm_phase phase);
  uvm_top.print_topology;
 endtask:run_phase
//-------------------------------------------------------------------------

`endif
