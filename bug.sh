#!/bin/bash

# This script demonstrates a race condition bug.

counter=0

# Function to increment the counter
increment_counter() {
  local new_counter=$(($counter + 1))
  counter=$new_counter
}

# Create two processes that increment the counter simultaneously
for i in {1..2}; do
  increment_counter &
  #No wait for the increment processes to finish
done

# Wait for the background processes to complete
wait

# Print the final counter value. Expected to be 2, but may be less due to race condition.
echo "Final counter value: $counter"