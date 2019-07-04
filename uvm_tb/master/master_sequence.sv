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

`ifndef _MASTER_SEQUENCE_INCLUDED_
`define _MASTER_SEQUENCE_INCLUDED_


//-----------------------------------------------------------------------------
// Class: master_sequence
//------------------------------------------------------------------------------
class master_sequence extends uvm_sequence #(master_xtn);

//register with factory so can use create uvm_method 
//and override in future if necessary 

  `uvm_object_utils(master_sequence)


//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new(string name = "master_sequence");
 
endclass: master_sequence

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function master_sequence::new(string name="master_sequence"); 
  super.new(name); 
endfunction: new 

//*****************************************************************************
//*****************************************************************************
//class:extended class from the base class

//*****************************************************************************
//*****************************************************************************

class mseq1 extends master_sequence;

//register with factory so can use create uvm_method 
//and override in future if necessary 

 `uvm_object_utils(mseq1)


//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new (string name="mseq1");

extern virtual task body();

endclass:mseq1


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function mseq1::new(string name="mseq1");
	super.new(name);
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//creating request which is will be coming from driver
//-----------------------------------------------------------------------------
task mseq1::body();

	begin

        req=master_xtn::type_id::create("req");
       	repeat(4)
	     begin
		start_item(req);
		assert(req.randomize () with {cpol==0;cpha==0;data_in_mosi==8'b10010010;});
                finish_item(req);
             
	     end
	end
endtask:body
//------------------------------------------------------------------------------

`endif
