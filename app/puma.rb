#!/usr/bin/env puma

environment ENV.fetch('RACK_ENV') { 'production' }
threads ENV.fetch('APP_PUMA_MIN_THREAD') { 1 }, ENV.fetch('APP_PUMA_MAX_THREAD') { 3 }

bind 'tcp://0.0.0.0:80'

worker_timeout ENV.fetch('APP_PUMA_TIMEOUT') { 180 }
