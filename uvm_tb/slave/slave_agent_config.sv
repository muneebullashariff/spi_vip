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

`ifndef _SLAVE_AGENT_CONFIG_INCLUDED_
`define _SLAVE_AGENT_CONFIG_INCLUDED_


//-----------------------------------------------------------------------------
// Class: SLAVE_AGENT_CONFIG
// Description of the class.
// this class is used to get env_config and set the agent config
//-----------------------------------------------------------------------------
class slave_agent_config extends uvm_object;

//register with factory so can use create uvm_method 
//and override in future if necessary 
  `uvm_object_utils(slave_agent_config)

//declare handles for virtual interface
   virtual spi_if vif;

//declaring agent is active or passive
  uvm_active_passive_enum is_active= UVM_ACTIVE;

//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new(string name="slave_agent_config"); 

endclass:slave_agent_config



 
//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_mon class object
//
// Parameters:
//  name - instance name of the slave_mon
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function slave_agent_config::new(string name="slave_agent_config"); 
  super.new(name); 
endfunction: new 
//-----------------------------------------------------------------------------

`endif
