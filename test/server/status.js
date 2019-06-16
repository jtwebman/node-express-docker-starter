'use strict';

const supertest = require('supertest');
const assert = require('chai').assert;

const status = require('../../server/status');

describe('private status check', () => {
  it('returns OK', () =>
    supertest(status)
      .get('/status')
      .expect(200)
      .then(res => {
        assert.equal(res.text, 'OK');
      }));
});
