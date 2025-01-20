#!/bin/bash

# This script demonstrates a corrected version that avoids race condition.

counter=0

# Function to increment the counter using a mutex lock
increment_counter() {
  # Simulate locking mechanism
  # In a real application, use a proper locking mechanism like a mutex
  local lockfile="/tmp/counter.lock"
  while ! flock -n "$lockfile"; do
    sleep 0.1 #wait for 0.1 seconds and try again
done

  local new_counter=$(($counter + 1))
  counter=$new_counter

  flock -u "$lockfile"
}

# Create two processes that increment the counter simultaneously
for i in {1..2}; do
  increment_counter &
done

# Wait for the background processes to complete
wait

# Print the final counter value. This should consistently be 2.
echo "Final counter value: $counter"