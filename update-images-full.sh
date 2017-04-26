#!/bin/bash
#Create file error into tmp 
ERROR_FILE="/tmp/docker-images-update.error"

#docker running?
DOCKER_INFO=$(docker info 2> /dev/null | grep "Containers:" | awk '{print $1}')

if [ "$DOCKER_INFO" == "Containers:" ]
  then
    echo "Docker is running, continue"
  else
    echo "Docker is not running, exit"
    exit 1
fi

#list docker images installed on your system
IMAGES_WITH_TAGS=$(docker images | grep -v REPOSITORY | grep -v TAG | grep -v "<none>" | awk '{printf("%s:%s\n", $1, $2)}')

#docker pull for all images
for IMAGE in $IMAGES_WITH_TAGS; do
  echo "*****"
  echo "Updating $IMAGE"
  docker pull $IMAGE 2> $ERROR_FILE
  if [ $? != 0 ]; then
    ERROR=$(cat $ERROR_FILE | grep "not found")
    if [ "$ERROR" != "" ]; then
      echo "WARNING: Docker image $IMAGE not found in repo, skip"
    else
      echo "ERROR: docker pull failed on image - $IMAGE"
      exit 2
    fi
  fi
  echo "*****"
  echo
done

# did everything finish correctly? Then we can exit
echo "Congratulations, Docker images are up to date"
exit 0
