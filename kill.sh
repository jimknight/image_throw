kill $(ps -efw | grep image_throw | grep -v grep | awk '{print $2}')
