# Software Development Process (SDP) - Bee-Ring Group

Group members: Jon Nelson, Seongki Lee, Carter Nelson, Zoe Downen, Shannon Bell

CS 461

Contents of the document:
Principles, 
Process, 
Roles, 
Tooling, 
Definition of Done (DoD), 
Release Cycle, 
Environments.

##
# **Principles**

**Responsive Communication**

- Team members commit to responding to asynchronous communication on Discord within 24 hours.
- Backlog Management
  - Utilize a Github projects board for continuous backlog management.
  - Ensure that the backlog is maintained with work items for at least the next two weeks. If necessary, we will host meetings to update the backlog and agree on issues
  - Ensure backlog items are complete (as described below)
- Meetings with our project partner are ideally every two weeks
- Meetings with teammates are weekly with TA

**Work Item Definition**

Each work item in the backlog must include:

- User story or motivation
- Technical description
- Dependencies
- Estimate
- Acceptance criteria

All issues need to relate to a user story. Tasks that cannot be completed in a week will be broken down into smaller tasks

**Version Control**

- All code changes should be developed in separate git branches to ensure isolation.

**Code Review Process**

- After completing a feature, bug fix, or refactoring, create a Pull Request (PR).
- Pull Requests must have all conversations resolved before a successful merge
- PRs must be reviewed by at least one team member before merging

**Definition of Done (DoD)**

- Ensure that PRs comply with the Definition of Done, which should include quality checks, testing, and documentation.
- Link PRs to the corresponding work items in the backlog.

# Process

**Software Development Lifecycle/ software development process:**

**Backlog Management**

- The product owner and development team continuously maintain the backlog.
- New work items are created with user stories, technical descriptions, estimates, and acceptance criteria.
- Dependencies are identified and documented.

**Development**

- Developers create new branches for their work items, following the version control principle.
- They develop and test the code, ensuring that it complies with the Definition of Done.

**Code Review**

- Developers create Pull Requests for completed work items.
- At least one team member reviews the code, providing feedback and ensuring quality.

**Demo/Review with Stakeholders**

- Showcase completed work items
- Collect feedback from stakeholders and make necessary adjustments.
- Validate that work items meet acceptance criteria.

**Merge and Deployment**

- Once a Pull Request is approved, it is merged into the main branch.
- (Possibility) Continuous integration/continuous deployment (CI/CD) pipelines may automatically build and deploy the changes.

**Adaptation**

- Adapt and refine the process based on feedback, performance data, and changing project needs.

##
# **Roles**

We will be building a mobile Android app UI that interfaces with a backend system. We will break up the work as follows:

**Jon, Zoe - Data Management:**

- Responsible for collecting real-time data from the robot
- Establish connection between robot and Flutter frontend
- Store data within a certain range and graph values
- Maximize accessibility to user data via database organization

**Seongki - User Authentication:**

- Design a Firebase database for username/password storage
- Create method of registration for users
- Establish connection with the Flutter frontend
- Connect B Ring API keys to independent users

**Shannon, Carter - UI/UX Designer:**

- Create the visual design and user experience of the app.
- Design app screens, layouts, icons, and other graphical elements.
- Ensure a user-friendly and visually appealing interface.
- Work closely with the Systems developer(s) to implement the design.

**Quality Assurance (QA) Tester (Everyone):**

- Responsible for testing the Android app to identify and report bugs or issues.
- Conduct functional testing, usability testing, and performance testing.
- Ensure the app meets quality and performance standards.
- Collaborate with developers to resolve issues.

**Jon, Zoe - Project Manager (Zoe) or Scrum Master (Jon):**

- Coordinate and plan project tasks, timelines, and milestones.
- Facilitate communication and collaboration among team members.
- Track progress, manage resources, and handle any project-related issues.
- Ensure the project stays on schedule and within budget.

##
# **Tooling**
<em>**Italicized items are no longer a tool**</em>
| **Version Control** | GitHub |
| --- | --- |
| **Project Management** | Trello |
| **Documentation** | Google Doc, Github Wiki, README |
| **Test Framework** | <em>Possibly Espresso: Espresso is an Android UI testing framework for creating user interface (UI) tests. Flutter testing frameworks.</em> Unit Testing with Mock/Testing Server: A server within the Viam system is isolated to allow for backend responses, without connecting to critical backend services. This will be a backend staging server. Firebase: stores data from communicating frontend requests for username/password interface |
| **Linting and Formatting** | Android Lint will analyze Android projects for potential issues, like compatibility problems. The Dart linter is also built onto VS code and is used by default |
| **CI/CD** |<em> GitHub Actions</em> |
| **IDE** | Visual Studio Code Android Studio: Official (IDE) for Android app development. |
| **Graphic Design** | Adobe XD or Sketch: For UI/UX design and prototyping. Figma: For collaborative design and prototyping. InVision: For creating interactive design prototypes.Canva: For UI/UX design and prototyping |
| **Others** | Discord and MS teams for Communication. Zoom for client meetings |

##
# **Definition of Done (DoD)**

**Acceptance Criteria:** The acceptance criteria defined for the issue, task, or user story have been met. This includes functional requirements, user stories, and specific criteria outlined by the product owner or stakeholders.

**Code Changes** : All code changes related to the work item are implemented and thoroughly reviewed by teammates. Code is properly structured, and best practices are followed.

**Merged to Main Branch** : Changes are merged into the main branch of version control (e.g., Git) after review and approval.

**Testing** :

