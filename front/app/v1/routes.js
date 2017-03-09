var express = require('express')
var Promise = require('bluebird')
var router = express.Router()

function doSomeAsyncThing(query) {
    return new Promise((resolve, reject) => {
        if (query == 'Tammy') {
            throw new Error('Ooh, Tammy is a bad name!');
        } else {
            resolve(query);
        }
    })
}

function doAnotherAsyncThing(name) {
    return new Promise((resolve, reject) => {
        if (name == 'Reha') {
            resolve('Hello, ' + name);
        } else if (name == 'Eliza') {
            reject({ hello: 'my name is Eliza', code: 'werd' });
        } else {
            reject('Names other than Reha are not allowed!');
        }
    });
}

function doOkay(message) {
    return new Promise((resolve, reject) => {
        resolve({ status: 'success', data: message });
    });
}

function standardError(error) {
    return new Promise((resolve, reject) => {
        if (typeof error == 'string') {
            resolve({ status: 'fail', message: error });
        } else if (typeof error == 'object' && 'message' in error) {
            console.log(error);
            resolve({ status: 'error', message: error.message });
        } else {
            console.log(error);
            resolve({ status: 'error', message: 'Unknown error' });
        }
    });
}

router.get('/:query', (req, res, next) => {
    doSomeAsyncThing(req.params['query'])
        .then(name => doAnotherAsyncThing(name))
        .then(message => doOkay(message),
            error => standardError(error))
        .then(json => {
            res.json(json);
            next();
        });
});

module.exports = router;
