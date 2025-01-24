# Task Management Application

A simple task management web application built with ColdFusion, using the ColdBox framework and CBORM (ColdBox ORM). This app allows users to create, update, delete, and track tasks, all managed via a MySQL database.

## Features

- View tasks in a list.
- Create new tasks.
- Update task status (mark as completed).
- Delete tasks with a confirmation modal.
- Built with ColdBox, CBORM, and MySQL.

## Technologies Used

- **ColdFusion** for the backend and server-side logic.
- **ColdBox** for the MVC framework.
- **CBORM** for ORM-based database interaction.
- **MySQL** for database storage of tasks.
- **HTML/CSS** for frontend presentation.
- **JavaScript** (with jQuery) for AJAX functionality and dynamic updates.

## Prerequisites

To get started with this project, you'll need to install the following tools:

### 1. **Install CommandBox**

CommandBox is a CLI tool for CFML development, which is essential for managing ColdFusion applications.

- Download and install CommandBox from [CommandBox website](https://www.ortussolutions.com/products/commandbox).

Once CommandBox is installed, verify it by running:

```bash
commandbox --version
```


### 2. **Install Lucee Server**

Lucee is an open-source CFML engine that will run your ColdFusion applications.

#### Step 1: Download and Install Lucee Server

- Visit the [Lucee Downloads page](https://lucee.org/download/) and download the appropriate installer for your operating system.
- Follow the installation instructions to install Lucee.

#### Step 2: Start Lucee Server

After installation, you can start the Lucee server. The default installation should have the server running automatically. If it's not running, you can manually start it by executing the Lucee server from your system's terminal or using the service manager (depending on your OS).

#### Step 3: Access the Lucee Admin Panel

You can access the Lucee admin panel by navigating to:
- http://localhost:8888/lucee/admin/web.cfm
- http://localhost:8888/lucee/admin/server.cfm

  
This will allow you to manage the Lucee settings and configure your applications.

### 3. **Install MySQL**

Install MySQL to store and manage the application's data.

- Download and install MySQL from [MySQL Downloads](https://dev.mysql.com/downloads/installer/).
- After installation, configure a MySQL database.

### 4. **Install ColdBox Using CommandBox**

ColdBox is an MVC framework for CFML that provides great tools for rapid development.

You can install ColdBox via CommandBox:

```bash
box install coldbox
```

### 5. **Set up ColdBox Application**

Follow the **ColdBox 60-Minute Quick Start** guide to create the basic ColdBox app structure:

- Go to [ColdBox Quick Start](https://coldbox.ortusbooks.com/for-newbies/60-minute-quick-start).
- Follow the instructions to set up your ColdBox application structure. This guide will walk you through the process of creating the required directories and files for your ColdBox application. You will learn to set up:

  - **Handlers**: These are the controllers in ColdBox that handle the request and pass data to views.
  - **Views**: These are the templates that display the data on the front end.
  - **Models**: These represent the data, and often use CBORM for database interaction.
  - **Configurations**: Global configuration files for your ColdBox application (e.g., `ColdBox.cfc`, `config/`).

### 6. **Install CBORM (ColdBox ORM)**

CBORM (ColdBox ORM) will allow you to easily interact with your MySQL database through object-relational mapping.

To install CBORM via CommandBox, run the following command:

```bash
box install cborm
```

### 7. **Clone the Repository**

To get started, clone this repository to your local machine:

```bash
git clone https://github.com/amannautiyal1/tasks.git
```

### 8. **Database Setup**

Before running the application, you'll need to set up your database:

follow this doc - https://docs.google.com/document/d/13azVuClkkPJe-lnF6RG2k2iGERjQ5JVW-tRAIUL9k4o


### 9. **Running the Application**

Once you have set up the database and configured your environment, you can run the application locally:

1. **Start the Lucee Server**

   If the Lucee server is not already running, start it manually. Depending on your installation, you can typically start it via the terminal or command line.

   For CommandBox, you can start the server by navigating to your project folder and running:

   ```bash
   box server start
	```

### Instructions Added:
- **Install Lucee Server** (with detailed steps for downloading, installing, and starting Lucee).
- **Install MySQL** and **Install ColdBox Using CommandBox** sections.
- **Set up ColdBox Application** and **Install CBORM**.
- **Clone the Repository**, **Database Setup**, and **Running the Application** sections
- **refer this doc for more info** - https://docs.google.com/document/d/13azVuClkkPJe-lnF6RG2k2iGERjQ5JVW-tRAIUL9k4o/edit?tab=t.0


