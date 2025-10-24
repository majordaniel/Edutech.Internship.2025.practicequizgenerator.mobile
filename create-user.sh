#!/usr/bin/bash

curl -X 'POST' \
  'http://apppracticequiz.runasp.net/api/Auth/register' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "firstName": "Janet",
  "lastName": "Jones",
  "otherName": "Jane",
  "registrationNumber": "6969",
  "email": "jjj@cc.com",
  "departmentName": "Department of Computer Science",
  "facultyName": "Faculty of Science",
  "currentLevelCode": "400"
}'