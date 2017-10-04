# 4D RESTApi
A 4D Component that provides a RESTlike CRUD API for any 4D database.

This components adds a couple of HTTP service entry points to your 4D application. Simply drop the built version of the component into your database's Components folder and follow the instructions below to enable it on your application.

Of course you need to enable and activate 4D Web Server on your application.

## Installation Instructions
If you do not have a script set in the **On Web Authentication** database method you'll have to add one that contains at least the following code, calling the component's method **RESTOWA**:

```
  // ----------------------------------------------------
  // On Web Athentication method 
  //
  // Parameters:
  //     $1: URL
  //     $2: HTTP Header
  //     $3: Client IP
  //     $4: Server IP
  //     $5: user
  //     $6: password
  //
  // Return:
  //     $0 = true: request is valid and allowed
  //
  // Assumptions:
  //
  //
  // ----------------------------------------------------
  //
C_BOOLEAN($0)
C_TEXT($1;$2;$3;$4;$5;$6)

  //--- copy parameters to locals

  //--- locals

  //--- code

RESTOWA ($1;$2;$3;$4;$5;$6) // Call RESTApi On Web Authentication

```
*(code above is also found in the **Samples** directory)*

The Component also requires a couple of methods be present in the host database, and set as *Shared by components and host database*.

* INITGetApplicationVersion - returns current application version
* users_ValidateUser - authenticates a user and password
* users_GetUserOptions - returns authenticated user options
* users_GetUserGroups - returns a list of Groups user belongs to
* LISTGetListOfAllLists - returns a list of all 4D List names
* LISTListToArray - returns all items for a given 4D List
* LISTArrayToList - updates the items of a given 4D List

You can find samples of each of the methods above in the repository's **Samples** folder.

The **users_...** methods are needed to authenticate users and set their credentials for your application.

The **LIST...** methods are used by the component to access 4D Lists in the host database.

## HTTP Services
The Component makes the following **4DAction** request entry points available:

* REST_GetApplicationVersion - returns the host application version
* REST_Authenticate - authenticates a user & password, and enables the other entry points if user is validated
* REST_GetRecords - returns a list of record data according to a given query and record columns
* REST_LoadData - returns one record data from the database
* REST_PostData - inserts, updates or deletes a record in the database
* REST_Get4DList - returns items for a given 4D List
* REST_GetListOf4DLists - returns a list of all 4D Lists in the database
* REST_Update4DList - updates the items on a 4D List
* REST_GetListOfTables - returns a list of all tables in the database
* REST_GetFieldsInTable - returns a list of all field definitions on a given database table

Documentation on each request can be found on the wiki.

## Session Management and Security
The component uses its own Session Management and does not depend on 4D's own session management, which can even be disabled in the database properties, if not used by your app.

Except for the **REST_GetApplicationVersion** and **REST_Authenticate** requests, all other requests must include a **Session token** and a **payload hash**.

The **Session token** is generated when user authenticates via the **REST_Authenticate** request. **REST_Authenticate** request sends back a JSON response that includes a **Session token** and other user information (options, groups, etc). That **Session token** must be included in any and all requests to the API.

Each request must also include a **hash** code that is generated from the request payload and is validated by the **RESTOWA** method, during **On Web Authentication**. That will ensure any and all requests received by the components have not been tampered with. Code on the javascript side generates the **hash**, which is then validated on 4D side.