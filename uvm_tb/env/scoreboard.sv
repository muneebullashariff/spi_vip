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

`ifndef _SCOREBOARD_INCLUDED_
`define _SCOREBOARD_INCLUDED_



//-----------------------------------------------------------------------------
// Class: SCOREBOARD
// Description of the class.
// this class matches the output and input coming from master and slave
// monitor
//
//-----------------------------------------------------------------------------
class scoreboard extends uvm_scoreboard;

//register with factory so can use create uvm_method 
//and override in future if necessary 
`uvm_component_utils(scoreboard)

//declaring handles for tlm analysis fifo

uvm_tlm_analysis_fifo #(slave_xtn) sfifo;
uvm_tlm_analysis_fifo #(master_xtn) mfifo;


//deeclaring handle for env config,master and slave transaction
 
  env_config e_cfg;
  master_xtn m_data;
  slave_xtn  s_data;
/*//declaring cover handles for master and slave transaction
    master_xtn master_cov_data;
    slave_xtn  slave_cov_data;
//cover group
    covergroup fcov1;
      option.per_instance=1;

      SS:coverpoint master_cov_data.ss{
          
            bins s={1'b1};
        }
      MOSI_1:coverpoint master_cov_data.mosi0 {

            bins mosi_1={1'b1};

        }
    MOSI_2:coverpoint master_cov_data.mosi1 {

            bins mosi_1={1'b1};

        }

    MOSI_3:coverpoint master_cov_data.mosi2 {

            bins mosi_2={1'b1};

        }

    MOSI_4:coverpoint master_cov_data.mosi3 {

            bins mosi_3={1'b1};

        }


      endgroup
  covergroup fcov2;
      option.per_instance=1;

      SS:coverpoint master_cov_data.ss{
          
            bins s={1'b1};
        }
      MOSI_1:coverpoint slave_cov_data.mosi0 {

            bins miso_1={1'b1};

        }
    MOSI_2:coverpoint master_cov_data.mosi1 {

            bins miso_1={1'b1};

        }

    MOSI_3:coverpoint master_cov_data.mosi2 {

            bins miso_2={1'b1};

        }

    MOSI_4:coverpoint master_cov_data.mosi3 {

            bins miso_3={1'b1};

        }


      endgroup

*/

//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
extern function new(string name="scoreboard",uvm_component parent); 
extern virtual function void build_phase(uvm_phase phase);
//extern virtual task run_phase(uvm_phase phase);
//extern function void check_data();

endclass:scoreboard


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_mon class object
//
// Parameters:
//  name - instance name of the slave_mon
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function scoreboard::new(string name="scoreboard", uvm_component parent); 
  super.new(name,parent);
  //fcov1=new;
  //fcov2=new;
endfunction:new 

//-----------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
function void scoreboard::build_phase(uvm_phase phase);
 
  super.build_phase(phase);
        if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
           begin
	     `uvm_fatal("CONFIG_ENV","Cannot get() env_config from uvm_config_db. have you set?")
            end
              mfifo=new[e_cfg.no_of_magent];
              sfifo=new[e_cfg.no_of_sagent];

              m_data=new("m_data");
              s_data=new("s_data");

endfunction: build_phase  
/* //-----------------------------------------------------------------------------
// task: send_data
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
task scoreboard::run_phase(uvm_phase phase);

 fork
   forever
    begin
     mfifo.get(m_data);

      `uvm_info("master scoreboard","writing data",UVM_LOW)

     end

     forever
      begin
       sfifo.get(sdata);
       check_data(s_data);
      
          `uvm_info("slave scoreboard","reading data",UVM_LOW)
	end
				
  join_any

    check_data();
endtask:run_phase


//-----------------------------------------------------------------------------
// Function: check_data phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------
function void scoreboard::check_data();
 begin
 
     master_cov_data = m_data;
    	fcov1.sample();
		
     slave_cov_data = m_data;;
    	fcov2.sample();
      begin

/*	if(m_data.mosi0==s_data.miso0)begin
           $display("match1 successful");
        else
          $display("match1 unsuccessfull");
        end

  	if(m_data.mosi1==s_data.miso1)begin
           $display("match2 successful");
        else
         $display("match2 unsuccessfull");
        end

	if(m_data.mosi2==s_data.miso2)begin
           $display("match3 successful");
        else
          $display("match3 unsuccessfull");
        end

	if(m_data.mosi3==s_data.miso3)begin
           $display("match4 successful");
        else
           $display("match4 unsuccessfull");
        end
     end
end
 endfunction */ 
//-----------------------------------------------------------------------------
`endif
