#!/bin/bash

# VIEW ALL USER
.<<FUNZ

HELP(){
    
    echo """
RUN_KISMET          :   run kismet 

CREATE_NEW_USER     :   create -n -u <NAME_NEW_USER> -p <PASSWORD_NEW_USER>
CREATE_NEW_DB       :   create -n -db <NAME_NEW_DATABASE>
SHOW_USERS          :   show -us
SHOW_DB             :   show -db
    """
}

ROOT_USER(){
    echo "Root Password:\t"
    read -s PASSW_ROOT
}

CONVERT_OUTPUT_ON_KML(){
    pwd
    PATH_CONVERT=$(grep "DEFAULT_CONVERT" WesMon.conf | cut -d "=" -f2-)
    cd $PATH_CONVERT
    pwd

}

START_KISMET(){
    pwd
    PATH_START=$(grep "DEFAULT_START" WesMon.conf | cut -d "=" -f2-)
    cd $PATH_START
    pwd
    #sudo kismet
}

CREATE_USER(){
    #ROOT_USER

    echo "Name of user:\t"
    read NEW_USER
    echo "Select new password:\t"
    read -s NEW_PASSW

    mysql -uroot -e "CREATE USER '$NEW_USER'@'localhost' IDENTIFIED BY '$NEW_PASSW'"
}

SHOW_USERS(){
    #ROOT_USER

    mysql -uroot -e "SELECT User, Host FROM mysql.user;"
}

CREATE_DB(){
    echo "Name new DB:\t"
    read NAME_DB

    mysql -uroot -p $PASSW -e "CREATE DATABASE $NAME_DB;"
}

SHOW_DB(){
    mysql -uroot -p $PASSR -e "SHOW DATABASES"
}
#FUNZ


main(){

    echo "PROGRAMMAAAA"
    read COMMAND

    for command in case
    do
        case $COMMAND in
            "show -u" )
                SHOW_USERS ;;
            "show -db" )
                SHOW_DB ;;
            "help" )
                HELP ;;
            "run kismet" )
                START_KISMET ;;


        esac
    main
    done
}
FUNZ

.<<testok
echo "Root Password:\t"
read -s PASSR

sudo mysql --user="root" --password="$PASSR" --execute="SELECT User, Host FROM mysql.user;"

# CREATE A NEW USER

echo "Root Password:\t"
read -s PASSR

echo "Name new user:\t"
read NAME

echo "Select new password:\t"
read -s PASSW

sudo mysql --user="root" --password="$PASSR" --execute="CREATE USER '$NAME'@'localhost' IDENTIFIED BY '$PASSW';"


# CREATE A DB

echo "Name new DB:\t"
read NAME_DB


sudo mysql --user="$USR" --password="$PASSR" --execute="CREATE DATABASE $NAME_DB;"

sudo mysql --user="$USR" --password="$PASSR" --execute="SHOW DATABASES"

testok