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

`ifndef _MASTER_SEQUENCER_INCLUDED_
`define _MASTER_SEQUENCER_INCLUDED_


//------------------------------------------------------------------------------
// Class: master_sequencer
//------------------------------------------------------------------------------
class master_sequencer extends uvm_sequencer #(master_xtn);

//register with factory so can use create uvm_method
// and override in future if necessary 

 `uvm_component_utils(master_sequencer)


//----------------------------------------------------------------------------
// Externally defined tasks and functions
//----------------------------------------------------------------------------
extern function new(string name = "master_sequencer", uvm_component parent); 

endclass: master_sequencer

//-------------------------------------------------------------------------------
// Constructor: new
// Initializes the master_sequencer class component
//
// Parameters:
//  name - instance name of the config_template
//  parent - parent under which this component is created
//-------------------------------------------------------------------------------
function master_sequencer::new(string name="master_sequencer", uvm_component parent); 
  super.new(name,parent); 
endfunction: new 
//-------------------------------------------------------------------------------
`endif
