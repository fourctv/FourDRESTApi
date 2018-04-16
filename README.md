# 4D RESTApi
A 4D V17.0 BETA Component that provides a REST-like CRUD API for any 4D database.

**This version has been modified to use Collections and ORDA as per 4D V17.0 BETA. USE FOR TESTING AND EVALUATION ONLY**

This component adds a couple of HTTP service entry points to your 4D application. Simply drop the built version of the component into your database's Components folder and follow the instructions below to enable it on your application.

Of course you need to enable and activate 4D Web Server on your application.

This is a 4D V16 Component, so it must be installed on a 4D V16 compatible database structure.

This 4D Component has a companion [Angular Typescript](http://angular.io) library ([**JS44D Library**](https://github.com/fourctv/JS44D/)) that can be used as the middle man between Angular2 apps and a 4D backend. The **JS44D Library** and documentation can be found [here](https://github.com/fourctv/JS44D/).

There is a step by step procedure to get started with the **RESTApi** component at this [wiki page.](https://github.com/fourctv/JS44D/wiki/Let's-Get-Started) That page will instruct you on how to get going on the 4D and Angular sides.

And do not forget to look at additional, detailed, documentation about this Component on the [wiki pages](https://github.com/fourctv/FourDRESTApi/wiki).

# Table of Contents

- [Installation Instructions](#installation-instructions)
- [HTTP Services](#http-services)
- [Session Management and Security](#session-management-and-security)
- [Companion JS44D Libraries](#companion-js44d-libraries)
- [JS44D Data Models](#js44d-data-models)
- [Special Database Fields](#special-database-fields)

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

$0:=RESTOWA ($1;$2;$3;$4;$5;$6) // Call RESTApi On Web Authentication

```
*(code above is also found in the **Samples** directory)*

If you already have a On Web Authentication script, all you need to do is add a call to **RESTOWA** (as above).

The Component also requires a couple of additional methods be present in the host database, and set as *Shared by components and host database*, so they can be called from the Component.

* **[INITGetApplicationVersion](https://github.com/fourctv/FourDRESTApi/blob/master/Samples/INITGetApplicationVersion.txt)** - returns current application version
* **[users_ValidateUser](https://github.com/fourctv/FourDRESTApi/blob/master/Samples/users_ValidateUser.txt)** - authenticates a user and password
* **[users_GetUserOptions](https://github.com/fourctv/FourDRESTApi/blob/master/Samples/users_GetUserOptions.txt)** - returns authenticated user options
* **[users_GetUserGroups](https://github.com/fourctv/FourDRESTApi/blob/master/Samples/users_GetUserGroups.txt)** - returns a list of Groups user belongs to
* **[LISTArrayToList](https://github.com/fourctv/FourDRESTApi/blob/master/Samples/LISTArrayToList.txt)** - updates the items of a given 4D List
* **[LISTGetListOfAllLists](https://github.com/fourctv/FourDRESTApi/blob/master/Samples/LISTGetListOfAllLists.txt)** - returns a list of all 4D List names _(only needed if you want to use the **FourDAdmin** app)_
* **[LISTListToArray](https://github.com/fourctv/FourDRESTApi/blob/master/Samples/LISTListToArray.txt)** - returns all items for a given 4D List _(only needed if you want to use the **FourDAdmin** app)_


You can find samples of each of the methods above in the repository's **Samples** folder. In that folder you can also find a **Samples Database**, which is a 4D Database with those same methods. You can use that to copy over the sample methods accross two 4D instances. (_easier than creating and importing each method_)

The **users_...** methods are needed to authenticate users to your web/mobile app and set their credentials for your application.

The **LIST...** methods are used by the component to access 4D Lists in the host database.

## HTTP Services
The Component makes the following **4DAction** request entry points available:

* **[REST_GetVersion](https://github.com/fourctv/FourDRESTApi/wiki/REST_GetVersion)** - returns the RESTApi library version
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

Documentation on each request can be found on the [wiki](https://github.com/fourctv/FourDRESTApi/wiki).

## Session Management and Security
The component uses its own Session Management and does not depend on 4D's session management, which can even be disabled in the database properties, if not used by your app.

Except for the **REST_GetApplicationVersion** and **REST_Authenticate** requests, all other requests must include a **Session token** and a **payload hash**.

The **Session token** is generated when user authenticates via the **REST_Authenticate** request. **REST_Authenticate** request sends back a JSON response that includes a **Session token** and other user information (options, groups, etc). That **Session token** must then be included in any and all requests to the API.

Each request must also include a **hash** code that is generated from the request payload and is validated by the **RESTOWA** method, during **On Web Authentication**. That will ensure any and all requests received by the components have not been tampered with. Code on the javascript side generates the **hash**, which is then validated on 4D side.

## Companion JS44D Libraries
This 4D Component has a companion [Angular Typescript](http://angular.io) library that can be used as the middle man between Angular2 apps and a 4D backend.

The **JS44D library** can be found [here](https://github.com/fourctv/JS44D). It is fully documented in that project.

The **JS44D Library** includes a series of Angular2 Typescript components and services that simplify the development of web, desktop or mobile applications that interact with the **4D RESTApi Component**.

Among the services in the **JS44D Library** there is a **FourDModel** class, which is a service that implements an interface between Angular apps and a 4D Database, via the use of Data Model classes that map to Tables on 4D side.

Following is a brief description of the Typescript Data Models. For a detailed view on how to use that, please look [here](https://github.com/fourctv/JS44D/).

## JS44D Data Models
One of the key things that enables, and eases, interfacing between Angular and 4D is the ability to map a 4D Database Structure to **[JS44D Data Models](https://github.com/fourctv/JS44D/wiki/Data-Modelling)**. **[JS44D Data Models](https://github.com/fourctv/JS44D/wiki/Data-Modelling)** are instances of the **FourDModel** class.

**4D RESTApi Component** includes a special method that can be used to generate **FourDModel** classes for each table on a 4D Structure. Method **REST_ExportDataModel** can be run from a host database and it'll present a popup for selecting a 4D Table, or all tables, and it'll generate the corresponding **FourDModel** class. A simple way to do it is to create a dummy new method, put a call to **REST_ExportDataModel** and run that method:


![https://gyazo.com/7933411e4ecad26d5246a0d8b5e5f502](https://i.gyazo.com/7933411e4ecad26d5246a0d8b5e5f502.gif) &nbsp;&nbsp;&nbsp;&nbsp;
![https://gyazo.com/25a22035544eb643f22e67726eb724c3](https://i.gyazo.com/25a22035544eb643f22e67726eb724c3.png)

The Typescript class generated by that method (for the table above) will look something like this:

```
import { FourDModel } from '../../js44D/js44D/FourDModel';

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

## Special Database Fields

**4D RESTApi** assumes your database may have some special Fields in all (most) tables, and those fields get some special treatment on **REST_PostData** requests:

1. **Primary Key field**: a field defined as Primary Key in each table is automatically populated on **inserts** (if it is a longint type), and cannot be modified on **updates**
2. **CreationDate**: a field named as **CreationDate** is automatically populated on **inserts**, and cannot be modified on **updates**
3. **UpdateDate** or **LastUpdateDate**: a field named as **UpdateDate** or **LastUpdateDate** is automatically populated on **updates**
4. **TimeStamp**: a field named as **TimeStamp** is automatically populated on **inserts** or **updates**, and it will hold a special Time Stamp string with the following format: "*YYYY/MM/DD;HH:MM:SS;username;client IP address;web process name;current machine owner;current machine name*"

You can change that behaviour, or change the special fields names by modifying the **REST_PostData** method.

You can also enable/disable some special handling of the **TimeStamp** field, to enable additional validation on **updates**. The **TimeStamp** value sent on an **update** request can be matched to the current value in the record to be updated. If values do not match the update will be rejected, on the basis that user might be trying to update an older version of that record. Validation code in **REST_PostData** method is initially disabled, but can be easily enabled by modifying a single line in that method:
```
If (($updateTimeStamp="") | ($updateTimeStamp=$recordTimeStamp) | True)  //  valid time stamp? `------ temporarily disable time stamp validation
```
*(somewhere around line # 160, simply remove `| true` from that statement and the additional validation will be enabled)*

# Contributors 

[<img alt="Julio Carneiro" src="https://avatars1.githubusercontent.com/u/15777910?v=3&s=117" width="117">](https://github.com/fourctv) |
:---: |
[Julio Carneiro](https://github.com/fourctv) |


