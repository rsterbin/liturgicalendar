/**
 * This lib reads a file in the project root named `.env`. It should be a
 * sh-style file of variables, each line being `KEY=VALUE` pairs. It parses the
 * file and merges the contents into the process.env map.
 */
if (!global.GLOBAL_OVERRIDE_LOAD_ENVIRONMENT_VARIABLES) {
    require("dotenv").load();
    global.GLOBAL_OVERRIDE_LOAD_ENVIRONMENT_VARIABLES = true;
}

module.exports = {
    database: {
        host: process.env.DB_HOST,
        port: process.env.DB_PORT,
        database: process.env.DB_NAME,
        user: process.env.DB_USER,
        password: process.env.DB_USER_PASSWORD
    },
    logDirectory: process.env.LOG_DIRECTORY,
    apiPort: process.env.API_PORT
};
