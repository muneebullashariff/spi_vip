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

`ifndef _ENV_
`define _ENV_



//-----------------------------------------------------------------------------
// Class: env
 /*User-defined environment is derived from uvm_env, uvm_env is inherited from uvm_component.
	Environment is the container class, It contains one or more agents or agent_tops,
	as well as other components such as scoreboard,checker,virtual sequencer. */
//-----------------------------------------------------------------------------
class env extends uvm_env;

  `uvm_component_utils(env)

  env_config e_cfg;
  master_agent_top mtop;
  slave_agent_top stop;
  master_agent_config m_cfg;
  slave_agent_config s_cfg;
  
    
  //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------
  extern function new(string name = "env", uvm_component parent); 
  extern virtual function void build_phase(uvm_phase phase);
// extern task run_phase(uvm_phase phase);
endclass: env

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the config_template class object
//-----------------------------------------------------------------------------
function env::new(string name = "env", uvm_component parent); 
  super.new(name,parent); 
endfunction: new 

//-----------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
function void env::build_phase(uvm_phase phase);

if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
  begin
    `uvm_fatal("CONFIG", "cannot get() e_cfg from uvm_config")
  end

  super.build_phase(phase);

  if(e_cfg.has_mtop == 1)
    mtop = master_agent_top::type_id::create("mtop",this);
 if(e_cfg.has_stop == 1)
    stop = slave_agent_top::type_id::create("stop",this);
endfunction
/*//run_phase
 task env::run_phase(uvm_phase phase);
   uvm_top.print_topology;
 endtask:run_phase*/

 `endif
