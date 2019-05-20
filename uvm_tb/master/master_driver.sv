


	/*Driver is written by extending uvm_driver,uvm_driver is inherited from uvm_component, 
	Methods and TLM port (seq_item_port) are defined for communication between sequencer and driver,
	uvm_driver is a parameterized class and it is parameterized with the type of the request 
	sequence_item and the type of the response sequence_item*/

	
	/*register with factory so can use create uvm_method and override in
	future if necessary*/


	//declare handle for virtual interface with modport

	//declare handle for master_config class



	/*new constructor method that creates new component/object with
	leaf_instance "string name" and handle to its parent class*/
       


	/*build_phase necessary to get the automatic configuration of fields
	registered in the component by calling super.build_phase(phase)*/

      
	/*call get_config method,if value and the straing matches it returns
	the settings made with previous set call,if falied stop the simulation*/ 




       /*connect_phase:processes all port,export and imp connections,
 	assignment of the configuration object vif to driver virtual interface*/ 


	/*run_phase:time consuming phase
	inforever loop get the sequence_item using sequence_item_port,
	call the task to drive stimuli to duv and get_next sequence_item*/


	//add task to drive stimuli accoeding to the protocol
	

	//add report_phase and display the signal values
	
