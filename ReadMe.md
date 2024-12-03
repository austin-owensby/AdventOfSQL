# Advent of SQL
This repo stores my solutions for the https://adventofsql.com/ site as well as a script to set up your PostgreSQL database with the input

## Setup
- Install [python](https://www.python.org/downloads/)
- Install the python requirements `pip install -r requirements.txt`

## Populate day's database
1. Save the Cookie
   1. Log in to the Advent of SQL website
   1. Use your browser's dev tools to find the `advent_of_sql_key` Cookie
   1. Save the value in a `Cookie.txt` file adjacent to the `setup_database.py` file
1. Run the setup for the specific day
    - Ex. for day 2 run `python setup_database.py 2`
