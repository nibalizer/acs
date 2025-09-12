#!/bin/bash -x

echo testing db connection

echo 'select current_date, current_time;' | psql 'postgres://postgres:password@postgres:5432/postgres'
