docker_username="yss"
image_name="yssimage"
container_name="ysscontainer"
version="1.0"

exist_image_name=$(docker images -q ${docker_username}/${image_name}:${version})
exist_container_name=$(docker ps -a -q --filter name=${container_name})


# 컨테이너 중지 및 삭제
if [ ! -z "$exist_container_name" ]; then
    echo "=> Stopping and removing existing container..."
    docker stop ${exist_container_name}
    docker rm ${exist_container_name}
fi


# 이미지 삭제
if [ ! -z "$exist_image_name" ]; then
    echo "=> Removing existing image..."
    docker rmi ${exist_image_name}
fi



# new-build/re-build docker image
echo "=> Build new image..."
docker build --tag ${docker_username}/${image_name}:${version} .

# Run container
echo "=> Run container..."
docker run -it -p 8080:8080 --privileged=true --name ${container_name} ${docker_username}/${image_name}:${version}  //sbin/init
