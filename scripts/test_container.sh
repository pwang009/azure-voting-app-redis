count=0
echo "$env:STAGE_NAME"

container_url=http://localhost:7080
ret=$(curl -s -I -o /dev/null -w '%{http_code}' $container_url)
echo $ret