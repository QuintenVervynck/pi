# pi process manager
A process manager (used on my raspberry pi 4).
## usage:
- add a row in the database in table prcs
- run start.bash to start the process manager
- you can eddit the "active" field in the database for any application, set it to true if you want it active, and false when you want to stop the application. The process manager will then start or quit the application (this is updated every 3s)

## extra notes
- to know whether the process manager is running or not you can run state.bash
- to stop the process manager you can run stop.bash
- you can make changes in the database from within other applications, for example from within a discord bot, a website, ... (here lays its power)
