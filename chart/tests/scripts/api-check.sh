#!/bin/bash
set -e

fluent_timeout=$((6*60))
echo "Hitting Fluentbit endpoint..."
time curl --retry-delay 2 --retry-max-time ${fluent_timeout} --retry $((fluent_timeout/2)) --retry-connrefused -sIS "${fluent_host}" 1>/dev/null || fluent_ec=$?
# time output shows up a bit after the next two echoes, sleep for formatting
sleep .1
if [ -n "${fluent_ec}" ]; then
  echo "curl returned exit code ${fluent_ec}, see above for error message and curl's elapsed wait time (timeout is ${fluent_timeout}s)"
  exit 1
fi
echo "Test 1 Success: Fluentbit is up, see above for curl's elapsed wait time."

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

echo "Waiting 15 seconds to allow Fluentbit to collect some records..."
sleep 15

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
