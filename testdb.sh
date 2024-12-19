#!/bin/bash

rm baza.txt

echo "This script tests the database.sh script"

echo "creating database using ./database.sh create_db <database_name>"
./database.sh create_db baza

echo "adding tables to the database using ./database.sh create_table baza pierwszy drugi trzeci czwarty"

./database.sh create_table baza pierwszy drugi trzeci czwarty
echo ""
echo "current state of the database"
cat baza.txt
echo ""
echo ""
echo "insterting rows into the database"
./database.sh insert_data baza a1 b2 v2 d1
./database.sh insert_data baza a2 b2 v1 d2
./database.sh insert_data baza a2 b3 v3 d3
./database.sh insert_data baza a3 b4 c6 d4
echo ""
echo "current state of the database"

cat baza.txt
echo ""
echo "selecting only drugi and trzeci columns"
./database.sh select_data baza drugi trzeci
echo ""
cat baza.txt
echo ""
echo "deleting only the rows where czwarty=d4"
echo ""

./database.sh delete_data baza "czwarty=d4"

echo ""
echo "new state of the database"
cat baza.txt
echo ""
