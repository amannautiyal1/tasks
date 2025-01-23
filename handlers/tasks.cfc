/**
 * I am a new handler
 * Implicit Functions: preHandler, postHandler, aroundHandler, onMissingAction, onError, onInvalidHTTPMethod
 */
component extends="coldbox.system.EventHandler"{

	this.prehandler_only 	= "";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";
	this.allowedMethods = {};

	/**
	 * Display a listing of the resource
	 */
	property name="taskService" inject="TaskService";

    any function index( event, rc, prc ){ 
		prc.tasks = taskService.getAll(event,rc,prc);
		// writeOutput(prc.tasks);
        event.setView( "tasks/index" ); 
    }

	any function deleteTask( event, rc, prc ) {
		var taskId = rc.taskId;
		
		if ( isNumeric( taskId ) ) {
			var ans = taskService.deleteTaskById( taskId );
			return {
				"status" : "success",
				"message" : "Task deleted successfully",
				"ans": ans
			}
		} else {
			return {
				"status" : "error",
				"message" : "Invalid task ID"
			};
		}
}
any function markCompleted( event, rc, prc ) {
	var taskId = rc.taskId;
	
	if ( isNumeric( taskId ) ) {
		var ans = taskService.markCompletedById( taskId );
		return {
			"status" : "success",
			"message" : "Task marked completed successfully",
			"ans": ans
		}
	} else {
		return {
			"status" : "error",
			"message" : "Invalid task ID"
		};
	}
}



}

