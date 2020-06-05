ssh jim@lavatiles-jetson "mkdir -p ~/LavaTiles/image_throw"
scp -r ./config jim@lavatiles-jetson:/home/jim/LavaTiles/image_throw/.
scp -r ./lib jim@lavatiles-jetson:/home/jim/LavaTiles/image_throw/.
scp -r ./rel jim@lavatiles-jetson:/home/jim/LavaTiles/image_throw/.
scp kill.sh jim@lavatiles-jetson:/home/jim/LavaTiles/image_throw/.
scp mix.exs jim@lavatiles-jetson:/home/jim/LavaTiles/image_throw/.
scp mix.lock jim@lavatiles-jetson:/home/jim/LavaTiles/image_throw/.
scp run.sh jim@lavatiles-jetson:/home/jim/LavaTiles/image_throw/.
ssh jim@lavatiles-jetson "chmod +x /home/jim/LavaTiles/image_throw/run.sh"
scp status.sh jim@lavatiles-jetson:/home/jim/LavaTiles/image_throw/.
scp release.sh jim@lavatiles-jetson:/home/jim/LavaTiles/image_throw/.

echo "Done"
