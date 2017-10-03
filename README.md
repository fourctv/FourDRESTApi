# FourDRESTApi
A 4D Component that provides a RESTlike CRUD API for any 4D database.

This components adds a couple of HTTP service entry points to your 4D application. Simply drop the built version of the component into your database's Components folder and follow the instructions below to enable it on your application.

Of course you need to enable and activate 4D Web Server on your application.

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

The Component also requires a couple of methods be present on the host database, and set as *Shared by components and host database*.

* INITGetApplicationVersion - returns current application version
* users_ValidateUser - authenticates a user and password
* users_GetUserOptions - returns authenticated user options
* users_GetUserGroups - returns a list of Groups user belongs to
* LISTGetListOfAllLists - returns a list of all 4D List names
* LISTListToArray - returns all items for a given 4D List
* LISTArrayToList - updates the items of a given 4D List

You can find samples of each of the methods above in the repository's **Samples** folder.


