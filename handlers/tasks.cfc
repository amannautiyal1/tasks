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
		 taskService.markCompletedById( taskId );
		return {
			"status" : "success",
			"message" : "Task marked completed successfully"
		}
	} else {
		return {
			"status" : "error",
			"message" : "Invalid task ID"
		};
	}
}


any function addTask( event, rc, prc ) {
	var taskName = rc.task_name;
	
		 var task = taskService.addTask( taskName );
		 event.renderData( 
            data = {
                "status" : "success",
                "task" : {
                    "id" : task.getId(),
                    "task_name" : task.getTask_name(),
                    "is_completed" : task.getIs_completed() ?: false
                }
            },
            type = "json",
            statusCode = 200
        );
}

any function editTask( event, rc, prc ) {
	var taskId = rc.taskId;
	var taskName = rc.task_name;
	
	if ( isNumeric( taskId ) ) {
		 taskService.updateTask( taskId, taskName );
		return {
			"status" : "success",
			"message" : "Task Name updated successfully"
		}
	} else {
		return {
			"status" : "error",
			"message" : "Invalid task ID"
		};
	}
}

}

