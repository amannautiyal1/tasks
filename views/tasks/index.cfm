<cfoutput>
    <cfset tasks = prc.tasks>
    <cfset customId = 0>
    <div class="container-fluid">
    <div class="row align-items-center mb-4">
        <div class="col-12 col-md-6">
            <h1 class="h3 mb-3 mb-md-0">My Tasks</h1>
        </div>
        <div class="col-12 col-md-6">
            <div class="d-flex justify-content-md-end">
                <div class="input-group" style="max-width: 400px;">
                    <input type="text" id="newTaskName" class="form-control m-2 mt-0" placeholder="Enter new task name" required>
                    <div class="input-group-append m-2 mt-0">
                        <button type="button" id="addTaskBtn" class="btn btn-primary">Add Task</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Display tasks in a table format -->
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th class="p-2">Task ID</th>
                <th class="p-2">Task Name</th>
                <th class="p-2">Status</th>
                <th class="p-2">Actions</th>
            </tr>
        </thead>
        <tbody>
            <cfscript>
            for (task in tasks) {
                customId++;
                writeOutput("<tr id='task-row-" & task.id & "'>");
                writeOutput("<td>" & customId & "</td>");
                writeOutput("<td>" & task.task_name & "</td>");
                
                if (!task.is_completed) {
                    writeOutput("<td>Incomplete </td>");
                } else {
                    writeOutput("<td>Completed</td>");
                }
                
                // Action links
                writeOutput("<td>");
                writeOutput('<button type="button" class="btn btn-sm btn-danger m-2" onclick="confirmDelete(' & task.id & ')">Delete</button>');
        
                // Mark as Completed button
                if (!task.is_completed) {
                    writeOutput('<button type="button" class="btn btn-sm btn-success m-2" onclick="confirmMarkCompleted(' & task.id & ')">Mark as Completed</button>');
                }
                writeOutput("</td>");
                
                writeOutput("</tr>");
            }
        </cfscript>
        </tbody>
    </table>

    <!-- Confirmation Modal -->
    <div class="modal" id="confirmationModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Deletion</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete this task?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Confirmation Modal -->
<div class="modal" id="complete-confirmationModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">Confirm Action</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="modalMessage">Are you sure you want to perform this action?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" id="confirmActionBtn">Confirm</button>
            </div>
        </div>
    </div>
</div>
</div>
</cfoutput>

<!-- Include jQuery and Bootstrap for the modal and AJAX -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<script>
    let taskToDelete = null;

    // Function to show the confirmation modal and store the task to delete
     // Function to show the confirmation modal and store the task to delete
     function confirmDelete(taskId) {
        taskToDelete = taskId;
        $('#confirmationModal').modal('show');
    }

    // Handle the delete button click inside the modal
    $('#confirmDeleteBtn').click(function() {
        if (taskToDelete) {
            // Send the task deletion request via AJAX (avoid re-querying the database)
            $.ajax({
                url: '/tasks/deleteTask', // Your ColdFusion delete handler URL
                type: 'POST',
                data: {taskId: taskToDelete},
                success: function(response) {
                    // If the deletion was successful, remove the task row from the table
                    if (response.status==='success') {
                        $('#task-row-' + taskToDelete).remove();
                        $('#confirmationModal').modal('hide');
                    } else {
                        alert('Error deleting task.');
                    }
                },
                error: function() {
                    alert('Error deleting task.');
                }
            });
        }
    });

    // Function to show the confirmation modal for marking as completed
    function confirmMarkCompleted(taskId) {
        taskToMarkCompleted = taskId;
        $('#modalTitle').text('Confirm Mark as Completed');
        $('#modalMessage').text('Are you sure you want to mark this task as completed?');
        $('#complete-confirmationModal').modal('show');
    }

    $('#confirmActionBtn').click(function() {

    if (taskToMarkCompleted) {
        // Mark the task as completed
        $.ajax({
            url: '/tasks/markCompleted', // Your ColdFusion markCompleted handler URL
            type: 'PUT',
            data: { taskId: taskToMarkCompleted },
            success: function(response) {
                if (response.status === 'success') {
                    $('#task-row-' + taskToMarkCompleted).find('td:nth-child(3)').text('Completed');
                    $('#task-row-' + taskToMarkCompleted).find('.btn-success').hide();
                    $('#complete-confirmationModal').modal('hide');
                } else {
                    alert('Error marking task as completed.');
                }
                taskToMarkCompleted = null;
            },
            error: function() {
                alert('Error marking task as completed.');
                taskToMarkCompleted = null;
            }
        });
    }
});

$('#addTaskBtn').click(function() {
    const taskName = $('#newTaskName').val().trim();
    
    if (taskName) {
        $.ajax({
            url: '/tasks/addTask', // Your ColdFusion add task handler URL
            type: 'POST',
            data: { task_name: taskName },
            success: function(response) {
                if (response.status === 'success') {
                    // Create new row with the returned task data
                    const newRow = `
                        <tr id="task-row-${response.task.id}">
                            <td>${response.task.id}</td>
                            <td>${response.task.task_name}</td>
                            <td>Incomplete</td>
                            <td>
                                <button type="button" class="btn btn-sm btn-danger m-2" onclick="confirmDelete(${response.task.id})">Delete</button>
                                <button type="button" class="btn btn-sm btn-success m-2" onclick="confirmMarkCompleted(${response.task.id})">Mark as Completed</button>
                            </td>
                        </tr>
                    `;
                    
                    // Add the new row to the table
                    $('table tbody').append(newRow);
                    
                    // Clear the input field
                    $('#newTaskName').val('');
                } else {
                    alert('Error adding task.');
                }
            },
            error: function() {
                alert('Error adding task.');
            }
        });
    }
});

// Also handle Enter key press in the input field
$('#newTaskName').keypress(function(e) {
    if (e.which === 13) { // Enter key
        e.preventDefault();
        $('#addTaskBtn').click();
    }
});
</script>
