/**
 * This is your application router.  From here you can controll all the incoming routes to your application.
 *
 * https://coldbox.ortusbooks.com/the-basics/routing
 */
component {

	function configure(){
		/**
		 * --------------------------------------------------------------------------
		 * Router Configuration Directives
		 * --------------------------------------------------------------------------
		 * https://coldbox.ortusbooks.com/the-basics/routing/application-router#configuration-methods
		 */
		setFullRewrites( true );

		/**
		 * --------------------------------------------------------------------------
		 * App Routes
		 * --------------------------------------------------------------------------
		 * Here is where you can register the routes for your web application!
		 * Go get Funky!
		 */

		// A nice healthcheck route example
		route( "/healthcheck", function( event, rc, prc ){
			return "Ok!";
		} );

		// A nice healthcheck route example
		route( "/debug", function( event, rc, prc ){
			
			return rc;
		} );

		// A nice RESTFul Route example
		route( "/api/echo", function( event, rc, prc ){
			return { "error" : false, "data" : "Welcome to my awesome API!" };
		} );

		// @app_routes@

		// Restuful Route
		route( "/api/contacts" )
		.as( "api.contacts" )
		.rc( "format", "json" )
		.to( "contacts.data" );

		route( "/tasks/deleteTask")
		.rc( "format", "json" )
		.to( "tasks.deleteTask" );

		route( "/tasks/markCompleted")
		.rc( "format", "json" )
		.to( "tasks.markCompleted" );

		route( "/tasks/addTask")
		.rc( "format", "json" )
		.to( "tasks.addTask" );

		
		route( "/tasks/editTask")
		.rc( "format", "json" )
		.to( "tasks.editTask" );

		// Default Route
		route( ":handler/:action?" ).end();
	}

}