- Unit Testing: Unit tests have been written and are passing.
- Integration Testing: Integration tests, ensuring that the code works well with other components, are successfully passed. Changes are implemented in all relevant components, such as backend, frontend, libraries, and any other areas where they are applicable
- Regression Testing: Full regression tests are executed to ensure that new changes do not introduce regressions in existing functionality.
- Quality Assurance performed and issues resolved

**Documentation** :

- Documentation, including code comments, user manuals, and technical documentation, is updated regularly.
- Deployment Instructions are included to facilitate deployment to various environments.
- Release notes are updated to reflect the changes, bug fixes, and new features included in the release.

**Backward Compatibility** : Any breaking changes are evaluated and, if necessary, are avoided or well-documented. Efforts are made to maintain backward compatibility.

**Staging Deployment** : The changes are deployed to a staging environment for final testing and validation before production deployment.

**Demo Preparation** : A demo or presentation of the changes is prepared for the next stakeholder meeting or sprint review.

**Quality Assurance** : The work item has passed quality assurance checks and has been reviewed for completeness and correctness.

**Performance Testing** : If performance-related changes were made, they have been validated against performance criteria.

**Accessibility Testing** : If applicable, accessibility criteria have been met and verified.

##
# **Release Cycle**

Use semantic versioning MAJOR.minor.patch

- Increment the minor version for new features
- Increment the patch version for bug fixes
- Increment the major version for breaking API changes

Until the API is stable, major should be 0

Considering a 6 month to release time frame:
**Week 1: Project Startup**

- Conduct Team Startup meetings to discuss project goals, requirements, and scope.
- Define the release schedule and milestones.

**Weeks 2-3: Design and Wireframing**

- UI/UX designers work on wireframes and initial design concepts.
- Get stakeholder feedback on design iterations.

**Week 4: Architecture and Component Design**

- Define the app's architecture and component structure.
- Backend and frontend teams collaborate to finalize API specifications.

**Weeks 5-18: App Development**

- Developers work on implementing the app's features, backend integration, and UI.
- Frequent code reviews, continuous integration, and testing cycles.

**Weeks 19-21: Integration Testing**

- Combine the app's frontend with the backend to ensure proper data flow.
- Verify that API endpoints function as expected.

**Weeks 22-24: Alpha Testing**

- Internal testing phase with the development team and selected testers.
- Identify and address issues, bugs, and performance bottlenecks.

**Week 25: Beta Testing**
<em>**Beta version may be tested in house**</em>
- Release a beta version of the app to a limited group of external testers.
- Collect feedback on usability, performance, and any issues.

**Weeks 26-27: Optimization**

- Based on beta feedback, work on performance optimization, bug fixes, and user interface refinements.
- Ensure frequent releases to the beta group.

**Week 28: User Acceptance Testing (UAT)**

- Conduct UAT with stakeholders to ensure the app meets their expectations.
- Finalize any pending changes based on UAT feedback.

**Week 29: Documentation**

- Prepare user documentation, FAQs, and help resources.

**Weeks 30-32: Final Testing and Quality Assurance**

- Rigorous testing, including regression testing and security assessments.
- Ensure that the app complies with any platform-specific guidelines.

**Week 33: Pre-Launch**
<em>**We're not sure if this will be a commercial version or just a detailed prototype**</em>
- Submit the app to Google Play Store for review.
- Configure monitoring and error tracking tools.

**Week 34: Official Release**
<em>**See above**</em>
- Launch the app on the Google Play Store.
- Notify stakeholders, customers, and users about the release.
- Monitor initial user feedback and address any immediate issues.

**Week 35: Post-Launch**

- Continuously monitor app performance, user feedback, and bug reports.
- Plan for future updates and feature enhancements.

##
# **Environments**

| **Environment** | **Infrastructure** | **Deployment** | **What is it for?** | **Monitoring** |
| --- | --- | --- | --- | --- |
| Production | Google play store | Final Release | Google Play is the expected distribution platform for Android apps. | Google Play Console for monitoring and managing apps |
| Staging (Test) | Staging server | A dedicated staging server replicating the production environment. | This server host backend services, databases, and any other components that interact with the Android app | Detailed logging in the staging server environment to capture key events and interactions with the ap |
| Dev | Local (macOS and Windows) | Commit | Development and unit tests | Local testing frameworks |




# Product Requirements Document (PRD) - Bee-Ring Group

Contents of the document:
Problem Description,
Scope,
Use Cases,
Purpose and Vision (Background),
Stakeholders,
Preliminary Context,
Assumptions,
Constraints,
Dependencies,
Market Assessment and Competition Analysis,
Target Demographics (User Persona),
Requirements,
User Stories and Features (Functional Requirements),
Non-Functional Requirements,
Data Requirements,
Integration Requirements,
User Interaction and Design,
Milestones and Timeline,
Goals and Success Metrics,
Open Questions,
Out of Scope,
References.


##
# **Problem Description**

Current beekeeping methods are lacking in technological innovation. Because of climate
change, parasites, pesticides, and starvation, 48 percent of honeybee colonies in America
were lost in the past year, the second highest death toll on record (Borenstein, 2023).
Beekeepers are struggling to prevent a parasitic mite called Varroa from infesting these
hives, and they don’t have easy access to hive data in order to identify an early
infestation. With climate change, unnatural warm spots in the winter have brought bees
out of hibernation early, which means beekeepers need to constantly track and manage
hive temperature and humidity, usually with a manual probe. If bees leave hibernation
early, they will starve to death from a lack of pollen from flowering plants. We rely on bees
to provide for 80 percent of pollination for insect-pollinated plants, so a loss of pollination
would devastate the agricultural industry (Randall, 2022). Beekeepers need easier and
more efficient technology to address the losses beekeepers are facing in these trying
times.

