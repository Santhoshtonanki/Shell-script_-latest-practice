Date=$(date)
day=$(date +%A-%Y-%m-%d-%H-%M-%S)

echo "Current time stamp: $Date"
echo "exact date and Day and time with right now: $day"

start_time=$(date +%s)

sleep 10

end_time=$(date +%s)

echo "Script execution time: $((end_time - start_time)) seconds"
