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

`ifndef _VIRTUAL_SEQUENCER_INCLUDED
`define _VIRTUAL_SEQUENCER_INCLUDED


//-----------------------------------------------------------------------------
// Class: VIRTUAL_SEQUENCER
// Description of the class.
// this class contains the handle of actual sequencer pointing towards them
// //-----------------------------------------------------------------------------
class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

//register with factory so can use create uvm_method 
//and override in future if necessary 


`uvm_component_utils(virtual_sequencer)

//declaring handles for master and slave sequencer and environment config
   
 master_sequencer m_seqr;
 slave_sequencer s_seqr;

 env_config e_cfg;

//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new(string name="virtual_sequencer", uvm_component parent); 
extern function void build_phase(uvm_phase phase);
  
endclass:virtual_sequencer


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_mon class object
//
// Parameters:
//  name - instance name of the virtual_sequencer

//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function virtual_sequencer::new(string name="virtual_sequencer", uvm_component parent); 
  super.new(name,parent); 
endfunction: new 

//-----------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
function void virtual_sequencer::build_phase(uvm_phase phase);
 
  super.build_phase(phase);
        if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
        begin
          `uvm_fatal("config","cannot get() e_cfg from uvm_config_db.have you set it ?")
         end
  m_seqr=new[e_cfg.no_of_magent];
  s_seqr=new[e_cfg.no_of_sagent];

endfunction:build_phase 
//------------------------------------------------------------------------------- 
`endif
 