##
# **Scope**

The scope for this product will be limited to UI development, as an automation and robotics
company is working on the backend and robotics functionality. We are currently at the
prototyping phase with the Bee-Ring, so the UI should be focused on delivering basic app
functionality and data for the frontend. This means storing and providing the data in an easy and
accessible manner, and designing an intuitive UI interface. The goal is to manage real-time hive
data in order to catch any health problems early on. This helps beekeepers keep their bees
healthy, without dealing directly with a mountain of data. Additionally, there is a difference
between hobby beekeeping and industrial beekeeping, with industrial beekeeping being at a
much larger scale. With this in mind, this project is focusing exclusively on hobby beekeeping
for now, but for future iterations, our project partner wants to include versions for industrial
beekeeping and beekeeping research.

##
# **Use Cases**

**Early Disease Detection**

Use Case: A beekeeper receives a notification on their smartphone when the monitoring system
detects unusual temperature changes in a hive. This allows the beekeeper to investigate and
address potential health issues, possibly preventing the spread of diseases within the colony.

**Optimal Hive Environment**

Use Case: A beekeeper uses the system to maintain the right environmental conditions in the
hives, especially during bad weather conditions. The monitoring system automatically adjusts
temperature and humidity levels, ensuring the health of the colony. This stability leads to
increased pollination rates and better honey production.

**Remote Hive Monitoring and Management**

Use Case: Beekeepers, with hives in various locations, remotely monitor all their hives through
a centralized dashboard. This enables prompt issue identification and potential resolution from a
distance, ensuring the health of bee colonies without the need for frequent on-site visits.

Use Case: The user will check their beehive statistics through the app and see trends over a
certain period of time such as changes in temperature or humidity.

Use Case: The user checks the health of their hive while they are at work. They see that the
humidity of the hive is lower than optimal. They make an adjustment on the app to raise the
humidity of the hive.

**Efficient Hive Inspections**

Use Case: Beekeepers can remotely access hive data to make informed decisions about hive
management. For example, they schedule inspections only when the system detects problems,
reducing disruptions to the bees, saving time, and optimizing how resources are used.

Use Case: The user will be able to check on the queen bee status to see whether she is missing
or present.

Use Case: The user will be able to see whether they need to refill the feeding trays.

**Bee-Ring Device Management**

Use Case: The user will access their settings on the app and select which specific notifications
they want on beehive activity.

Use Case: The user will access their settings on the app and select the thresholds for certain
notifications (i.e. temperature min and max, humidity min and max, etc).

Use Case: The user will add beehives with a Bee-Ring to the app so they can view the statuses
for multiple bee hives via bluetooth connection.

Use Case: The user will set and track hive management goals through the Hive Management
tab.

**Purpose and Vision (Background)**

Our purpose is to develop a beekeeping app that provides users with data on the health and
productivity of their hives in real time so that users can improve beehive conditions and monitor
changes over time.

We want beekeepers to use our product for current and future hives; as more users interact with
this product, more bees are saved.

Currently, beekeepers are struggling with excessive hive losses every year, due to climate
change, parasites, pesticides, and starvation. With the right data, some of these problems can
be prevented with early detection of abnormalities in the hive. As it stands, beekeepers don’t
have easy access to preventative technologies.

The Bee-Ring wants to make beekeeping easy and effective, especially for small-scale
beekeepers facing challenges due to declining bee populations. We want to simplify hive
management by using smart technology. Our vision is to empower beekeepers with a
user-friendly tool that manages hive data and prevents health issues early on. The Bee-Ring is
designed for beekeepers who are passionate about their hives but struggle with the
complexities of hive management. Our vision is to empower beekeepers with a tool that takes
care of the details, so they can enjoy beekeeping without the stress.

While our focus is on making beekeeping easier for small-scale beekeepers, this project intends
to lay the groundwork for future expansion, envisioning the evolution of the Bee-Ring into a
comprehensive solution tailored for large-scale commercial beekeeping. We intend to support
the diverse needs of all beekeepers, from hobbyists to industry professionals, and make the
Bee-Ring a valuable tool in beekeeping of all scales.

**Stakeholders**

- Users
- Manufacturers
- Founders
- Engineering Team

**Beekeepers (Users)**:

- Update Frequency: Regular, especially during hive inspections and problem detection.
- Type of Updates: Real-time data on hive conditions, alerts for issues.
- Decision-Makers: Main decision-makers regarding hive management.
- Decisions: Adoption of the Bee-Ring system, implementing automation.
- Requirements: Detailed, real-time hive data for informed decisions.

**Beekeeping Product Manufacturers**:

- Update Frequency: Regular for marketing materials.
- Type of Updates: Product descriptions, promotional content.
- Decision-Makers: Marketing Managers.
- Decisions: Marketing strategies and campaigns.
- Requirements: Data on the Bee-Ring's unique selling points.

**Preliminary Context**

**Assumptions**

1. We can develop an app that works across all mobile platforms (iOS, Android).
We can acquire pseudo-data in the format that will be provided by the device hardware for
testing

2. Libraries used for development are reliable and without bugs

3. Data Sorting Feasibility: We assume that the vast amount of data generated by the bee
monitoring sensors can be effectively sorted and analyzed using appropriate sensors and
software, considering the data's complexity and volume.

