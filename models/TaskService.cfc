/**
 * I am a new service
 */
component singleton {

	// DI
	property name="data" type="array";
	property name="taskService" inject="entityService:Tasks";


	/**
	 * Constructor
	 */
	TaskService function init(){
		return this;
	}

	/**
	 * getAll
	 */
	any function getAll(event, rc, prc){
		
		return taskService
        // List all as array of objects
        .list( asQuery=false )
        // Map the entities to mementos
        .map( function( item ){
            return item.getMemento( includes="id" );
        } );
	}

	
	any function deleteTaskById( required numeric taskId ) {
		try{
			var task = taskService.deleteById( taskId ?: '' )
			return task;
				// .delete();
			// Or use the shorthnd notation which is faster
		} catch( any e ){
			return "Error deleting entity: #e.message# #e.detail#";
		}
	
		return "Entity Deleted!";
	}

	function markCompletedById(required numeric taskId) {
		try {
			var task = entityLoadByPK("Tasks", taskId);
			
			if (isNull(task)) {
				throw(type="TaskNotFound", message="Task #taskId# not found");
			}
			task.setIs_completed(true);

			taskService.save(task);

			return task;
		} catch (TaskNotFound e) {
			throw(e);
		} catch (any e) {
			throw(
				type="TaskCompletionError", 
				message=e.message
			);
		}
	}

	function addTask(required taskName) {
		try {
			var task = taskService.new();
        
			// Populate the properties
			task.setTask_name(taskName);
			
			task.setCreated_at(now());
			
			// Save using the entityService
			taskService.save(task);
			
			return task;
		} catch (TaskNotFound e) {
			throw(e);
		} catch (any e) {
			throw(
				type="TaskCompletionError", 
				message=e.message
			);
		}
	}

	
	function updateTask(required numeric taskId, required updatedTaskName) {
		try {
			var task = entityLoadByPK("Tasks", taskId);
			
			if (isNull(task)) {
				throw(type="TaskNotFound", message="Task #taskId# not found");
			}
			task.setTask_name(updatedTaskName);

			taskService.save(task);

			return task;
		} catch (TaskNotFound e) {
			throw(e);
		} catch (any e) {
			throw(
				type="TaskCompletionError", 
				message=e.message
			);
		}
	}
}