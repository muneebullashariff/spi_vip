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

`ifndef _SLAVE_SEQUENCER_INCLUDED_
`define _SLAVE_SEQUENCER_INCLUDED_


//-----------------------------------------------------------------------------
// Class: SLAVE_SEQUENCER
// Description of the class.
// This class sends transaction from sequence to driver through tlm ports

//-----------------------------------------------------------------------------
   class slave_sequencer extends uvm_sequencer #(slave_xtn);

//register with factory so can use create uvm_method
// and override in future if necessary 


  `uvm_component_utils(slave_sequencer)


//---------------------------------------------
// Externally defined  function
//---------------------------------------------
extern function new(string name="slave_sequencer", uvm_component parent);

endclass :slave_sequencer

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_sequencer class object
//
// Parameters:
//  name - instance name of the slave_sequencer
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function slave_sequencer::new(string name="slave_sequencer", uvm_component parent); 
  super.new(name,parent); 
endfunction:new 

//---------------------------------------------------------------------------------
`endif

