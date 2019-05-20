

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



	/*new constructor method that creates new component/object with
	leaf_instance "string name" and handle to its parent class*/
       


	/*build_phase necessary to get the automatic configuration of fields
	registered in the component by calling super.build_phase(phase)*/



	/*call get_config method,if value and the straing matches it returns
	the settings made with previous set call,if falied stop the simulation*/ 


	//initilaize the dynamic arrays for master and slave agent_tops


	//inside foreach loop set and create instance of master and slave agent_top


	//create instance of virtual_sequencer


	//create instance of scoreboard


	/*connect phase:connect virtual sequencer sub sequncers to the environment
	master and slave sequencers*/


	/*connect the corresponding analysis port of all the monitors
	to the analysis export pf all the tlm_analysis fifo's in scoreboard*/
