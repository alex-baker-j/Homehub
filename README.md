![alt text](https://github.com/kmhamasaki/HomeHub/blob/master/homehub.png)

### Kristyn Hamasaki, Alex Baker, Maegan Chew, Nikita Takru, Prathik Rao, Nicholas Wang

# Table of Contents

## [High Level Requirements](#high-level-project-specifications)
## [Technical Specifications](#technical-project-specifications)
## [Deployment](#deployment-document)

# High Level Project Specifications

Our web app is a way for suitemates to clearly communicate with each other regarding recurring household tasks. Right now, many suitemates do not complete their weekly chores and one individual has to take charge as the aggressive leader. The majority of people also use handwritten charts which are proven to be ineffective. With HomeHub, we automate the process in an app and allow all users to coexist in a peaceful manner.

## User Registration
Every user will individually register with HomeHub through a specific Homehub account. If a user is invited to a household and has no registered account, they will be prompted to create a HomeHub account. After that, they can join the household space. 

## Household Space
One user makes the household space and selects from default tasks. The household space has to have a minimum of two users and a maximum of eight users. When a household space is created, the user who creates it will have the option of choosing from a list of default tasks to assign for the household. After the household space is created and people have joined, the tasks will be distributed between the members.

## Guest Mode
If a user is not logged in to a HomeHub account, the app will act as a personal planner. The user will still be able to add tasks and see their schedule, but they will not be able to invite any other users to their household.

## Tasks
### Adding Tasks
Once all the users are in the household space, everyone has the option to add tasks to the household. When users add a weekly task, they are prompted to enter the task name. This will add the task to the task-list.

### Removing Tasks
All users can request to remove tasks at anytime. All other members in the household space are notified and must agree to the change before it is completed. 

### Distributing Tasks
Tasks will be distributed on a rotating basis so that each task is assigned to a different person each week until everyone has completed the task. At the beginning of each week, the tasks will be assigned for the coming week.

### Completing Tasks
When a user finishes a task, they mark the task as completed and their information is recorded.

## Notification Window
To remind users of their tasks, we will implement a notification center that sends each user their tasks at time intervals before it’s due. Additionally, users can anonymously poke other users to remind them of tasks.
		
## Schedule
Each user will have access to a schedule page on the app which will display all of the upcoming tasks for the next week. The user’s own tasks will be highlighted, but they will be able to see the tasks of everyone in the household. 

## Notifications 	
A user will receive an in-app notification at the beginning of the week when the task is assigned. They will also receive a reminder notification one day before the task is due. At the end of the week, everyone will receive a notification of who completed their tasks. So, if a user did not do their task, all their household members will be notified. This incentivises everyone to do their chores on time. 

# Technical Project Specifications

### Hardware Requirements
HomeHub will run on a standard laptop or desktop computer on Google Chrome updated to the latest update.

## Database 
We will use a SQL database to store all data associated with out web app.

### Task Table (set from beginning, doesn’t change)
Primary key taskID (int(2))
Task description (varchar(50))
Active/inactive task (int(1))
### User Table
Primary key username (varchar(30))
Password (varchar(30)) → use external API to hash
Household Name (varchar(30))
Full name (varchar(60))
### Household Table (new table per household, name == householdName)
Primary key username (varchar(30))
Foreign Key taskID (int(2))

## Server
We will use our server to interact with out SQL Database
### Getting data
The server will retrieve the associated household information when a user logs in using the username which is the primary key in out User table.
### Posting data
When a new household is created, a Household table is created for it. The household ID must be unique. Additionally, when a user creates an account, their username must be unique and their information will be stored in a new row in the User table.
### Assigning Tasks
Assigning tasks will be handled mainly by our server modifying the SQL database. In each household table,  since the tasks are assigned on a rotating weekly basis, each taskID will simply be shifted down to the next user at the end of the week. This will produce a rotating effect where each task gets assigned to a new user every time a new week starts. If there are more tasks than there are users, certain tasks will be grouped together so that there are an equal number of task ‘objects’ as there are users. This ensures that each task is assigned to a user at the beginning of the week and that no user will have to repeat the same task until every other user has also completed that task.


## Web Interface
Each page will have a menu bar at the top that allows for navigation to the login, schedule, and notification page.
### Login Page (Landing page) 
The log-in page will have three options:
	1) Sign in form with username and password field (for users who already have a Homehub account created. Successful sign-in will redirect to the home page.
	2) Button to register for an account which redirects to another page where users can create their account by inputting a new password and username (for users who do not have a Homehub account). Upon registration, user will specify whether they are joining an existing house or creating a new house with separate buttons
	3) Button to continue to the app as a guest, which will have very limited functionality (essentially a personal planner, data will not be stored in)

### Schedule Page (Home page)
When a user logs in, they will be redirected to the home page which will display a calendar-like table with all of the household’s assigned tasks for that week. Tasks and users responsible for task will be listed in a table format. There will be checkboxes users can click on for each task once the task is completed. 

### Guest Page
Guest users will be allowed to add their housemates and ask our server to distribute the preset tasks amongst them for a one-time-usage distribution of tasks per housemate.

### Notification Page
Our notification page will have all of our User’s notifications about tasks and any pokes from other Users. It will also let a user poke another user.

### Create Account Page
The create account will allow a new user to create a username that isn’t taken yet and call the server to verify. The user will then be prompted to create a password for their account.

### Create Household Page
The create household page will allow a user to create a household name that has not been taken yet. The user can add any number of different users through their unique usernames. A list of preset tasks will be shown and the user can select which tasks their household will need to include.

# Deployment Document

## Deploying the Front End (Web App)

Once the files have been downloaded from GitHub, the web application will run on your selected browser. 

### Deployment Dependencies
Tomcat 9.0

JDBC

## High Level
1) Open Eclipse with Tomcat and MySQL
2) Clone Homehub from GitHub and import into the Eclipse workspace.
3) Start SQL database.
4) Run HomeHub on localhost!

## Detailed Level
1) Install Eclipse and MySQLWorkbench for your computer. 
2) For MySQLWorkbench, our files are setup to connect to a database called HomeHub using a MySQL username of ‘root’ and a password of ‘password’. You can either match these specifications, or go through the servlet files and change the lines that connect to sql to match your own database.
3) Clone and import our project from GitHub to your Eclipse workspace.
4) Add JDBC .jar to deployment path in Eclipse, make sure it is local.
5) Import the sql file into MySQLWorkbench to set up database structure.
6) Navigate to your workspace and open up the project.
7) Run SignIn.jsp on the server and that should launch the app in your selected browser on local host! If everything is done correctly, you should be able to set up a household and have multiple users join that household from the front-end web application. You can check this to see if the database has updated the users on the backend. 
