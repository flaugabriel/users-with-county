#!/bin/bash
bundle check || bundle install
bundle exec rails s
