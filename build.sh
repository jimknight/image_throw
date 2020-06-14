ssh lavatiles-jetson@lavatiles-jetson "mkdir -p ~/LavaTiles/image_throw"
scp -r ./config lavatiles-jetson@lavatiles-jetson:~/LavaTiles/image_throw/.
scp -r ./lib lavatiles-jetson@lavatiles-jetson:~/LavaTiles/image_throw/.
scp -r ./rel lavatiles-jetson@lavatiles-jetson:~/LavaTiles/image_throw/.
scp kill.sh lavatiles-jetson@lavatiles-jetson:~/LavaTiles/image_throw/.
scp mix.exs lavatiles-jetson@lavatiles-jetson:~/LavaTiles/image_throw/.
scp mix.lock lavatiles-jetson@lavatiles-jetson:~/LavaTiles/image_throw/.
scp run.sh lavatiles-jetson@lavatiles-jetson:~/LavaTiles/image_throw/.
ssh lavatiles-jetson@lavatiles-jetson "chmod +x ~/LavaTiles/image_throw/run.sh"
scp status.sh lavatiles-jetson@lavatiles-jetson:~/LavaTiles/image_throw/.
scp release.sh lavatiles-jetson@lavatiles-jetson:~/LavaTiles/image_throw/.

echo "Done"
