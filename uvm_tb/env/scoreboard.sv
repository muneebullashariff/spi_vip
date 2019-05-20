
	/*Scoreboard will check the correctness of the DUT by comparing the DUT output with the expected values. 
	scoreboard will receive the transactions from the Monitors implemented inside agents,
	Monitor and scoreboard will communicate via TLM ports and exports.*/


	//scoreboard is extended from uvm_scoreboard



	/*register with factory so can use create uvm_method and override in
	future if necessary*/

	
	//declare handles for master and slave transactions



	/*new constructor method that creates new component/object with
	leaf_instance "string name" and handle to its parent class*/

	

	/*build_phase necessary to get the automatic configuration of fields
	registered in the component by calling super.build_phase(phase)*/



	/*call get_config method,if value and the straing matches it returns
	the settings made with previous set call,if falied stop the simulation*/ 
	


	//create instances of uvm_tlm_analysis fifos using new
	


	/*in runphase: get data from master and slave monitors and write a task for 
	comparision*/
