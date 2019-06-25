

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


`ifndef _SLAVE_XTN_
`define _SLAVE_XTN_







//-----------------------------------------------------------------------------
// Class: slave_xtn
// Description of the class.
// This class holds the data items reqquired to drive stimulus to duv
// and also holds methods that manipulate those data items
//-----------------------------------------------------------------------------
class slave_xtn extends uvm_sequence_item;

//register with factory so that we can use create uvm method and override in future if necessary
  `uvm_object_utils(slave_xtn)

 
  //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------
  extern function new(string name="slave_xtn"); 
  extern function void do_print(uvm_printer printer);
endclass:slave_xtn

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the  class object
//
// Parameters:
//  name - instance name of the  master_template
//-----------------------------------------------------------------------------
function slave_xtn::new(string name="slave_xtn"); 
  super.new(name); 
endfunction:new 

//-----------------------------------------------------------------------------
// Function: do_print
//print method can be added to display the data members values
//-----------------------------------------------------------------------------
function void slave_xtn::do_print(uvm_printer printer);
  super.do_print(printer);

   
endfunction:do_print

`endif

