# 4D RESTApi
A 4D Component that provides a RESTlike CRUD API for any 4D database.

This component adds a couple of HTTP service entry points to your 4D application. Simply drop the built version of the component into your database's Components folder and follow the instructions below to enable it on your application.

Of course you need to enable and activate 4D Web Server on your application.

This 4D Component has a companion [Angular Typescript](http://angular.io) library that can be used as the middle man between Angular2 apps and a 4D backend. The **JS44D library** can be found [here](https://github.com/fourctv/JS44D/).

# Table of Contents

- [Installation Instructions](#installation-instructions)
- [HTTP Services](#http-services)
- [Session Management and Security](#session-management-and-security)
- [Companion JS44D Libraries](#companion-js44d-libraries)
- [JS44D Data Models](#js44d-data-models)

## Installation Instructions
If you do not have a script set in your **[On Web Authentication](https://github.com/fourctv/FourDRESTApi/blob/master/Samples/On%20Web%20Authentication.txt)** database method you'll have to add one that contains at least the following code, calling the component's method **RESTOWA**:

```
  // ----------------------------------------------------
  // On Web Authentication method 
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

If you already have a On Web Authentication script, all you need is to add a call to **RESTOWA** (as above).

The Component also requires a couple of additional methods be present in the host database, and set as *Shared by components and host database*, so they can be called from the Component.

* **[INITGetApplicationVersion](https://github.com/fourctv/FourDRESTApi/blob/master/Samples/INITGetApplicationVersion.txt)** - returns current application version
* **[users_ValidateUser](https://github.com/fourctv/FourDRESTApi/blob/master/Samples/users_ValidateUser.txt)** - authenticates a user and password
* **[users_GetUserOptions](https://github.com/fourctv/FourDRESTApi/blob/master/Samples/users_GetUserOptions.txt)** - returns authenticated user options
* **[users_GetUserGroups](https://github.com/fourctv/FourDRESTApi/blob/master/Samples/users_GetUserGroups.txt)** - returns a list of Groups user belongs to
* **[LISTGetListOfAllLists](https://github.com/fourctv/FourDRESTApi/blob/master/Samples/LISTGetListOfAllLists.txt)** - returns a list of all 4D List names
* **[LISTListToArray](https://github.com/fourctv/FourDRESTApi/blob/master/Samples/LISTListToArray.txt)** - returns all items for a given 4D List
* **[LISTArrayToList](https://github.com/fourctv/FourDRESTApi/blob/master/Samples/LISTArrayToList.txt)** - updates the items of a given 4D List

You can find samples of each of the methods above in the repository's **Samples** folder.

The **users_...** methods are needed to authenticate users to your web/mobile app and set their credentials for your application.

The **LIST...** methods are used by the component to access 4D Lists in the host database.

## HTTP Services
The Component makes the following **4DAction** request entry points available:

* **[REST_GetApplicationVersion](https://github.com/fourctv/FourDRESTApi/wiki/REST_GetApplicationVersion)** - returns the host application version
* **[REST_Authenticate](https://github.com/fourctv/FourDRESTApi/wiki/REST_Authenticate)** - authenticates a user & password, and enables the other entry points if user is validated
* **[REST_GetRecords](https://github.com/fourctv/FourDRESTApi/wiki/REST_GetRecords)** - returns a list of record data according to a given query and record columns
* **[REST_LoadData](https://github.com/fourctv/FourDRESTApi/wiki/REST_LoadData)** - returns one record data from the database
* **[REST_PostData](https://github.com/fourctv/FourDRESTApi/wiki/REST_PostData)** - inserts, updates or deletes a record in the database
* **[REST_Get4DList](https://github.com/fourctv/FourDRESTApi/wiki/REST_Get4DList)** - returns items for a given 4D List
* **[REST_GetListOf4DLists](https://github.com/fourctv/FourDRESTApi/wiki/REST_GetListOf4DLists)** - returns a list of all 4D Lists in the database
* **[REST_Update4DList](https://github.com/fourctv/FourDRESTApi/wiki/REST_Update4DList)** - updates the items on a 4D List
* **[REST_GetListOfTables](https://github.com/fourctv/FourDRESTApi/wiki/REST_GetListOfTables)** - returns a list of all tables in the database
* **[REST_GetFieldsInTable](https://github.com/fourctv/FourDRESTApi/wiki/REST_GetFieldsInTable)** - returns a list of all field definitions on a given database table

Documentation on each request can be found on the wiki.

## Session Management and Security
The component uses its own Session Management and does not depend on 4D's session management, which can even be disabled in the database properties, if not used by your app.

Except for the **REST_GetApplicationVersion** and **REST_Authenticate** requests, all other requests must include a **Session token** and a **payload hash**.

The **Session token** is generated when user authenticates via the **REST_Authenticate** request. **REST_Authenticate** request sends back a JSON response that includes a **Session token** and other user information (options, groups, etc). That **Session token** must then be included in any and all requests to the API.

Each request must also include a **hash** code that is generated from the request payload and is validated by the **RESTOWA** method, during **On Web Authentication**. That will ensure any and all requests received by the components have not been tampered with. Code on the javascript side generates the **hash**, which is then validated on 4D side.

## Companion JS44D Libraries
This 4D Component has a companion [Angular Typescript](http://angular.io) library that can be used as the middle man between Angular2 apps and a 4D backend.

The **JS44D library** can be found [here](https://github.com/fourctv/JS44D). It is fully documented in that project.

The **JS44D Library** includes a series of Angular2 Typescript components and services that simplify the development of web, desktop or mobile applications that interact with the **4D RESTApi Component**.

Among the services in the **JS44D Library** there is a **JSFourDModel** class, which is a service that implements an interface between Angular apps and a 4D Database, via the use of Data Model classes that map to Tables on 4D side.

Following is a brief description of the Typescript Data Models. For a detailed view on how to use that, please look [here](https://github.com/fourctv/JS44D/).

## JS44D Data Models
One of the key things that enables, and eases, interfacing between Angular and 4D is the ability to map a 4D Database Structure to **JS44D Data Models**. **JS44D Data Models** are instances of the **JSFourDModel** class.

**4D RESTApi Component** includes a special method that can be used to generate **JSFourDModel** classes for each table on a 4D Structure. Method **REST_ExportDataModel** can be run from a host database and it'll present a popup for selecting a 4D Table, or all tables, and it'll generate the corresponding **JSFourDModel** class. A simple way to do it is to create a dummy new method, put a call to **REST_ExportDataModel** and run that method:


![https://gyazo.com/7933411e4ecad26d5246a0d8b5e5f502](https://i.gyazo.com/7933411e4ecad26d5246a0d8b5e5f502.gif) &nbsp;&nbsp;&nbsp;&nbsp;
![https://gyazo.com/25a22035544eb643f22e67726eb724c3](https://i.gyazo.com/25a22035544eb643f22e67726eb724c3.png)

The Typescript class generated by that method (for the table above) will look something like this:

```
import { FourDModel } from '../../js44D/js44D/JSFourDModel';

export class Location extends FourDModel {

	public static kTABLE:string = 'Location';
	public static kRecordID:string = 'Location.RecordID';
	public static kCreationDate:string = 'Location.CreationDate';
	public static kLastUpdateDate:string = 'Location.LastUpdateDate';
	public static kTimeStamp:string = 'Location.TimeStamp';
	public static kLocationName:string = 'Location.LocationName';
	public static kCity:string = 'Location.City';
	public static kCountry:string = 'Location.Country';
	public static kGeoLocation:string = 'Location.GeoLocation';
	public static kLocale:string = 'Location.Locale';

	tableName:string = 'Location';
	tableNumber:number = 2;
	primaryKey_:string = 'RecordID';
	fields:Array<any> = [
		{name:'RecordID', longname:'Location.RecordID', type:'number', required:true, readonly:true, indexed:true, unique:true},
		{name:'CreationDate', longname:'Location.CreationDate', type:'Date'},
		{name:'LastUpdateDate', longname:'Location.LastUpdateDate', type:'Date'},
		{name:'TimeStamp', longname:'Location.TimeStamp', type:'string', length:255},
		{name:'LocationName', longname:'Location.LocationName', type:'string', length:255, indexed:true},
		{name:'City', longname:'Location.City', type:'string', length:255},
		{name:'Country', longname:'Location.Country', type:'string', length:255},
		{name:'GeoLocation', longname:'Location.GeoLocation', type:'string', length:255},
		{name:'Locale', longname:'Location.Locale', type:'string', length:5}
	];

	get RecordID():number {return this.get('RecordID');}
	set RecordID(v:number) {this.set('RecordID',v);}

	get CreationDate():Date {return this.get('CreationDate');}
	set CreationDate(v:Date) {this.set('CreationDate',new Date(<any>v));}

	get LastUpdateDate():Date {return this.get('LastUpdateDate');}
	set LastUpdateDate(v:Date) {this.set('LastUpdateDate',new Date(<any>v));}

	get TimeStamp():string {return this.get('TimeStamp');}
	set TimeStamp(v:string) {this.set('TimeStamp',v);}

	get LocationName():string {return this.get('LocationName');}
	set LocationName(v:string) {this.set('LocationName',v);}

	get City():string {return this.get('City');}
	set City(v:string) {this.set('City',v);}

	get Country():string {return this.get('Country');}
	set Country(v:string) {this.set('Country',v);}

	get GeoLocation():string {return this.get('GeoLocation');}
	set GeoLocation(v:string) {this.set('GeoLocation',v);}

	get Locale():string {return this.get('Locale');}
	set Locale(v:string) {this.set('Locale',v);}


}
```

Now go check the [wiki here](https://github.com/fourctv/FourDRESTApi/wiki) in this project for documentation on each HTTP Service provided by this Component.

# Contributors 

[<img alt="Julio Carneiro" src="https://avatars1.githubusercontent.com/u/15777910?v=3&s=117" width="117">](https://github.com/fourctv) |
:---: |
[Julio Carneiro](https://github.com/fourctv) |


