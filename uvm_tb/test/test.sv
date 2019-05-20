


	/*User-defined environment is derived from uvm_env, uvm_env is inherited from uvm_component.
	Environment is the container class, It contains one or more agents or agent_tops,
	as well as other components such as scoreboard,checker,virtual sequencer.
	

	//extend agent_top class from uvm_env
	
	
	/*register with factory so can use create uvm_method and override in
	future if necessary*/


	//declare dynamic array of handles for master and slave agent_tops


	//declare handles for virtual sequencer

	
	//declare handles for scoreboard

	
	//declare handle for environment config



	/*User-defined test is derived from uvm_test, uvm_test is inherited from uvm_component.
	Test defines the test scenario for the testbench,test class contains the environment, 
	configuration properties, class overrides etc.
	A sequence/sequences are created and started in the test*/

	
	//class extends uvm_test

	
	/*register with factory so can use create uvm_method and override in
	future if necessary*/


	//declare handles  for env_confgi and environment


	//declare dynamic array of handles for master and slave config classes

	
	//declare local variables to override


	
	/*new constructor method that creates new component/object with
	leaf_instance "string name" and handle to its parent class*/


	/*build_phase necessary to get the automatic configuration of fields
	registered in the component by calling super.build_phase(phase)*/
	

	//initialize the dynamic array of handles for master and slave cfg


	//create instances of master and slave cfg


	/*call get_config method,if value and the straing matches it returns
	the settings made with previous set call,if falied stop the simulation*/ 


	//assign master and slave config handles to env config handle


	//override the is_active and other variables


	//create the config object


	//initialize the dynamic arrays of handles 

	
	//set the config object into uvm_config_db


	//create instance of environment
	


	//extend different classes
       
