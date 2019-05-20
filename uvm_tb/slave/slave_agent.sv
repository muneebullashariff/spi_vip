


	/*agent is container called universal verification component that contain driver,
	monitor,sequencer*/

	//extend agent class from uvm_agent
	
	
	/*register with factory so can use create uvm_method and override in
	future if necessary*/


	//declare handle for master_agent_config class


	//declare handles for driver,monitor and sequencer



	/*new constructor method that creates new component/object with
	leaf_instance "string name" and handle to its parent class*/
       


	/*build_phase necessary to get the automatic configuration of fields
	registered in the component by calling super.build_phase(phase)*/

      
	/*call get_config method,if value and the straing matches it returns
	the settings made with previous set call,if falied stop the simulation*/ 



	//create the monitor
	


	/*If the agent is made active in master_configuration class create
	driver and sequencer*/


	/*connect_phase:processes all port,export and imp connections,here
	driver sequencer connection is established if agent is active*/ 



	
