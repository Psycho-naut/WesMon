#!/bin/bash

# VIEW ALL USER
#.<<FUNZ

ICON(){

    echo """
     ____  __.__                           _____                       
    |    |/ _|__| ______ ______           /     \ _____ _______ ___.__.
    |      < |  |/  ___//  ___/  ______  /  \ /  \\\\__  \\\\_  __ <   |  |
    |    |  \|  |\___ \ \___ \  /_____/ /    Y    \/ __ \|  | \/\___  |
    |____|__ \__/____  >____  >         \____|__  (____  /__|   / ____|
            \/       \/     \/                  \/     \/       \/     
    Type 'help' for list command
    Type 'quit' for exit
            """
}

HELP(){
    
    echo """
____________________ ______________________________________________________

CREATE_NEW_DB       :   create db 
SHOW_DB             :   show db
CREATE TABLE        :   create table
MAKE BACKUP         :   

CONVERT OUTPUT
___________________ _______________________________________________________
FROM KISMET IN KML : convert kml
FROM KISMET IN CSV : convert csv

    """
}


CONVERT_OUTPUT_ON_KML(){
    pwd
#    PATH_CONVERT=$(grep "DEFAULT_CONVERT" WesMon.conf | cut -d "=" -f2-)
    pwd

    DATA=""
    FILE=$(ls | grep $DATA)
    GPS=$(ls | grep "$DATA.gpsxml")
    NTX=$(ls | grep "$DATA.netxml")
    KML=$(ls | grep "$DATA.kml")
    

    echo -e "File captured"
    ls -hl
    echo -e "insert date:\t"
    read DATA
    sudo python netxml2kml.py --kml -o Output$DATA $GPS $NTX
    mv $GPS $NTX DATA
    mv $KML KML_FILE
}


CONVERT_FILE_CSV(){
    echo -e "File captured"
    ls -hl
    echo -e "insert date:\t"
    read DATA
    echo "Pulizia file ..."
    KML=$(ls | grep "Output$DATA.kml")
    cat $KML | sed -n '/SSID:/,/]]/p' >> Output0.tmp
    cat Output0.tmp | sed 's/<[^>]*>//g' >> Output01.tmp
    tr -d "]>" < Output01.tmp > Output02.tmp
    echo "Conversione file ..."

    # CONVERT FILE TXT IN CSV
    awk 'BEGIN {i=1} NF { if (i<=7) { printf("%s,", $0); i++ } else { print; i = 1} }' Output02.tmp >> Output$DATA.csv
    echo "File convertito"
}

CREATE_CSV_TABLE(){
    echo "Insert name DB"
    read DATABASE
    echo "Insert name TABLE"
    read NAME_TABLE
    mysql -u root -e"
    use $DATABASE;
    CREATE TABLE $NAME_TABLE
    (SSID VARCHAR(255) NULL,
    MAC VARCHAR(255) NULL,
    Manuf VARCHAR(255) NULL,
    Type VARCHAR(255) NULL,
    CHANNEL VARCHAR(255) NULL,
    Encryption VARCHAR(255) NULL,
    LASTTIME VARCHAR(255) NULL,
    GPS VARCHAR(255) NULL)"
}

LOAD_CSV(){
    echo "Insert name Table"
    reat NAME_TB
    echo "Insert file csv"
    ls -l *.csv* /opt/Kismet/KML_FILE
    reat DATI
    mysql -u root -e"
    LOAD DATA 
    INFILE $DATI
    INTO TABLE $NAME_TB
    FIELDS TERMINATED BY ','"
}


CREATE_USER(){
    #ROOT_USER
    echo -e "Name of user:\t"
    read NEW_USER
    echo -e "Select new password:\t"
    read -s NEW_PASSW

    mysql -uroot -e "CREATE USER '$NEW_USER'@'localhost' IDENTIFIED BY '$NEW_PASSW'"
}

SHOW_USERS(){
    #ROOT_USER

    mysql -uroot -e "SELECT User, Host FROM mysql.user;"
}

CREATE_DB(){
NON LEGGE LA VARIABILE

    #echo "Name new DB:\t"
    DATABASE=""
    echo -e "Insert name of new Database:\t"
    mysqladmin create $DATABASE}

SHOW_DB(){
    mysql -uroot -e "SHOW DATABASES"
}

SHOW_TABLE(){
    SHOW_DB
    echo "Select Db"
    read SELECT_DB
    mysql -u root -e"
    use $SELECT_DB;
    SHOW TABLES"
}


main(){

    read COMMAND

    for command in case
    do
        case $COMMAND in
            "show u" )
                SHOW_USERS ;;
            "show db" )
                SHOW_DB ;;
            "help" )
                HELP ;;
            "create user" )
                CREATE_USER  ;;
            "create db" )
                CREATE_DB  ;;
            "convert kml" )
                CONVERT_OUTPUT_ON_KML ;;
            "convert csv" )
                CONVERT_FILE_CSV ;;
            "show table" )
                SHOW_TABLE ;;

        esac
    main
    done
}
clear
ICON
main
#FUNZ

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

# Import Csv in DB

echo "Select file:"
read $FILE 

sudo mysql -uroot -e "LOAD DATA INFILE $FILE INTO TABLE"


testok
