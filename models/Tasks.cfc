/**
 * I model a Tasks
 */
component  table="tasks" persistent="true"{

	// Properties
	property name="id" fieldtype="id" column="id" generator="native" setter="false";
	property name="task_name" ormtype="string";
	property name="created_at" ormtype="timestamp";
    property name="is_completed" type="boolean" default="false";

	// Validation Constraints
	this.constraints = {
		// Example: age = { required=true, min="18", type="numeric" }
	};

	// Constraint Profiles
	this.constraintProfiles = {
		"update" : {}
	};

	// Population Control
	this.population = {
		include : [],
		exclude : [ "id" ]
	};

	// Mementifier
	this.memento = {
		// An array of the properties/relationships to include by default
		defaultIncludes = [ "*" ],
		// An array of properties/relationships to exclude by default
		defaultExcludes = [],
		// An array of properties/relationships to NEVER include
		neverInclude = [],
		// A struct of defaults for properties/relationships if they are null
		defaults = {
            is_completed = false 
        },
		// A struct of mapping functions for properties/relationships that can transform them
		mappers = {}
	};

	/**
	 * Constructor
	 */
	private function init() {
        super.init(useQueryCaching=false);
        return this;
    }

	/**
	 * Verify if the model has been loaded from the database
	 */
	function isLoaded(){
		return ( !isNull( variables.id ) && len( variables.id ) );
	}


}