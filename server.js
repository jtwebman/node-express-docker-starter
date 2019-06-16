'use strict';

const config = require('config');
const stoppable = require('stoppable');

const app = require('./server/app');
const status = require('./server/status');

const port = config.get('PORT');
const nodeApp = stoppable(app.listen(port, () => console.log(`Node app listening on port ${port}!`)));

const statusPort = config.get('STATUS_PORT');
const statusApp = stoppable(status.listen(statusPort));

const killSignals = {
  SIGHUP: 1,
  SIGINT: 2,
  SIGTERM: 15
};

/**
 * Shutdown apps correctly
 * @param  {String} signal signal used to exit
 * @param  {Number} value  signal value
 */
function shutdown(signal, value) {
  console.log(`Trying shutdown by got ${signal}`);
  nodeApp.stop(() => {
    console.log('Node app stopped.');
    statusApp.stop(() => {
      console.log('Status app stopped.');
      process.exit(128 + value);
    });
  });
}

process.on('SIGHUP', () => shutdown('SIGHUP', killSignals.SIGHUP));
process.on('SIGINT', () => shutdown('SIGINT', killSignals.SIGINT));
process.on('SIGTERM', () => shutdown('SIGTERM', killSignals.SIGTERM));
