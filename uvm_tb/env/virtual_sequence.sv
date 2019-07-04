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

`ifndef _VIRTUAL_SEQUENCE_INCLUDED
`define _VIRTUAL_SEQUENCE_INCLUDED


//-----------------------------------------------------------------------------
// Class: VIRTUAL_SEQUENCE
// Description of the class.
// this class contains the handle of actual sequencer pointing towards them
// //-----------------------------------------------------------------------------
class virtual_sequence extends uvm_sequence #(uvm_sequence_item);

//register with factory so can use create uvm_method 
//and override in future if necessary 


`uvm_object_utils(virtual_sequence)

//declaring handles for master and slave sequencer and environment config
   
  master_sequencer m_seqr1;
  slave_sequencer s_seqr1;
  env_config e_cfg;

//declaring virtual sequencer handle
  virtual_sequencer v_sequencer;



//declaring handles for master and slave extended class
  mseq1 m_seq1h;
  sseq1 s_seq1h;


//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new(string name="virtual_sequence", uvm_component parent); 
extern task body();
  
 endclass: virtual_sequence


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_mon class object
//
// Parameters:
//  name - instance name of the virtual_sequencer
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function virtual_sequence::new(string name="virtual_sequence",uvm_component parent); 
  super.new(name); 
endfunction:new 

//-----------------------------------------------------------------------------
// task :body
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------

task virtual_sequence::body();

	if(!uvm_config_db #(env_config)::get(null,get_full_name,"env_config",e_cfg))
         begin
	  `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?")
         end
//declaring no. of  master sequencer in master agent
// and slave sequencer in slave agent
m_seqr1=new[e_cfg.no_of_magent];
s_seqr1=new[e_cfg.no_of_sagent];

//asserting dynamic cast     
assert($cast(v_sequencer,m_seqr1))

 else 
    begin
      `uvm_error("body","error in  $cast of virtual sequencer")
    end
//connecting master sequencer and slave sequencer in env to
// master sequencer and slave sequencer in virtual sequencer 
    m_seqr1=v_sequencer.m_seqr1;

    s_seqr1=v_sequencer.s_seqr1;

endtask:body
//*************************************************************************************
//*************************************************************************************
//extended class from virtual sequence

//*************************************************************************************
//*************************************************************************************
 
class vseq1 extends virtual_sequence;

//register with factory so can use create uvm_method 
//and override in future if necessary 
 `uvm_object_utils(vseq1)

//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------

   
extern function new(string name="vseq1");
extern task body();

endclass:vseq1
//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_mon class object
//
// Parameters:
//  name - instance name of the virtual_sequencer
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
   
function vseq1::new(string name="vseq1");
    super.new(name);
endfunction:new
//------------------------------------------------------------------------------
//task:body
//------------------------------------------------------------------------------
task vseq1::body();
      
    super.body();
//creating master and slave sequence handles here
       m_seq1h=mseq1::type_id::create("m_seq1h");
       s_seq1h=sseq1::type_id::create("s_seq1h");

       fork

	if(e_cfg.has_m_agt)
	begin
	   for(int i=0; i<e_cfg.no_of_magent; i++)
	   begin
	    m_seq1h.start(m_seqr1);
	   end
	end
			

       if(e_cfg.has_s_agt)
        begin
        for(int i=0; i<e_cfg.no_of_sagent; i++)
	begin
	 s_seq1h.start(s_seqr1);
	end
      end
			
  join_any
endtask:body
//---------------------------------------------------------------------------------

`endif
