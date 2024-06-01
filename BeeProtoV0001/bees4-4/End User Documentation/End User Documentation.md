# End User Documentation

### 1. How to sign up for a Bee Ring account

The sign up system is simple and works like many sign up processes. You use (ideally) a valid email as a username and a password of 8 or more alphanumeric characters with symbols optionally to sign up for an account. If you lose or forget your password, and you used a valid email during signup, you can reset your password using in app buttons. This will cause emails to be sent from **[noreply@beering-824d7.firebaseapp.com**](mailto:noreply@beering-824d7.firebaseapp.com)** with a link that will allow you to reset your password. Once you login you will be at the dashboard. But to finish setup you must provide your apikey and apikeyid that link the UI to your unique robot.

### 2. How to add you hive robot to your Bee-Ring Account

When you purchase a Bee-Ring smart device it comes with its own documentation that includes the apikey and the apikeyid. Maybe it’s in the user manual, or possibly printed on the bottom of the robot. Find this information, and click the button on the top right corner of the dashboard to link your bot to the UI. Just enter the apikey and apikeyid in the correct boxes and your bot will be set up in a firebase account with its own database for collecting robot data. When you access sensor data, it will be stored in the firebase DB. And when you access graph data it will then be pulled from the DB. The more a user interacts with the UI, the more data is stored.

### 3. How to navigate and use the the UI

The UI is composed of 3 areas listed below. These areas focus on collecting and visualizing the 3 main types of data the current robot prototype is capable of collecting: Temperature, humidity, and power data. Click on the dashboard buttons to access these sections.

#### 1. Alerts

The Alerts screen is a section that is meant to quickly determine whether the hives temperatures and humidity is within appropriate ranges. To make it a bit quicker it stores no data and simply pulls the current temp and humidity and signals whether it is within safe ranges. You can refresh the page with a button on the bottom right to poll the bot for new data.

#### 2. Sensors

The Sensors screen provides 3 types of data and currently stores 2 of them (temperature and humidity). When the user enters this section the robot is queried for data. This data is shown to the user and sent to the firebase database. Like in notifications, you can refresh the page with a button on the bottom right to poll the bot for new data and store this new data.

#### 3. Graphs

The Graphs screen has a default set up with a static collection of test data to demonstrate the graph UI system. Similar to the other screens, you can refresh the page with a button on the bottom right. In this case the refresh button will pull data from the firebase DB and use it to rebuild the graph with the most recent data available in the DB. There is a selector in the top right where you can choose to view the last 1, 7, 14, 30, 90, or 180 data points. This graph shows both temperature and humidity data.

#### 4. Unfinished Features

There is a skeleton of a help pages system set up on several screens. This would need to be expanded into a static collection of data that represents what’s included in this document. Each screen also has a menu built into it that could potentially allow users to configure how the screens work or how they interact with the robot or the DB. For example the alerts screen menu could allow you to choose different sensors to access alerts for future versions of the physical smart device that may collect more data. The Graphs screen suggests a feature to allow the exporting of graph data.