4. Beekeeper Adaptability: We assume that beekeepers, who traditionally rely on manual methods,
can readily adapt to data-driven techniques and incorporate the technology into their
beekeeping practices.

5. Cross-Platform Implementation: We assume that the monitoring algorithms developed for the
project can be efficiently implemented on various platforms, including iOS, Android, and PC, to
cater to a wide range of users and their preferred devices.

6. Availability of Open Source Sensor Libraries: We assume that open-source libraries and
resources for bee monitoring sensors and related technologies are accessible and readily
obtainable to support the project's sensor technology needs.

7. Sensor Data Accuracy: We assume that the sensor data collected will be accurate and reliable
for monitoring bee behavior, hive conditions, and environmental factors, considering the critical
nature of the data for informed decision-making.

8. Bee Health and Behavior Consistency: We assume that the behavior and health patterns of
bees remain relatively consistent, allowing the monitoring algorithms to detect anomalies and
health issues effectively.

**Constraints**

1. As a smaller team, we need to achieve basic functionality within 6 months for testing
We need to make sure that our frontend is compatible with the backend.
We need to make sure that there is no chance the software will have a fatal malfunction as the
life of the hive is on the line.

2. We need reliable communication with our project partner to make necessary changes.

3. Deadline Constraints: There are tight project deadlines in place to bring the product to market
by spring 2024. Keeping to these time constraints is essential to meet market demand and
business goals. The project faces time constraints due to the involvement of students who may
have limited availability outside of academic commitments.

4. Adoptability Constraints: Traditional beekeepers may be resistant to adopting new, data-driven
beekeeping methods. The project must address the challenge of convincing beekeepers to
embrace this technological change and provide resources and support for a smooth transition.

5. Budgetary Constraints: The project operates within specific budgetary constraints that limit
expenditures for research, development, and production. Effective resource management is
crucial to stay within budget and achieve the project's financial goals.

6. Resource and Expertise Constraints: The project may face constraints related to the availability
of skilled staff and expertise in areas such as sensor technology, data analysis, and software
development. Maximizing the effective use of available resources and expertise is essential.

**Dependencies**

1. We’re dependent on getting more information from our project partner in order to proceed with
this project.

2. We’re dependent on the structure of the backend for compatibility with our frontend.

3. We’re dependent on the reliability of the hardware sensors to give the front end reliable,
accurate data.

4. We need access to the database for all of the variables we are tracking with the hardware.

5. Testing and Development by Independent Beekeepers: The project may rely on the active
participation of independent beekeepers who serve as testers and contributors to further
develop the product. Feedback and insights from beekeepers are essential for refining the
technology.

6. Sequential Tasks in Product Development: The project's development process involves various
sequential tasks, from sensor implementation to software integration. These tasks need to be
completed in a specific order, and delays in any one of them can affect the overall project
timeline.

**Market Assessment and Competition**

**Analysis**

Alternatives (Wutke, 2023):

- Gobuzzr is a beehive monitoring system that uses sensors and an app to provide instant
notifications about temperature changes, weight, or humidity levels. They do not monitor
bee behaviors, hive activity, or honey production

- Beebot tracks temperature, humidity, and bee’s buzzing for changes. Again, they do not
monitor bee behaviors, hive activity, or honey production
Apple Air tag can be used to monitor theft with GPS location of the hives, but it does not
provide any features for beekeepers specifically

- The Bee-Ring appears to be an upgraded version of what is currently available on the market.
Tracking temperature and humidity using wireless hardware seems to be a popular
technological advancement in the beekeeping industry. However, these devices have yet to
monitor bee behaviors, hive activity, or honey production, which are unique features to the
Bee-Ring.

**Target Demographics (User Persona)**

- There are a few personas we can make based on the specific needs of each hobby beekeeper
Sydney is a 31 y.o. hobby beekeeper that has struggled with the temperature changes in
her state. She is currently using an oven thermometer to measure the temperature every
day at 8 am.

- David is a 25 y.o. hobby beekeeper that has lost an entire hive to Varroa mites. The
pupae died and the survivors were left with wing deformities and cognitive impairment.

- Monica is a 60 y.o. hobby beekeeper. She is currently retired and her passion is taking
care of her bees, and she has been very successful.

- John is a 40 y.o. hobbyist beekeeper that has 5 hives. He sells his honey locally for
supplemental income and has a full time job.

- Jessica is a 65 y.o. recent retiree. She just started learning about beekeeping and wants
to start her own hive within the next month.


**Requirements**

**User Stories and Features (Functional Requirements)**


| **User Story** | **Feature** | **Priority** | **GitHub Issue** | **Dependencies** |
| --- | --- | --- | --- | --- |
| As a beekeeper, I want to be able to check the temperature and humidity of my hives when I am unable to check manually. | TBD | Must Have | TBD | N/A 
 | As a beekeeper, I want to be  able to  look at previous temperature and humidity statistics to see if there is a growing abnormality with either variable  over time. | TBD | TBD | Must Have | Must Have |  As a beekeeper, I want to receive notifications of any significant changes to my beehive. |  TBD | TBD | N/A | N/A | As a user, I don't require the ability to control all hive equipment remotely. | The product will not feature | Will not have | N/A | N/A |
| As a user, I'm not looking for support for hive-related e-commerce functions. | The system will not offer e-commerce features related to hives | Will Not have | N/A | N/A


**Non-Functional Requirements**


- The system should recover from a failure within 5 minutes without past data loss. Cannot
store real-time data while offline

- The product should be accessible 24/7 except during scheduled maintenance windows

