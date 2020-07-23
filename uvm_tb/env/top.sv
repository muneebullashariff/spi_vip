module top;
      
  //    import test_pkg::*;
	import uvm_pkg::*;
    
   bit clock;
   bit reset;

    always 
     begin
    	#10 clock=~clock;     
    end

   always
    begin 
      #10 reset=~reset;
     end

  //      spi_if in0(clock);
          spi_if in0(); //by v
 //	dut_wrapper dut_wrapper (spi_if); //v
    
    initial begin
         uvm_config_db #(virtual spi_if)::set(null,"*","vif",in0);

	run_test("base_test");
     end
 

   
endmodule


