# pi process manager
A process manager (used on my raspberry pi 4).
## usage:
- add a json structure for each application in main/processes.json
- run start.bash to start the process manager
- you can eddit the "online" tag in the json for your application, set it to true if you want it active, and false when you want to stop the application.
- the process manager will then start or quit the application (this is updated every 5s)

## extra notes
- to know whether the process manager is running or not you can run state.bash
- to stop the process manager you can run stop.bash
- you can edit the "online" tag in the json from within other applications, for example a discord bot can edit the json, or a website, ... (here lays its power)