- The product should work on any mobile device with any screen size

- Code should have documentation on how to maneuver the app. Include standardized
commenting and step-by-step instructions

- The app must be connected to the device at all times to provide real-time data and
accurate statistics

- Data must be protected and comply with regulations

**Data Requirements**

1. Temperature readings

2. Humidity readings

3. Battery life

**Hive Information**:

1. Data Structure: JSON or XML

2. Details: Hive ID, location, date of setup, hive type, owner information, and current status (active
or inactive).

**Bee Behavior Data**:

1. Data Structure: CSV

2. Details: Behavior logs with timestamps, hive ID, and descriptions of bee behaviors such as
foraging, swarming, comb building, and brood care.

**Hive Health Data**:

1. Data Structure: JSON or XML

2. Details: Records of hive health indicators, including disease prevalence, pest infestations,
colony strength, honey production, and queen activity.

**User Data**:

1. Data Structure: Relational Database (such as MySQL)

2. Details: User profiles with personal information, login credentials, hive ownership, and
notification preferences.

**Sensor Calibration Data**:

1. Data Structure: JSON or XML

2. Details: Information about sensor calibration, including calibration coefficients and calibration
timestamps. Used to ensure data accuracy.

**Notification Data**:

1. Data Structure: JSON or XML

2. Details: Records of notifications sent to users, including message content, recipient ID,
timestamp, and delivery status.

**Logs and Metadata**:

1. Data Structure: JSON or XML

2. Log Files Details: System logs and metadata, including system events, errors, user activities,
and API requests. Timestamps and log levels for debugging and auditing.

**Backup Data**:

1. Data Structure: Encrypted Database Backup

2. Details: Encrypted backups of all critical data to ensure data recovery and integrity in case of
system failure.

**Integration Requirements**

The product needs to connect with the physical device that is monitoring the beehive. The app
needs to receive all data requirements from the device, and store that data for the user to see
through the app. We also need to integrate our frontend with the backend design.


**Functional Integration Requirements**

**User Notification Service:**

1. Integration Point: A Notification Module.

2. Functionality: Sends real-time notifications to users based on hive data and events.

3. Requirements: Immediate and reliable notification delivery with options for user preferences.

**Hive Health Analysis Module:**

1. Integration Point: Internal Data Analysis Module and external Data analysis API.

2. Functionality: Analyzes hive health data and provides health reports to beekeepers.

3. Requirements: Fast and accurate data processing with the possibility to generate insights and
recommendations.

**Behavior Pattern Recognition:**

1. Integration Point: Internal Machine Learning Module or API.

2. Functionality: Identifies and logs bee behavior patterns from sensor data.

3. Requirements: Real-time pattern recognition, with continuous learning and pattern refinement.

**Non-Functional Integration Requirements**

**Security and Authentication:**

1. Integration Point: User Data Management Module

2. Requirements: Secure authentication and access control to protect user data.

**Performance Monitoring:**

1. Integration Point: System Logging and Monitoring Module or external API

2. Requirements: Constant system monitoring for performance, errors, and real-time alerts

**User Interaction and Design**

Current mockups need to be discussed with our project partner. We currently have a couple of
mockups in the works, as shown below:

The layout could first be based on a website style design that works a bit like the canvas
interface. This could then be adapted to work as a phone app or be expanded into a complete
software product. The basic design could be built around a dashboard that abstracts the feature
as cards.

**Dashboard Mockup**:

The dashboard is the central hub where users can quickly access critical hive data immediately.
The design should focus on simplicity, clarity, and intuitive data visualization.

Interactions: Users can interact with widgets displaying hive status, environmental/weather
conditions, and notifications. They can also set preferences for the display of data.

Mockup Description: A clean and organized dashboard featuring real-time data cards for each
hive, weather updates, and notifications. Users can click on a hive card for detailed information.

**Hive Detail Page**:

When a user clicks on a hive from the dashboard, they should be presented with a detailed view
that offers in depth information about that hive's health and activity.

Interactions: Users can scroll through historical data charts, view sensor data, and access
hive-specific settings.

Mockup Description: The hive detail page includes line charts showing temperature and
humidity trends, images from the hive's camera, and buttons for settings adjustments.

**Notification Center**:

Notifications are crucial for real-time alerts. The notification center should provide a
straightforward way to view and manage alerts.

Interactions: Like an email system, users can see notifications categorized by importance, mark
them as read, or possibly take specific actions in response to alerts.

Mockup Description: The notification center displays notifications with time stamps, and users
can mark them as read, dismiss them, or click to see more details.

**Settings Panel**:

For changing settings or user preferences, the settings panel should be user-friendly.

Interactions: Users can customize notification preferences, sensor calibration, and connectivity
settings.

Mockup Description: A clean settings panel with tabs for general preferences, notifications,
sensor settings, and connectivity options.

**Milestones and Timeline**

The planning and researching phase will occur this term until Week 7 or Week 8. Then we
proceed to start working on certain features throughout the winter term, and then do testing in
the spring. With dates, this would be the tentative timeline:

- Planning/Research:

	- Start: October 1st

	- End: November 20th

		- Milestone: Completed Research!

- Functionality/Features Development:

	- Start: November 21st

	- End: March 22nd

		- Milestone: Completed basic functionality and features!

- Testing:

	- Start: April 1st

	- End: June 7th

		- Milestone: Completed testing!

**Detailed Milestones**:

- Milestone 1: Project Setup (1-2 weeks)

1. Define project scope and requirements.
2. Gather necessary resources and tools.
3. Set up the development environment.
4. Create project repository and initial documentation.
 
