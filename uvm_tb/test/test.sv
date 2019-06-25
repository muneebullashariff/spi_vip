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

`ifndef _TEST_
`define _TEST_



//-----------------------------------------------------------------------------
// Class: test
 /*User-defined test is derived from uvm_test, uvm_test is inherited from uvm_component.
	Test defines the test scenario for the testbench,test class contains the environment, 
	configuration properties, class overrides etc.
	A sequence/sequences are created and started in the test*/
//-----------------------------------------------------------------------------
class test extends uvm_test;

  `uvm_component_utils(test)
  
  env envh;
  env_config e_cfg;
  master_agent_config m_cfg[];
  slave_agent_config s_cfg[];

  int no_of_sagent = 1;
  int no_of_magent = 1;
  int has_m_agt = 1;
  int has_s_agt = 1;


  //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------
  extern function new(string name = "test", uvm_component parent); 
  extern function void configuration();
  extern function void build_phase(uvm_phase phase);
  endclass:test 

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the config_template class object
//-----------------------------------------------------------------------------
function test::new(string name = "test", uvm_component parent); 
  super.new(name,parent); 
endfunction: new 


//-----------------------------------------------------------------------------
// Function: config
// Creates the required ports
//-----------------------------------------------------------------------------
function void test::configuration();
  
  uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg);
 
 if(has_m_agt)
  begin

     m_cfg = new[no_of_magent];
     foreach(m_cfg[i])
       begin
         m_cfg[i] = master_agent_config::type_id::create($sformatf("m_cfg[%0d]",i));

       end
     end

    
  if(has_s_agt)
  begin

     s_cfg = new[no_of_sagent];
     foreach(s_cfg[i])
       begin
         s_cfg[i] = slave_agent_config::type_id::create($sformatf("s_cfg[%0d]",i));

       end
     end
		
        e_cfg.no_of_magent = no_of_magent;
        e_cfg.no_of_sagent = no_of_sagent;
									 
        e_cfg.has_m_agt = has_m_agt;
        e_cfg.has_s_agt = has_s_agt;
  endfunction 


//-----------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
function void test::build_phase(uvm_phase phase);
 e_cfg = env_config::type_id::create("e_cfg");

 	if(has_m_agt)
       		e_cfg.m_cfg = new[no_of_magent];
          
	if(has_s_agt)
		e_cfg.s_cfg = new[no_of_sagent];
	
	configuration();
	uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg);
    	super.build();
	envh=env::type_id::create("envh", this);
endfunction

  
 `endif
