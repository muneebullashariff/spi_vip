



	/*Monitor is written by extending uvm_monitor,uvm_monitor is inherited from uvm_component, 
	A monitor is a passive entity that samples the DUT signals through virtual interface and 
	converts the signal level activity to transaction level,monitor samples DUT signals but does not drive them.
	Monitor should have analysis port (TLM port) and virtual interface handle that points to DUT signals*/

	
	/*register with factory so can use create uvm_method and override in
	future if necessary*/


	//declare handle for virtual interface with modport

	//declare handle for master_config class



	/*new constructor method that creates new component/object with
	leaf_instance "string name" and handle to its parent class*/
       


	/*build_phase necessary to get the automatic configuration of fields
	registered in the component by calling super.build_phase(phase)*/

      
	/*call get_config method,if value and the string matches it returns
	the settings made with previous set call,if falied stop the simulation*/ 




	/*connect_phase:processes all port,export and imp connections,
 	assignment of the configuration object vif to monitor virtual interface*/ 


	//run_phase:time consuming phase task to collect data from duv


	
	
	//add report_phase and display the signal values
	
	