- Milestone 2a: User Dashboard (4-6 weeks)

1. Display real-time hive data, including temperature, humidity, and status.
2. Implement data visualization and analytics tools.

User story: "As a beekeeper, I want to access a dashboard to monitor the status
of my hives and analyze collected data."

- Milestone 2b: Data Collection (4-6 weeks)

1. Create data structures and APIs for storing hive data.
2. Implement real-time data collection from hive sensors and Store collected data in a
database.

User story: "As a beekeeper, I want to collect data from hive sensors in
real-time for analysis." (Milestone 2a and 2b should happen concurrently)

- Milestone 3: Automated Notifications (3-4 weeks)

1. Implement an automated notification system for important hive events.
2. Set up alerts for temperature or humidity deviations.
3. Send notifications to beekeepers via email or mobile app.

User story: "As a beekeeper, I want to receive notifications when hive conditions require
my attention."

- Milestone 4: Scalability and Performance Optimization (3-4 weeks)

1. Optimize the system for scalability to handle a growing number of hives.
2. Enhance system performance for real-time data processing.
Perform load testing and optimization.

User story: "As a large-scale beekeeper, I want a system that can scale with my
expanding honey production."

- Milestone 5: Documentation and Testing (2-3 weeks)

1. Create user guides and developer documentation.
2. Conduct thorough testing, including unit, integration, and user acceptance testing.
3. Address any bugs or issues identified during testing.

User story: "As a user, I want clear documentation for using the system effectively."

- Milestone 6: Deployment and User Training (2-3 weeks)

1. Prepare for the product launch.
2. Deploy the system to production.
3. Provide training and support to users.

User story: "As a beekeeper, I want training to effectively use the system."

**Goals and Success Metrics**

| **Goal** | **Metric** | **Baseline** | **Target** | **Tracking Method** |
| --- | --- | --- | --- | --- |
| Maintain accurate Error margin for measuring statistics temperature and humidity. |  Interview  | 8% at the 95% confidence level. |  4% at the 95% confidence level. | Plausible Analytics | 
Product-market fit On a scale of 1-10, how hard is it to maintain a healthy hive environment for hobby beekeeping?|Interview  | Not hard < 4 |  Very hard > 4 | Survey | 
Increase free time % of pre Bee-Ring time spent | 100% | 75% | User survey | users caring for their hive. |

**Open Questions**

1. What programming language(s) is being used to program the backend?

2. What is the timeline of this project?

3. What are the requirements that are absolutely necessary for this project, and what are stretch goals?

4. What is the ideal final product?


**Out of Scope**

1. The hardware is still in development, so we will not be testing the frontend with these

2. components for either the entirety of the project or the second half depending on what our project partner says. We should also stress that this is not a final product, we are creating a V1 of the UI, which means after project completion, changes may occur by future engineers.

**References**

Borenstein, S. (2023, June 22). *Struggling beekeepers stabilize U.S. honeybee population after*

*nearly half of colonies died last year*. PBS.

https://www.pbs.org/newshour/economy/struggling-beekeepers-stabilize-u-s-honeybee-populati

on-after-nearly-half-of-colonies-died-last-year

Randall, B. (2022, June 6). *The Value of Birds and Bees*. Farmers.gov.

https://www.farmers.gov/blog/value-birds-and-bees#:~:text=Honey%20bees%20alone%20pollin

ate%2080,types%20of%20fruits%20and%20vegetables.

Wutke, S. (2023, July 17). *Bee smarter about beekeeping with Smart Devices*. Hobby Farms.

https://www.hobbyfarms.com/bee-smarter-about-beekeeping-with-smart-devices/

Software Design and Architecture

