<cfoutput>
    <h1>My Tasks</h1>
    <cfset tasks = prc.tasks>
 
    <!-- Display tasks in a table format -->
    <table>
        <thead>
            <tr>
                <th>Task ID</th>
                <th>Task Name</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <cfscript>
                for (task in tasks) {
                    writeOutput("<tr id='task-row-" & task.id & "'>");
                    writeOutput("<td>" & task.id & "</td>");
                    writeOutput("<td>" & task.task_name & "</td>");
                    // Check if the task is completed
                    // writeOutput("<h1>" & (task.is_completed) & "</h1>");
                    if (!task.is_completed) {
                        writeOutput("<td>Incomplete </td>");
                    } else {
                        writeOutput("<td>Completed</td>");
                    }
                    
                    // Action links
                    writeOutput("<td>");
                    writeOutput('<button type="button" class="btn btn-sm btn-danger" onclick="confirmDelete(' & task.id & ')">Delete</button>');

                    // Mark as Completed button
                    if (!task.is_completed) {
                        writeOutput('<button type="button" class="btn btn-sm btn-success" onclick="confirmMarkCompleted(' & task.id & ')">Mark as Completed</button>');
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
                    $('#confirmationModal').modal('hide');
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
</script>
