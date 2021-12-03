#!/bin/bash

VER_MAJ=0
VER_MIN=1
VER_PATCH=0

##### ECR login

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/b9s2q8s8

##### Functions

# Usage utility
usage()
{
  echo "WARNING: This utility was written for my particular environment, but it should be "
  echo "         straightforward enough to easily bend to your use case."
  echo
  echo
  #  Compact style of
  #  echo "usage:  build_and_push_tool ["
  #  echo "                              [-a | --admin ver_num]"
  #  echo "                              [-b | --bookings ver_num]"
  #  echo "                              [-d | --data_prod ver_num]"
  #  echo "                              [-f | --flights ver_num]"
  #  echo "                              [-u | --users ver_num]"
  #  echo "                            ]"
  echo "NAME:"
  echo "  Sean's Utopia Project Build and Push Tool "
  echo "USAGE:"
  echo "  build_and_push_tool [image_flags] image_version_number"
  echo "VERSION:"
  echo "  $VER_MAJ.$VER_MIN.$VER_PATCH "
  echo "IMAGE FLAGS:"
  echo "  -a | --admin            Frontend Admin Microservice"
  echo "  -b | --bookings         Backend Bookings Microservice"
  echo "  -d | --data_prod        Backend Data Producers Microservice"
  echo "  -f | --flights          Backend Flights Microservice"
  echo "  -u | --users            Backend Users Microservice"
  echo "NOTE: calling a flag requires a version number to tag the image with."
}

# Function to test that the appropriate type of argument is passed to each builder
param_tester()
{
  if [ $1 == "" || ${$1:0:1} == "-" ]; then
    echo "Every image builder requires a version number, please provide one for $2."
    usage
    exit 1
  fi
}

# Bookings microservice build and push utility
booking_build_and_push()
{
  param_tester $1 -b

  docker build \
    -t utopia_backend_bookings_microservice:v$1 \
    -t seanhorner/utopia_backend_bookings_microservice:v$1 \
    -t public.ecr.aws/b9s2q8s8/utopia_backend_bookings_microservice:v$1 \
    -t utopia_backend_bookings_microservice:latest \
    -t seanhorner/utopia_backend_bookings_microservice:latest \
    -t public.ecr.aws/b9s2q8s8/utopia_backend_bookings_microservice:latest \
    -f backend/bookings_dockerfile \
    backend/microservice_bookings

  docker push seanhorner/utopia_backend_bookings_microservice:v$1
  docker push public.ecr.aws/b9s2q8s8/utopia_backend_bookings_microservice:v$1
  docker push seanhorner/utopia_backend_bookings_microservice:latest
  docker push public.ecr.aws/b9s2q8s8/utopia_backend_bookings_microservice:latest
}

# Flights microservice build and push utility
flights_build_and_push()
{
  param_tester $1 -f

  docker build \
    -t utopia_backend_flights_microservice:v$1 \
    -t seanhorner/utopia_backend_flights_microservice:v$1 \
    -t public.ecr.aws/b9s2q8s8/utopia_backend_flights_microservice:v$1 \
    -t utopia_backend_flights_microservice:latest \
    -t seanhorner/utopia_backend_flights_microservice:latest \
    -t public.ecr.aws/b9s2q8s8/utopia_backend_flights_microservice:latest \
    -f backend/flights_dockerfile \
    backend/microservice_flights

  docker push seanhorner/utopia_backend_flights_microservice:v$1
  docker push public.ecr.aws/b9s2q8s8/utopia_backend_flights_microservice:v$1
  docker push seanhorner/utopia_backend_flights_microservice:latest
  docker push public.ecr.aws/b9s2q8s8/utopia_backend_flights_microservice:latest
}
# Users microservice build and push utility
users_build_and_push()
{
  param_tester $1 -u

  docker build \
    -t utopia_backend_users_microservice:v$1 \
    -t seanhorner/utopia_backend_users_microservice:v$1 \
    -t public.ecr.aws/b9s2q8s8/utopia_backend_users_microservice:v$1 \
    -t utopia_backend_users_microservice:latest \
    -t seanhorner/utopia_backend_users_microservice:latest \
    -t public.ecr.aws/b9s2q8s8/utopia_backend_users_microservice:latest \
    -f backend/users_dockerfile \
    backend/microservice_users

  docker push seanhorner/utopia_backend_users_microservice:v$1
  docker push public.ecr.aws/b9s2q8s8/utopia_backend_users_microservice:v$1
  docker push seanhorner/utopia_backend_users_microservice:latest
  docker push public.ecr.aws/b9s2q8s8/utopia_backend_users_microservice:latest
}

# Data producers microservice build and push utility
data_producers_build_and_push()
{
  param_tester $1 -d

  docker build \
    -t utopia_backend_data_producers_microservice:v$1 \
    -t seanhorner/utopia_backend_data_producers_microservice:v$1 \
    -t public.ecr.aws/b9s2q8s8/utopia_backend_data_producers_microservice:v$1 \
    -t utopia_backend_data_producers_microservice:latest \
    -t seanhorner/utopia_backend_data_producers_microservice:latest \
    -t public.ecr.aws/b9s2q8s8/utopia_backend_data_producers_microservice:latest \
    -f backend/data_producers_dockerfile \
    backend/microservice_data_producers

  docker push seanhorner/utopia_backend_data_producers_microservice:v$1
  docker push public.ecr.aws/b9s2q8s8/utopia_backend_data_producers_microservice:v$1
  docker push seanhorner/utopia_backend_data_producers_microservice:latest
  docker push public.ecr.aws/b9s2q8s8/utopia_backend_data_producers_microservice:latest
}

# Admin microservice build and push utility
admin_build_and_push()
{
  param_tester $1 -a

  docker build \
    -t utopia_frontend_admin_microservice:v$1 \
    -t seanhorner/utopia_frontend_admin_microservice:v$1 \
    -t public.ecr.aws/b9s2q8s8/utopia_frontend_admin_microservice:v$1 \
    -t utopia_frontend_admin_microservice:latest \
    -t seanhorner/utopia_frontend_admin_microservice:latest \
    -t public.ecr.aws/b9s2q8s8/utopia_frontend_admin_microservice:latest \
    -f frontend/admin_dockerfile \
    frontend/microservice_admin

  docker push seanhorner/utopia_frontend_admin_microservice:v$1
  docker push public.ecr.aws/b9s2q8s8/utopia_frontend_admin_microservice:v$1
  docker push seanhorner/utopia_frontend_admin_microservice:latest
  docker push public.ecr.aws/b9s2q8s8/utopia_frontend_admin_microservice:latest
}


##### Main Parser
while [ "$1" != "" ]; do
  case $1 in
    -a | --admin )        shift
                          admin_build_and_push $1
                          ;;
    -b | --bookings )     shift
                          booking_build_and_push $1
                          ;;
    -d | --data_prod )    shift
                          data_producers_build_and_push $1
                          ;;
    -f | --flights )      shift
                          flights_build_and_push $1
                          ;;
    -u | --users )        shift
                          users_build_and_push $1
                          ;;
    -h | --help )         usage
                          exit
                          ;;
    -v | --version )      echo "version: $VER_MAJ.$VER_MIN.$VER_PATCH "
                          exit
                          ;;
    * )                   usage
                          exit 1
                          ;;
  esac
  shift
done

echo "Completed"