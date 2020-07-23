interface spi_if;//(input bit sclk/*,reset*/);
//interface spi_if(input bit sclk,reset);
//interface spi_if(inout bit sclk); //non net variable cannout be inout port  
  
  
  logic sclk;
  logic miso;
  logic mosi;
  logic ss_n;
//  logic sclk;
  logic reset;
  

  //master_drv_cb
  
  clocking master_drv_cb@(posedge sclk);
    output mosi;
    input miso;
    output ss_n;
   // input sclk;
  endclocking
  
  
  //master_mon_cb
  clocking master_mon_cb@(posedge sclk);
    input mosi;
    input miso;
    input ss_n ;
   // input sclk;
  endclocking
       
 clocking slave_drv_cb@(posedge sclk);
    input mosi;
    output miso;
    input ss_n;
  endclocking
  
  
  //slave_mon_cb
  clocking slave_mon_cb@(posedge sclk);
    input mosi;
    input miso;
    input ss_n;
  endclocking 
  
  
  
  
  
 
//  modport MDRV_MP(clocking master_drv_cb,input sclk,reset);
//  modport MMON_MP(clocking master_mon_cb,input sclk,reset);
    
//  modport MDRV_MP(clocking master_drv_cb,inout sclk);
//    modport MMON_MP(clocking master_mon_cb,inout sclk);
    
  modport MDRV_MP(clocking master_drv_cb/*,input sclk,reset*/);
  modport MMON_MP(clocking master_mon_cb/*,input sclk/*,reset*/);
   
//********************************************************    
 // modport SDRV_MP(clocking slave_drv_cb,input sclk,reset);
 // modport SMON_MP(clocking slave_mon_cb,input sclk,reset);
      
      
endinterface    
    

