
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


`ifndef _ENV_CONFIG_INCLUDED_
`define _ENV_CONFIG_INCLUDED_

import uvm_pkg::*; //v
 



//-----------------------------------------------------------------------------
// Class:env_config
// Description of the class.
//-----------------------------------------------------------------------------
class env_config extends uvm_object;

//register with factory so that we can use create uvm method
// and override in future if necessary
`uvm_object_utils(env_config)

bit has_scoreboard=1;
bit has_m_agt=1;
bit has_s_agt=1;
bit has_mtop=1;
bit has_stop=1;

bit has_virtual_sequencer=1;
master_agent_config  m_cfg[]; 
// slave_agent_config  s_cfg[];

int no_of_magent=1;
int no_of_sagent=1;
int no_of_mtop=1;
int no_of_stop=1;
int no_of_sb=1;

 
//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new(string name="env_config"); 

endclass:env_config

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the  class object
//
// Parameters:
//  name - instance name of the  master_template
//-----------------------------------------------------------------------------
function env_config::new(string name="env_config"); 
  super.new(name); 
endfunction:new 
//-----------------------------------------------------------------------------
`endif

