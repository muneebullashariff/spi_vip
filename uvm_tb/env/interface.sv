
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


`ifndef _INTERFACE_INCLUDED_
`define _INTERFACE_INCLUDED_

//-----------------------------------------------------------------------------
// Class:Interface
// Description of the class
//-----------------------------------------------------------------------------

interface spi_if;

// signals
  logic reset;
  
   logic ss_n;   
   logic sclk; 
   logic mosi;
   logic miso;

/*   

   //master out slave in
   logic mosi;
   logic mosi1;
   logic mosi2;
   logic mosi3;  
              
   //master in slave out
   logic miso;
    logic miso1;
   logic miso2;
   logic miso3;

//clocking block for master driver
clocking mdr_cb @(posedge sclk);
//input and output skews
default input #1 output #0;
//signals from master to slave
     output ss_n;
     output mosi;
     
   output mosi1;
     output mosi2;
     output mosi3;

endclocking 

//clocking block for slave driver
clocking sdr_cb @(posedge sclk);
//input and output skews
default input #1 output #0;
//signals from slave to master  
     output ss_n;
     output miso;
    output miso1;
     output miso2;
     output miso3;

endclocking 

//clocking block for master monitor
clocking mmon_cb @(posedge sclk);
//input and output skews  
default input #1 output #0 ;
//signals from master to slave
  input mosi;
 input mosi1;
  input mosi2;
  input mosi3;

endclocking

//clocking block for slave monitor
clocking smon_cb @(posedge sclk);
//input and output skews  
default input #1 output #0 ;
//signals from slave to  master
  input miso;
 input miso1;
  input miso2;
  input miso3

endclocking*/

//declaring modports for master driver and monitor
modport MDR_CB (output sclk,ss_n,mosi, input miso);
modport MMON_CB (input sclk,ss_n,mosi,miso);

//declaring modports for slave driver and monitor
modport SDR_CB (output miso,input sclk,ss_n,mosi);
modport SMON_CB (input sclk,ss_n,mosi,miso);


endinterface: spi_if 