[Introduction](#_page0_x72.00_y357.56)

[Architectural Goals and Principles ](#_page0_x72.00_y642.75)[System Overview](#_page1_x72.00_y581.12)

[Architectural Patterns ](#_page2_x72.00_y296.28)[Component Descriptions](#_page3_x72.00_y130.19)

[Data Management](#_page3_x72.00_y546.29)

[Interface Design](#_page4_x72.00_y581.12)

[Considerations](#_page5_x72.00_y72.00)

[Security](#_page5_x72.00_y104.45)

[Performance](#_page5_x72.00_y172.70)

[Maintenance and Support ](#_page5_x72.00_y232.40)[Deployment Strategy](#_page5_x72.00_y321.20)

[Testing Strategy](#_page6_x72.00_y130.19)

[Glossary](#_page6_x72.00_y633.57)

<a name="_page0_x72.00_y357.56"></a>Introduction

The document outlines the architecture for a phone app-based hobby beekeeping application. A well-defined architecture ensures scalability, maintainability, and reliability. Our goal is to create the first version of our project’s frontend. With this in mind, we need to create an architectural design that is intuitive for future programmers who will provide maintenance and support to future versions of our application. A good architectural design ensures easier debugging and maintenance.

**Project Objectives**

- The core objectives of the Bee-Ring project are as follows:
- Develop a user-friendly mobile Android app for beekeepers to monitor hive conditions, bee behavior, and environmental factors in real-time.
- Implement a scalable backend system capable of collecting, storing, and processing hive-related data efficiently, serving multiple users simultaneously.
- Enable automated notifications for beekeepers, alerting them to critical hive events and optimal honey collection conditions.
- Maintain data privacy and compliance with relevant data protection regulations.

<a name="_page0_x72.00_y642.75"></a>Architectural Goals and Principles

**Architectural Goals:**

- **Scalability:** The architecture must be designed to support an increasing number of users and beekeeping devices, ensuring that the system can accommodate both small-scale and large-scale beekeepers.
- **Real-time Data Processing:** The system should provide real-time data collection and analysis capabilities, with a delay of no more than 5 seconds from the moment of data acquisition.
- **Data Security:** All data communication must be encrypted to protect data privacy and integrity. User authentication and authorization should be implemented securely.
- **Usability and User Experience:** The architecture should prioritize user-friendliness and provide an easy to use interface with a high standard of accessibility.
- **Data Privacy and Compliance:** The system should adhere to relevant data protection regulations, providing clear data usage policies for users.
- **Performance and Reliability:** The architecture must ensure a smooth and responsive user experience. The system should be available 24/7, with minimal downtime.

**Architectural Principles:**

- **Modularity:** The architecture should be composed of loosely coupled, interchangeable modules that can be independently developed, tested, and maintained.
- **API-First Approach:** Utilize Flutter's well-defined API that separates the frontend from the backend, allowing for easier integration.
- **Documentation and Best Practices:** Adhere to strict coding standards and best practices, with well-documented code and a comprehensive user guide to support maintainability and collaboration.
- **Performance Optimization:** Monitor and optimize system performance to deliver a responsive and efficient user experience, even as the system scales to accommodate more users and beehives.
- **Data-Driven Insights:** Use data for analytics and research, empowering beekeepers with tools to gain valuable insights into bee health.
- **Don’t Repeat Yourself (DRY):** If we duplicate logic and we need to change behavior, we will encounter inconsistent behavior from the system. To ensure we don’t have these problems that compromise reliability, we will encapsulate our logic in a programming construct, thus reducing the repetition in logic and ensuring that our system is reliable.
- **Single Responsibility:** Our objects should only have one responsibility, and thus are only subjected to change when that responsibility needs to change. This simplifies our code to be as efficient as possible while also making it easy for version changes.

<a name="_page1_x72.00_y581.12"></a>System Overview

User interface will be built and packaged with Flutter using Dart language, and Flutter makes the application for the IOS and Android environment at the same time. API will be set up with Dart since the Viam Database and Server can provide data in the Dart environment.

![](Aspose.Words.681967fa-dc0d-4c6a-8e88-25caf6c9ac29.001.jpeg)

<a name="_page2_x72.00_y296.28"></a>Architectural Patterns

There are three different architectural patterns that would be ideal for this project: The client-server pattern, event-sourcing pattern, and controller-responder pattern.

**Client-Server Pattern:**

The client-server pattern is well-suited for scenarios where there is a need for centralized data management and control, making it an ideal choice for Bee-Ring. Beehive data, user profiles, sensor calibration, and notification records are vital components that need centralized management.

**Event-Sourcing Pattern:**

An event sourcing pattern is good for applications that use real-time data. The Bee-Ring uses real-time data to report anomalies in temperature, humidity, and bee behavior, so this architectural pattern caters to that requirement.

**Controller-Responder Pattern:**

The controller-responder pattern introduces an additional layer in the architecture, where the controller handles data and workloads, while the responder replicates data from the controller and generates results. This pattern provides a level of data separation and redundancy. The controller-responder pattern ensures data integrity and minimizes data loss in case of controller failures. It would also be good for our project because we already have a controller component from our project partner, since we don’t need to create the database from scratch. We only need to create the responder to generate results for the user-based app.

Both have their pros and cons. Event-sourcing requires a reliable network infrastructure, which we are not guaranteed to have, and the controller may cause a loss of data if it fails. This merits a discussion in the future.

<a name="_page3_x72.00_y130.19"></a>Component Descriptions

- **User Interface (UI) - Flutter:**
- Responsibilities: Manages user interactions, displays real-time hive data, and provides a user-friendly interface for beekeepers and environmental enthusiasts.
- Role: The UI is the front-end component responsible for rendering the mobile app's graphical interface, allowing users to monitor hive conditions, receive notifications, and interact with the system.
- **Backend Server - Viam:**
- Responsibilities: Processes API requests, handles business logic, manages hive data, user profiles, and authentication, and interacts with the database (stored in JSON files).
- Role: The backend server serves as the core of the system, managing user authentication, realtime data collection, and processing. It ensures the security and integrity of hive data and delivers data to the UI via APIs.
- **Database - Firebase:**
- Responsibilities: Stores and manages hive information, environmental data, user profiles, and system logs.
- Role: The database component manages the persistence of crucial data, including hive setup details, real-time sensor data, and user accounts. It serves as a centralized data repository for the system.
- **Bee-Ring Hardware:**
- Responsibilities: provides beekeeping footage and physical data collection to server
- Role: The hardware is the setup for all of the sensors and video footage; it is the physical essence of the Bee-Ring. All other components of the system rely on the hardware for accurate sensor measurements and video analysis.

<a name="_page3_x72.00_y546.29"></a>Data Management

Most data will be stored and able to be accessed through the Bee-Rings Viam backend with the Dart programming language. The only part that is not stored with Viam will be user information, which will be through Firebase. The database for the sensor information is already set up, and we just need to access the data from the frontend to display to the user. Viam's service has data management built into it, allowing users to capture, sync, view, label, and export data. We have set up Firebase user authentication, but we are still working out some issues.

In Firebase we will use this Data Management Plan:

**User Profiles:**

- Fields: User ID, username, password (hashed), email, notification preferences.
- Description: Stores user information, including login credentials and notification preferences.

Through Viam we will use the following Data Management Plan:

**Hive Information:**

- Fields: Hive ID, location, date of setup, hive type, owner information, and current status (active or inactive).
- Description: Manages data related to individual beehives, their characteristics, and ownership.

**Hive Health Data:**

- Fields: Hive ID, disease prevalence, pest infestations, colony strength, honey production, queen activity.
- Description: Maintains hive health indicators for monitoring and management.

**Notification Data:**

- Fields: Timestamp, message content, recipient ID, delivery status.
- Description: Logs notifications sent to users, facilitating communication.

**Logs and Metadata:**

- Fields: Timestamp, log levels, system events, errors, user activities, API requests.
- Description: Stores system logs and metadata for debugging and auditing.

**Data Collection:**

- Real-time sensor data is collected from hives, including temperature and humidity.
- Collected data is stored in the respective database tables.

**User Interaction:**

- Users interact with the Flutter-based mobile app's UI to access hive data and set preferences.
- Notifications are generated based on hive conditions and user preferences and logged in the notification data table.

<a name="_page4_x72.00_y581.12"></a>Interface Design

GET/ current temperature, POST/ add new limitation for hive, PUT/ change limitation with new value

<a name="_page5_x72.00_y72.00"></a>Considerations

<a name="_page5_x72.00_y104.45"></a>**Security**

The Beering device and mobile device will be directly connected from the server side, so the security won't matter unless devices are physically stolen.

<a name="_page5_x72.00_y172.70"></a>**Performance**

Local device storage, connection stability, and processing battery efficiency.

<a name="_page5_x72.00_y232.40"></a>**Maintenance and Support**

Beering is going to update the UI based on the collected feedback and user experience tests. Furthermore, Beering will expand its service from the current interaction limit(user and service) to the interaction between users as well.

<a name="_page5_x72.00_y321.20"></a>Deployment Strategy

After we met with the software engineer at Viam, Viam provided many things for deployment such as databases and servers set in Dart, so we mostly needed to do the frontend side, such as UI and API with local device’s memory efficiency. Therefore, we are deploying our service built with Flutter which can deploy IOS and Android at the same time. We will manage the database with Firebase. 

**Local Development Environment:** This environment is for individual developer workstations and will be used during the development phase.

**Staging Environment**: The staging environment will hopefully be an actual device that replicates the production environment for pre-release testing. So a phone.

**Production Environment:** This is the live environment where end-users access and interact with the Bee-Ring through the Flutter-based frontend UI hosted on infrastructure connected to the Viam backend services.

**Local Development strategy:**

- Flutter tools for development.
- Viam API integration for local testing.

**Staging Environment strategy:**

- Local physical device.
- Viam's cloud backend services.

**Production Environment strategy:**

- Cloud-based virtual machines or serverless architecture.
- Viam's production backend services.

<a name="_page6_x72.00_y130.19"></a>Testing Strategy

*Tests for software such as unit, integration, and system will be done by using Flutter testing environment, and the device testing will be taken with our client’s beehives.*

**Unit Testing:**

- Local Development: Developers write and run unit tests using Flutter and Viam SDK.
- Staging: Validate Flutter frontend units and API endpoints.
- Production: N/A (Unit tests are for development and staging).

**Integration Testing:**

- Local Development: Simulate integration testing using mock data.
  - Staging: Integration with Viam backend services for end-to-end testing.
- Production: N/A (Integrations are validated in staging).

**User Acceptance Testing:**

- Local Development: Mock test cases created and executed.
- Staging: setup Pre-release test cases with select stakeholders.
  - Production: Have ongoing testing by select users.

**Testing Tools:**

- Unit Testing: Flutter's built-in testing framework.
- Integration Testing: Custom test suites and Viam's testing tools.
  - User Acceptance Testing: Test cases executed by end-users.

**Testing Approach:**

- Local Development: Developers perform unit testing using mock data and create

integration

testing with mocked Viam services. Continuously validate changes.

- Staging: Comprehensive integration tests with Viam API endpoints. User Acceptance

Testing

performed with real data.

- Production: Ongoing monitoring and user-reported issues drive further testing

<a name="_page6_x72.00_y633.57"></a>Glossary

API: Application Programming Interface, a set of defined rules that enable different applications to communicate with each other

API-First Approach: A development strategy that focuses on designing and building the API before implementing other aspects of the software

Audit Logging: The recording of system events, user activities, and errors for security and accountability purposes

Backend Server: A server for processing client requests, managing data, and handling business logic

CRUD (Create, Read, Update, Delete): The basic operations for managing data in a database or system

Dart: a client-optimized programming language for app development

Data Analysis: The examination of data to extract useful information, patterns, and insights.

Firebase: An API for application data synchronization across Android, web, and iOS devices

Flutter: An open-source UI framework for building natively compiled applications for mobile, web, and desktop from a single codebase

Load Balancing: The process of distributing network traffic across multiple servers to ensure high availability, improved performance, and redundancy

RBAC (Role-Based Access Control): A security approach that restricts system access based on user roles and responsibilities, allowing, or denying actions accordingly

SDK (Software Development Kit): A set of tools, libraries, and documentation that developers use to create software applications for a specific platform or framework

Session Hijacking: Unauthorized access to a user's session by an attacker

SSL/TLS (Secure Sockets Layer/Transport Layer Security): Cryptographic protocols used to secure data transmission over the internet, ensuring data confidentiality and integrity

System Logs: Records that document system events, activities, and errors for troubleshooting and auditing

Viam: A backend server and data management platform used in the Bee-Ring project
