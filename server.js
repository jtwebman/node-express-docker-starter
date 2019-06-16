'use strict';

const config = require('config');

const app = require('./server/app');
const status = require('./server/status');

const port = config.get('PORT');

app.listen(port, () => console.log(`Docker demo app listening on port ${port}!`));

const statusPort = config.get('STATUS_PORT');

status.listen(statusPort);
