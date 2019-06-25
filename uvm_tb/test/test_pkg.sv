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

`ifndef _TEST_PKG_INCLUDED_
`define _TEST_PKG_INCLUDED_

//-----------------------------------------------------------------------------
// package:test_pkg
//set of declarations
//all the filess needed for the verification are included in the package
//-----------------------------------------------------------------------------

package test_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
	
    `include "master_xtn.sv"
    `include "master_agent_config.sv"
    `include "slave_agent_config.sv"
    `include "env_config.sv"
    `include "master_driver.sv"
    `include "master_monitor.sv"    
    `include "master_sequencer.sv"
    `include "master_agent.sv"
    `include "master_agent_top.sv"
    `include "master_sequence.sv"

    `include "slave_xtn.sv"
    `include "slave_monitor.sv"
    `include "slave_sequencer.sv"
    `include "slave_sequence.sv"
    `include "slave_driver.sv"
    `include "slave_agent.sv"
    `include "slave_agent_top.sv"

   
    //`include "scoreboard.sv"

    `include "env.sv"


    `include "test.sv"

endpackage
