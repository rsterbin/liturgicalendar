var express = require('express');
var Promise = require('bluebird');
var router = express.Router();
var winston = require('winston');

var standard = require('../../lib/standard.js');

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
        } else if (name == 'Jenny') {
            reject(new standard.BasicError('The name Jenny is a special kind of wrong', 456, 'doAnotherAsyncThing'));
        } else if (name == 'Eliza') {
            reject({ hello: 'my name is Eliza', code: 'werd' });
        } else if (name == 'Carter') {
            reject(new standard.BasicFailure('Names other than Reha are not allowed!', 123, true, 'doAnotherAsyncThing'));
        } else {
            reject(new standard.BasicFailure('Names other than Reha are not allowed!', 123));
        }
    });
}

function doOkay(message) {
    return new Promise((resolve, reject) => {
        resolve({ status: 'success', data: message });
    });
}

router.get('/:query', (req, res, next) => {
    doSomeAsyncThing(req.params['query'])
        .then(name => doAnotherAsyncThing(name))
        .then(message => doOkay(message))
        .then(json => { res.json(json); })
        .catch(next);
});

module.exports = router;
