module top;
      
        import test_pkg::*;
	import uvm_pkg::*;
    
   bit clock;

    always 
    begin
    	#10 clock=~clock;     
    end
	 
	
    initial begin
        

	run_test("test");
     end
 

   
endmodule


