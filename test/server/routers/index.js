'use strict';

const supertest = require('supertest');
const assert = require('chai').assert;

const app = require('../../../server/app');

describe('index', () => {
  it('returns Hello World! when called', () =>
    supertest(app)
      .get('/')
      .expect(200)
      .then(res => {
        assert.equal(res.text, 'Hello World!');
      }));
});
