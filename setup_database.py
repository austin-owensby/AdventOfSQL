from datetime import datetime
import psycopg2
import pytz
import requests
import sys

if (len(sys.argv) != 2):
    print('Unexpected number of arguments. Expected a single integer argument for the day to import. Ex. `python setup_database.py 2`')
    sys.exit()

try:
    DAY = int(sys.argv[1])
except ValueError:
    print('Unable to parse argument as an integer')
    sys.exit()

# Get the current datetime in UTC
now_utc = datetime.now(pytz.utc)

# Convert to Pacific Time
pacific_timezone = pytz.timezone('US/Pacific')
now_server = now_utc.astimezone(pacific_timezone)

# For now the advent is only in December 2024
max_day = 25

if now_server.year == 2024:
    if now_server.month == 12:
        max_day = now_server.day
    else:
        max_day = 0

if DAY < 0 or DAY > max_day:
    print(f'Invalid integer value, should be in range 0-{max_day} (0 for the example problem)')
    sys.exit()

print(f'Populating database for day {DAY}...')

print('Fetching input...')
try:
    with open('Cookie.txt', 'r') as file:
        advent_of_sql_key = file.read()
except FileNotFoundError:
    print('Could not find the Cookie.txt file, it should be adjacent to this script. See the ReadMe.md for more.')
    sys.exit()

# Fetch the seed SQL script
url = f'https://adventofsql.com/challenges/{DAY}/data'
headers = {'Cookie': f'_advent_of_sql_key={advent_of_sql_key}'}
response = requests.get(url = url, headers = headers)

if response.ok is False:
    print(f'Got a bad response from the server: {response.text}')
    sys.exit()

data = response.text
print('Input fetched')

# Create a new database
database = f'santa_workshop_{DAY:02}'
user = 'postgres'
host = 'localhost'
password = 'password'
port = '5432'

con = psycopg2.connect(
    user = user,
    host = host,
    password = password,
    port = port
)

con.autocommit = True

cur = con.cursor()

print(f'Creating database "{database}"...')
cur.execute(f'DROP DATABASE IF EXISTS {database};')
cur.execute(f'CREATE DATABASE {database}')

print(f'Database "{database}" created')

con.close()

# Populate the database
con = psycopg2.connect(
    user = user,
    host = host,
    password = password,
    port = port,
    database = database
)

cur = con.cursor()

print('Populating database...')
cur.execute(data)
con.commit()

con.close()

print('Database populated')
