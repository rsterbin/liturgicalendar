/**
 * Manage access to memcached
 */

if (!global.Memcached) {
    var Cache = require('memcached-promisify');
    global.Memcached = new Cache();
}

module.exports = global.Memcached;
