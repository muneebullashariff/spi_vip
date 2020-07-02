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

`ifndef _SLAVE_SEQUENCE_INCLUDED_
`define _SLAVE_SEQUENCE_INCLUDED_

//-----------------------------------------------------------------------------
// Class:SLAVE_sequence
//------------------------------------------------------------------------------
class slave_sequence extends uvm_sequence #(slave_xtn);

//register with factory so can use create uvm_method
// and override in future if necessary 
 `uvm_object_utils(slave_sequence)


//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new(string name = "slave_sequence"); 

endclass:slave_sequence

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function slave_sequence::new(string name="slave_sequence"); 
  super.new(name); 
endfunction: new 

//****************************************************************************
//****************************************************************************
//class:extended class from the base class

//*****************************************************************************
//*****************************************************************************

class sseq1 extends slave_sequence;

//register with factory so can use create uvm_method 
//and override in future if necessary 

 `uvm_object_utils(sseq1)


//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new (string name="sseq1");

extern virtual task body();

endclass:sseq1


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function sseq1::new(string name="sseq1");
	super.new(name);
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//creating request which is will be coming from driver
//-----------------------------------------------------------------------------
task sseq1::body();
 req=slave_xtn::type_id::create("req");
   
 repeat(4)
   begin
		start_item(req);
		assert(req.randomize() with {cpol==0;cpha==0;data_in_miso==8'b10010010;});
    finish_item(req);
   end

endtask:body
//------------------------------------------------------------------------------


`endif
