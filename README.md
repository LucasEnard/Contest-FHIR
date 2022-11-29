# 1. Contest-FHIR

*** CSV TO FHIR TO SQL TO JUPYTER ***

This is a full python IRIS production that gather information from a csv, use a DataTransformation to make it into a FHIR object, save that information to a FHIR server.
From here we can use the SQL BUILDER TOOL to transform our FHIR DataBase to a SQL DataBase in order to analyze or to implement machine learning. 
For the latter, we can use the implemented JUPYTER connection to our server that will help use get all the information from our FHIR server to a DataFrame Pandas in Python notebook.
From here doing machine learning is quite easy !!!

In conclusion, in a few clicks you'll be able to transform your CSV to a FHIR server, then to an SQL server then analyze this server using Pandas in Jupyter Python !


This use interop, FHIR, SQL, and Jupyter.
The objective is to help people understand how easy it is to use FHIR.
I didn't have the time to create a csv about women's health, but you can easily imagine this application using a csv on Women's Health.

- [1. Contest-FHIR](#1-contest-fhir)
- [2. Prerequisites](#2-prerequisites)
- [3. Installation](#3-installation)
  - [3.1. Installation for development](#31-installation-for-development)
  - [3.2. Management Portal and VSCode](#32-management-portal-and-vscode)
  - [3.3. Having the folder open inside the container](#33-having-the-folder-open-inside-the-container)
- [4. FHIR server](#4-fhir-server)
- [5. Walkthrough](#5-walkthrough)
  - [5.1. CSV TO FHIR](#51-csv-to-fhir)
    - [5.1.1. FHIR ?](#511-fhir-)
  - [5.2. FHIR TO SQL](#52-fhir-to-sql)
    - [5.2.1. FHIR ANALYSIS](#521-fhir-analysis)
    - [5.2.2. FHIR PROJECTION](#522-fhir-projection)
    - [5.2.3. PROJECTION TO SQL](#523-projection-to-sql)
    - [5.2.4. SQL ?](#524-sql-)
  - [5.3. SQL TO JUPYTER](#53-sql-to-jupyter)
- [6. Creation of a new DataTransformation](#6-creation-of-a-new-datatransformation)
- [7. What's inside the repo](#7-whats-inside-the-repo)
  - [7.1. Dockerfile](#71-dockerfile)
  - [7.2. .vscode/settings.json](#72-vscodesettingsjson)
  - [7.3. .vscode/launch.json](#73-vscodelaunchjson)

# 2. Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

If you work inside the container, as seen in [3.3.](#33-having-the-folder-open-inside-the-container), you don't need to install fhirpy and fhir.resources.<br>

If you are not inside the container, you can use `pip` to install `fhirpy` and `fhir.resources`.<br> Check [fhirpy](https://pypi.org/project/fhirpy/#resource-and-helper-methods) and [fhir.resources](https://pypi.org/project/fhir.resources/) for morte information.


# 3. Installation

## 3.1. Installation for development

Clone/git pull the repo into any local directory e.g. like it is shown below:
```
git clone https://github.com/LucasEnard/fhir-client-python.git
```

Open the terminal in this directory and run:

```
docker-compose up --build
```

This will create the IRIS Framework and the FHIR Server.

Once you are done building enter the Management portal, open the interop tab, open the Production and start it.

Now you will see that the CSV was automatically read from your local files and added to the FHIR server.

This app will periodically read any csv inside the "csv" folder and will send it to the FHIR server, doing the Data Transformation needed.

## 3.2. Management Portal and VSCode

This repository is ready for [VS Code](https://code.visualstudio.com/).

Open the locally-cloned `Contest-FHIR` folder in VS Code.

If prompted (bottom right corner), install the recommended extensions.

## 3.3. Having the folder open inside the container
You can be *inside* the container before coding if you wish.<br>
For this, docker must be on before opening VSCode.<br>
Then, inside VSCode, when prompted (in the right bottom corner), reopen the folder inside the container so you will be able to use the python components within it.<br>
The first time you do this it may take several minutes while the container is readied.

If you don't have this option, you can click in the bottom left corner and `press reopen in container` then select `From Dockerfile`

[More information here](https://code.visualstudio.com/docs/remote/containers)

![Architecture](https://code.visualstudio.com/assets/docs/remote/containers/architecture-containers.png)

<br><br><br>

By opening the folder remote you enable VS Code and any terminals you open within it to use the python components within the container.

# 4. FHIR server

To complete this walktrough we will use a fhir server.<br>
This fhir server was already build-in when you cloned and build the container.

The url is `localhost:52773/fhir/r4` inside the container and `localhost:33783/fhir/r4` on your machine.

# 5. Walkthrough
Complete walkthrough of the Python IRIS production.

## 5.1. CSV TO FHIR

Here you must use the ProductionCSV and change the parameters if needed to transform any CSV file added to the `data/in` folder to your FHIR server.

This link will help you load the ProductionCSV, change the parameters if needed and start it :<br>
`http://localhost:33783/csp/healthshare/fhirserver/EnsPortal.ProductionConfig.zen?$NAMESPACE=FHIRSERVER&$NAMESPACE=FHIRSERVER&`

Connect using :<br>
username : `superuser`<br>
password : `SYS`

Go to `Action` in the far right menu, then click `Open` then choose `Python` and `ProducitonCSV` !

Now START the production.

Just by loading it and starting it, the production should automatically load a really simple csv file containing information on some organizations to our FHIR server.


**Note** :<br>
If you want to do it with others fhir resources [you need to create a new Data Transfomation](#6-creation-of-a-new-datatransformation) and create a new message type.

### 5.1.1. FHIR ?
We now have a FHIR server ( That was pre-filled with random generated Organization and Patient ) that also contains our 2 new organizations !!
All that from a simple click in the Production.

## 5.2. FHIR TO SQL


Here we will use a powerful InterSystems tool that allows us to transform any FHIR server to an SQL server and perform some more transformation on the data if needed !<br>
For that follow :<br>
`http://localhost:33783/csp/fhirsql/index.csp/`

Connect using :<br>
username : `superuser`<br>
password : `SYS`

We will now create an analysis of our FHIR repo, then a projection, and finally we will convert it to SQL.

### 5.2.1. FHIR ANALYSIS

![1](https://user-images.githubusercontent.com/77791586/204558884-9c3b51e1-16de-441d-9ad5-aff0e6ad2109.jpg)


![2](https://user-images.githubusercontent.com/77791586/204558942-197dbb4c-0cb0-48ce-b69c-a61212f137c2.jpg)

Here, enter :

Name : Local_FHIR

Host : localhost

Port : 52773

SSL conf : *don't touch*

Credentials : Press new and add a new credentials like <br>
name : `superuser`<br>
username : `superuser`<br>
password : `SYS`

FHIR Repository URL : /fhir/r4

And press OK.

Now enter 100 in `Selectivity Percentage` and press `Launch Analysis Task`.


**Note**<br>
It's possible to use any FHIR server here, and the configuration given in this GitHub is just for our InterSystems local FHIR server ( Note that you could use also a cloud InterSystems FHIR server )

### 5.2.2. FHIR PROJECTION

![3](https://user-images.githubusercontent.com/77791586/204559000-7cfb456b-334c-4f3a-8364-f2387ae4c4bc.jpg)


We have prepared a simple and easy projection from FHIR to SQL.<br>
Click `import` and select `Contest-FHIR/misc/ExportFHIRtoSQL.json`.

Select :

Name : T1

Analysis : Local_FHIR

Press `Import`.

### 5.2.3. PROJECTION TO SQL

![4](https://user-images.githubusercontent.com/77791586/204559031-c5061cb7-8cbf-4432-8625-8ca8fd9dc272.jpg)


Then press `Launch Projection`

### 5.2.4. SQL ?

We now have an SQL server ( That was pre-filled with random generated Organization and Patient ) that also contains our 2 new organizations !!
All that from simples steps using the FHIR SQL BUILDER from InterSystems.

You can access the SQL server following this link :
`http://localhost:33783/csp/sys/exp/%25CSP.UI.Portal.SQL.Home.zen?$NAMESPACE=FHIRSERVER`

See also :

![5](https://user-images.githubusercontent.com/77791586/204559061-e1a65630-ccc0-4c03-a9f1-78629d9e8bb7.jpg)


You can clearly see the generated information presented here but also our two Organization added in the beginning.

## 5.3. SQL TO JUPYTER

Now that we have done CSV to FHIR to SQL, we need to gather the information from this SQL server to our Jupyter NoteBook.

For that follow this link :<br>
`http://localhost:8888/notebooks/SqlAlchemy.ipynb`

From here, you can, using the incredible `sqlalchemy` tool, plug into our SQL IRIS DataBase and 'play' with our data while having everything protected and stored in FHIR, the future of the Health industry storage.

![6](https://user-images.githubusercontent.com/77791586/204559085-9d6e3f83-31d2-4ba8-ac2d-4a3666507e57.jpg)

You can easily imagine plugging behind this a Machine Learning model, or a deep analysis of our data using all the wonderful Python tools.


# 6. Creation of a new DataTransformation
This repository is ready to code in VSCode with InterSystems plugins.
Open `/src/python` to start coding or using the autocompletion.

**Steps to create a new transformation**<br>
To add a new transformation and use it, the only things you need to do is add your csv named `Patient.csv` ( for example ) in the `src/python/csv` folder.<br>
Then, create an object in `src/python/obj.py` called `BasePatient` that map your csv.<br>
Now create a request in `src/python/msg.py` called `PatientRequest` that has a variable `resource` typed BasePatient.<br>
The final step is the DataTransformation, for this, go to `src/python/bp.py` and add your DT. First add `if isinstance(request, PatientRequest):` and then map your request resource to a fhir.resource Patient.<br>
Now if you go into the management portal and change the setting of the `ServiceCSV` to add `filename=Patient.csv` you can just start the production and see your transformation unfold and you client send the information to the server.

**Detailled steps to create a new transformation**<br>
If you are unsure of what to do or how to do it here is a step by step creation of a new transformation :

Create the file `Patient.csv` n the `src/python/csv` folder and fill it with:
```
family;given;system;value
FamilyName1;GivenName1;phone;555789675
FamilyName2;GivenName2;phone;023020202
```
Our CSV hold a family name, a given name and a phone number for two patients.

<br><br>

In `src/python/obj.py` write :
```python
@dataclass
class BasePatient:
    family:str = None
    given:str = None
    system:str = None
    value:str = None
```

<br><br>

In `src/python/msg.py` write:
```python
from obj import BasePatient
@dataclass
class PatientRequest(Message):
    resource:BasePatient = None
```

<br><br>

In `src/python/bp.py` write:
```python
from msg import PatientRequest
from fhir.resources.patient import Patient
from fhir.resources.humanname import HumanName
```

In `src/python/bp.py` in the `on_request` function write:
```python
if isinstance(request,PatientRequest):
    base_patient = request.resource

    patient = Patient()

    name = HumanName()
    name.family = base_patient.family
    name.given = [base_patient.given]
    patient.name = [name]

    telecom = ContactPoint()
    telecom.value = base_patient.value
    telecom.system = base_patient.system
    patient.telecom = [telecom]

    msg = FhirRequest()
    msg.resource = patient

    self.send_request_sync("Python.FhirClient", msg)
```

<br><br>

Now if you go into the management portal and change the setting of the `ServiceCSV` to add `filename=Patient.csv` you can just stop and restart the production and see your transformation unfold and you client send the information to the server.

![Settings](https://user-images.githubusercontent.com/77791586/170278879-02eb4303-51af-45ba-93bf-393e9ff5ed94.png)

# 7. What's inside the repo

## 7.1. Dockerfile

The simplest dockerfile to start a Python container.<br>
Use `docker-compose up` to build and reopen your file in the container to work inside of it.

## 7.2. .vscode/settings.json

Settings file.

## 7.3. .vscode/launch.json
Config file if you want to debug.
