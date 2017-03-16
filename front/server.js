var CalendarApp = require('./app/app.js');
var config = require('./app/config.js');

app = new CalendarApp(config);
app.startup();
app.listen();

