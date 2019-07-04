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

`ifndef _ENV_INCLUDED_
`define _ENV_INCLUDED_



//-----------------------------------------------------------------------------
// Class: env
//User-defined environment is derived from uvm_env, uvm_env is inherited from uvm_component.
//Environment is the container class, It contains one or more agents or agent_tops,
//as well as other components such as scoreboard,checker,virtual sequencer.
//-----------------------------------------------------------------------------
class env extends uvm_env;

//register with factory so can use create uvm_method 
//and override in future if necessary 

`uvm_component_utils(env)


//declaring handle env config
  env_config e_cfg;
//declaring handles for master and slave agent top 
  master_agent_top mtop;
  slave_agent_top stop;
//declaring handles for master and slave agent config
  master_agent_config m_cfg;
  slave_agent_config s_cfg;
//declaring handles for virtual sequencr and scoreboard
 virtual_sequencer v_sequencer;
// scoreboard sb; 
    
//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new(string name = "env", uvm_component parent); 
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
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
//creating master agent top and slave agent top
  if(e_cfg.has_mtop == 1)begin
    mtop = master_agent_top::type_id::create("mtop",this);
    end
 if(e_cfg.has_stop == 1)begin
    stop = slave_agent_top::type_id::create("stop",this);
  end
//creating virtual sequencer and scoreboard
  if(e_cfg.has_virtual_sequencer==1)begin
      v_sequencer = virtual_sequencer::type_id::create("v_sequencer",this);
  end
 /* if(e_cfg.has_scoreboard == 1)begin
      sb = scoreboard::type_id::create("sb",this);
  end*/

endfunction:build_phase
//--------------------------------------------------------------------------------------
//function:connect phase

//--------------------------------------------------------------------------------------
function void env::connect_phase(uvm_phase phase);

   if(e_cfg.has_virtual_sequencer)
   begin

     	 if(e_cfg.has_mtop==1) 
      	  begin 
	    for(int i=0; i<e_cfg.no_of_magent; i++)
	    begin
	     v_sequencer.m_seqr = mtop.m_agt[i].m_seqrh;
	    // mtop.m_agt[i].m_mon.monitor_port.connect(sb.mfifo[i].analysis_export);
	   end
	 end
			  
	if(e_cfg.has_stop==1) 
         begin
	    for(int i=0; i<e_cfg.no_of_sagent; i++)
	     begin
	     // stop.s_agt[i].s_mon.monitor_port.connect(sb.sfifo[i].analysis_export);
	      v_sequencer.s_seqr = stop.s_agt[i].s_seqrh;
	      end
  	 end
      /*  if(e_cfg.has_scoreboard)
        begin
         mtop.m_agt.monitor_port.connect(sb.analysis_export);
        end*/
   end

endfunction:connect_phase
//--------------------------------------------------------------------------------------
`endif
