#!/bin/bash
#==========================VARIABLES==================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NOCOLOR='\033[0m'
URED='\033[4;31m'
UWHITE='\033[4;37m'
#=====================================================================
LIST_PODS=""
POD_MASTER=""
POD_IP_ADDRESS=""
INITIATE_CLUSTER=""
CONNECT_POD=""
#=====================================================================
echo -e "$PURPLE  ___  ___           ________ $NOCOLOR"
echo -e "$PURPLE |\  \|\  \         |\   __  \ $NOCOLOR"
echo -e "$PURPLE \ \  \_\  \        \ \  \_\ /_  $NOCOLOR"
echo -e "$PURPLE  \ \   __  \        \ \   __  \ $NOCOLOR"
echo -e "$PURPLE   \ \  \ \  \  ___   \ \  \_\  \  ___ $NOCOLOR"
echo -e "$PURPLE    \ \__\ \__\|\__\   \ \_______\|\__\ $NOCOLOR"
echo -e "$PURPLE     \|__|\|__|\|__|    \|_______|\|__| $NOCOLOR"
echo -e "$PURPLE THIS SCRIPT CREATED BY HAFIFBILGILER $NOCOLOR"
echo -e "$PURPLE ________________________________v1.1 $NOCOLOR"
echo -e "$GREEN YOU CAN INITIATE REDIS CLUSTER ON KUBERNETES  WITH THIS SCRIPT $NOCOLOR"
#====================================================================
while true
do

        echo -e "$GREEN  =========================================== $NOCOLOR"
        echo -e "$GREEN | 1) LIST REDIS PODS                        |$NOCOLOR"
        echo -e "$GREEN | 2) INITIATE CLUSTER                       |$NOCOLOR"
        echo -e "$GREEN | 3) CHECK CLUSTER STATUS                   |$NOCOLOR"
        echo -e "$GREEN | 4) CHECK CLUSTER ROLE                     |$NOCOLOR"
        echo -e "$GREEN | 5) SEND DEMO MESSAGES                     |$NOCOLOR"
        echo -e "$GREEN | 6) RESET CLUSTER                          |$NOCOLOR"
        echo -e "$GREEN | 7) EXIT                                   |$NOCOLOR"
        echo -e "$GREEN  =========================================== $NOCOLOR"
#====================================================================
        read -p "WHICH ONE DO YOU WANT ?: " COMMAND
        if [[ $COMMAND > 7   ||  $COMMAND -le 0  ]]
         then
            echo -e  "$RED UNFOURTUNALETY WE DO NOT HAVE YOUR COMMAND IN THE SECTION  $NOCOLOR"
          break;
         fi
        POD_MASTER=$(kubectl get pods -l app=redis-cluster -o jsonpath='{range.items[0]}{.metadata.name}')

        case $COMMAND in
        1)
           if [[ $POD_MASTER -eq redis-cluster-0 ]]
           then
           kubectl get pods -l app=redis-cluster
           else
           echo echo -e "$GREEN YOU DONT HAVE REDIS PODS WITH CREATED SELECTED YAML FILE $NOCOLOR"
           fi
         ;;
        2)
           POD_MASTER=$(kubectl get pods -l app=redis-cluster -o jsonpath='{range.items[0]}{.metadata.name}')
           POD_IP_ADDRESS=$(kubectl get pods -l app=redis-cluster -o jsonpath='{range.items[*]}{.status.podIP}:6379 ')
           POD_ADD_PORT=${POD_IP_ADDRESS::-6}
           CREATE=$(echo "yes" | kubectl exec -it $POD_MASTER -- redis-cli --cluster create --cluster-replicas 1 $POD_ADD_PORT 2>&1)
           if [[ $CREATE == *"[ERR]"* ]]; then
               echo -e  "$RED 1) MAYBE  ALREADY YOU HAVE CLUSTER  $NOCOLOR"
               echo -e  "$RED 2) MAYBE OTHER PROBLEM PLEASE CHECK YOUR PODS AND CLUSTER  $NOCOLOR"
           fi
        ;;
        3)
           echo -e "$GREEN"
           kubectl exec -it $POD_MASTER -- redis-cli cluster info
           echo -e "$NOCOLOR"
         ;;
        4)
          for count in $(seq 0 5); do
           POD=$(kubectl get pods -l app=redis-cluster -o jsonpath={range.items[$count]}{.metadata.name})
           echo -e "$PURPLE===============================================$NOCOLOR"
           echo -e "$GREEN"
           echo $POD
           echo -e "$NOCOLOR"
           kubectl exec -it $POD -- redis-cli role
           echo -e "$PURPLE===============================================$NOCOLOR"
           done
           ;;
         5)
           read -p "PLEASE WRITE YOUR CHOOSE TRY KEY: " KEY
           read -p "PLEASE WRITE YOUR CHOOSE TRY VALUE: " VALUE
           kubectl exec -it $POD_MASTER -- redis-cli set $KEY $VALUE
           echo -e "$GREEN I AM GETTING YOUR KEY AND VALUE...$NOCOLOR"
           kubectl exec -it $POD_MASTER -- redis-cli get $KEY
           ;;
         6)
           for count in $(seq 0 5); do
           POD=$(kubectl get pods -l app=redis-cluster -o jsonpath={range.items[$count]}{.metadata.name})
           echo -e "$PURPLE===============================================$NOCOLOR"
           echo -e "$GREEN"
           echo $POD
           echo -e "$NOCOLOR"
           kubectl exec -it $POD -- sh -c "redis-cli flushall && redis-cli flushdb && redis-cli cluster reset"
           echo -e "$PURPLE===============================================$NOCOLOR"
           done
           ;;
         7)
           echo -e "$BLUE BYE... $NOCOLOR"
           break;
        esac
done