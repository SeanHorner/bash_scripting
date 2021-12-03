#!/bin/bash


# Version Markers
VER_MAJ=0
VER_MIN=2
VER_PATCH=6


########################################################################################################################
#######################################                                         ########################################
#######################################               FUNCTIONS                 ########################################
#######################################                                         ########################################
########################################################################################################################


# ECR login
# Requires AWS-CLI to be installed and configured with a profile with appropriate permissions.
login()
{
  aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/b9s2q8s8
}


# Usage utility
usage()
{
  echo
  echo "WARNING: This utility was written for my particular environment, but it should be "
  echo "         straightforward enough to easily bend to your use case."
  echo
  echo "NAME:"
  echo "  Sean's Utopia Project Build and Push Tool "
  echo
  echo "USAGE:"
  echo "  build_and_push_tool [aux_flags] [image_flags image_version_number]"
  echo
  echo "VERSION:"
  echo "  $VER_MAJ.$VER_MIN.$VER_PATCH "
  echo
  echo "IMAGE FLAGS:"
  echo " *Note*: Calling a flag requires a version number to tag the image with."
  echo "  -a | --admin            Frontend Admin Microservice"
  echo "  -b | --bookings         Backend Bookings Microservice"
  echo "  -d | --data_prod        Backend Data Producers Microservice"
  echo "  -f | --flights          Backend Flights Microservice"
  echo "  -u | --users            Backend Users Microservice"
  echo
  echo "AUXILIARY FLAGS:"
  echo "  -h | --help             Displays this usage message for this tool."
  echo "  -v | --version          Displays the tool's version in MAJ.MIN.PATCH format."
  echo "  -l | --login            Gets ECR credentials for pushing to ECR (req. AWS-CLI)."
  echo
}


# Function to test that the appropriate type of argument is passed to each builder
param_tester()
{
  param="$1"
  first_letter="${param:0:1}"
  if [ "$param" == "" ] || [ "$first_letter" == "-" ]; then
    echo "Every image builder requires a version number, please provide one for $2."
    echo "Please use the -h or --help flag to see appropriate usage."
    exit 1
  fi
}


# Admin microservice build and push utility
admin_build_and_push()
{
  param_tester "$1" "-a"

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


# Bookings microservice build and push utility
booking_build_and_push()
{
  param_tester "$1" "-b"

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


# Data producers microservice build and push utility
data_producers_build_and_push()
{
  param_tester "$1" "-d"

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


# Flights microservice build and push utility
flights_build_and_push()
{
  param_tester "$1" "-f"

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
  param_tester "$1" "-u"

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


tester_func()
{
  echo "Ran the tester with param $1"
}


########################################################################################################################
#######################################                                         ########################################
#######################################           MAIN PARSER LOOP              ########################################
#######################################                                         ########################################
########################################################################################################################

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
    -l | --login )        login
                          ;;
    -t )                  if [ "$2" == "" ] || [ ${"$2":0:1} == "-" ]; then
                            tester_func
                          else
                            tester_func "$2"
                            shift
                          fi
                          ;;
    * )                   usage
                          exit 1
                          ;;
  esac
  shift
done

echo "Successfully completed build and push."