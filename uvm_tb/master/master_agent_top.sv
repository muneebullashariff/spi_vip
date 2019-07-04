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

`ifndef _MASTER_AGENT_TOP_INCLUDED_
`define _MASTER_AGENT_TOP_INCLUDED_


//-----------------------------------------------------------------------------
// Class: master_agent_top
// Description of the class.

//Agent_top that is sub-environment container that may contain one or more agents

//------------------------------------------------------------------------------
class master_agent_top extends uvm_env;

//register with factory so can use create uvm_method
// and override in future if necessary

 `uvm_component_utils(master_agent_top)

//declare handle for agents and env config to be created
master_agent m_agt[];
env_config e_cfg;

//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new(string name = "master_agent_top", uvm_component parent); 
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass: master_agent_top

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_agent_top class component
//
// Parameters:
//  name - instance name of the config_template
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function master_agent_top::new(string name="master_agent_top", uvm_component parent); 
  super.new(name,parent); 
endfunction: new 

//-----------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
function void master_agent_top::build_phase(uvm_phase phase);
  
      if(!uvm_config_db #(env_config)::get(this," ","env_config",e_cfg))
       begin
	`uvm_fatal("TB CONFIG","cannot get() m_agt from uvm_config")
       end
 
       m_agt=new[e_cfg.no_of_magent];
       
         foreach(m_agt[i])
         begin
              uvm_config_db #(master_agent_config)::set(this,$sformatf("m_agt[%0d]*",i),"master_agent_config",e_cfg.m_cfg[i]);
              m_agt[i]=master_agent::type_id::create($sformatf("m_agt[%0d]",i),this);
         end
  super.build_phase(phase);

endfunction: build_phase
//--------------------------------------------------------------------------------
//Function:run task
//printing topology
//---------------------------------------------------------------------------------
 task master_agent_top::run_phase(uvm_phase phase);
   uvm_top.print_topology;
 endtask:run_phase
//--------------------------------------------------------------------------------

`endif

   



