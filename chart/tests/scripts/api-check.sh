#!/bin/bash
set -e

echo "Hitting Fluentbit endpoint..."
curl -sIS "${fluent_host}" &>/dev/null || export FLUENT_DOWN="true"
if [[ ${FLUENT_DOWN} == "true" ]]; then
  echo "Test 1 Failure: Cannot hit Fluentbit endpoint."
  echo "Debug information (curl response):"
  echo $(curl "${fluent_host}")
  exit 1
fi
echo "Test 1 Success: Fluentbit is up."

echo "Checking Fluentbit version..."
fluent_response=$(curl ${fluent_host} 2>/dev/null)
current_version=$(echo ${fluent_response} | jq '."fluent-bit".version' | xargs)
if [ ! ${desired_version} ==  ${current_version} ]; then
  echo "Test 2 Failure: Fluentbit version does not match."
  echo "Debug information (deployed build info):"
  echo "${fluent_response}"
  exit 1
fi
echo "Test 2 Success: Fluentbit version matches."

echo "Checking Fluentbit records input..."
records_response=$(curl "${fluent_host}/api/v1/metrics" 2>/dev/null)
records_in=$(echo ${records_response} | jq '.input."tail.0".records' | xargs)
if [ ! ${records_in} -gt 0 ]; then
  echo "Test 3 Failure: Fluentbit has not collected any records."
  echo "Debug information (metrics response):"
  echo "${records_response}" | jq
  exit 1
fi
echo "Test 3 Success: Fluentbit has received ${records_in} records."

echo "Checking Fluentbit records processed..."
records_response=$(curl "${fluent_host}/api/v1/metrics" 2>/dev/null)
records_out=$(echo ${records_response} | jq '.output."es.0".proc_records' | xargs)
if [ ! ${records_out} -gt 0 ]; then
  echo "Test 4 Failure: Fluentbit has not processed any records."
  echo "Debug information (metrics response):"
  echo "${records_response}" | jq
  exit 1
fi
echo "Test 4 Success: Fluentbit has processed ${records_out} records."

echo "Checking Fluentbit processing errors..."
records_response=$(curl "${fluent_host}/api/v1/metrics" 2>/dev/null)
processing_errors=$(echo ${records_response} | jq '.output."es.0".errors' | xargs)
if [ ${processing_errors} -gt 0 ]; then
  echo "Test 5 Failure: Fluentbit has ${processing_errors} processing errors."
  echo "Debug information (metrics response):"
  echo "${records_response}" | jq
  exit 1
fi
echo "Test 5 Success: Fluentbit has had 0 processing errors."
