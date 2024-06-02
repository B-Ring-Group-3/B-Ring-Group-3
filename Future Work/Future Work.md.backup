# Future Work

#### A note about future work: As an android application "Future Work" will generally require changes to the files in the lib directory. 
##### The following directories represent application screens and methods for connecting, interacting with, and styling the content within them  
#####   1. presentation: These are the viewable application screens 
#####   2. routes: These methods define how the screens are linked together
#####   3. theme: these methods provide global styles. Note these WILL NOT cascade over local styles created on screens 
#####   4. widgets: these provide interactive components and stylings. The appbar subfolder contains appbar focused widgets for image insertion and appbar styling
#####   5. core: this provides utilities for exporting custom packages and widget like components like the help search delegate framework that can be built out for later versions of the app 

#### Other files in the lib directory create initial connections to the firestore DB and manage apikey obfuscation through environmental variables. Careful consideration should be made to changes to these files since they are crucial for connecting with the robot and the DB. 

### 1. Current UI driven future work based on the current Hive smart device available:

   1. The current smart device visualizes data. The client desires that images of the graphs be stored in a DB and be accessible as historical data through the app.

   2. The current device has username, and password authentication. A framework for authenticating through a google account is set up but not complete.

   3. The current version displays notifications on the alerts screen only. Later versions would ideally have an indicator on the alerts button to signal to the user that a notification alert is available to view.

   4. App settings may include features such as language preferences, units of measurement preferences, user profile management, and better help and support options

### 2. Future UI versions driven by future versions of the robot smart device that collect more data and provide direct interaction with the robot: 

1. Future versions of the robot smart device will have the following features:
   1. Sound sensor data
   2. Cell readings for honey stores
   3. Feeding tray status
   4. Queen excluder status
   5. Swarm detection alerts
   6. Hive activity summary

2. Historical data in the Graphs tab may be expanded to include sound and IR sensors

3. Include hive management tools tab with features such as:
   1. Hive inspection log
   2. Record-keeping for setting and tracking hive management goals
   3. Swarm prevention settings
   4. Control options for automated queen excluder and feeding tray

4. Expand Alerts tab to include future features and customizable threshold settings

### 3. Future DB driven work due to API updates that allow flutter/dart to access the Viam DB system: 

1. Current Flutter/Dart Viam SDK only has API support for database management available using the python SDK. However, The Viam SDK is continually receiving updates and likely will eventually include data management support features in their Flutter/Dart SDK. At some point the partner may wish to migrate from a database supported by firebase, into a database that exist within the Viam system.

2. This would require, first and foremost, the existence of API endpoints within Viam that support connections from Flutter/Dart. The would also require reworking the app to push data into a Viam database instead of a google firebase database, as well as pulling data from the Viam database instead of a google firebase database.
