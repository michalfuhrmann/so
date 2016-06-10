#!/usr/bin/env bash
# Program disk usage ktory umozliwia wyswietalnie zajetego miejsca przez pliki w danej lokalizacji
#Nie korzysta z polecenia ls

function help {

  echo ""
  echo "Program wyswietlajacy zuzycie miejsca przez pliki w danej lokalizacji"
  echo "Uzycie programu: "
  echo "-h : <brak parametrow> - wyswietla pomoc"
  echo "-v : B/KB/MB - wyswietla rozmiar plikow konwertujac je do odpowiedniej wartosci podanej przez uzytkownika"
  echo "-d : <brak parametrow> - wyswietla szczegolowe informacje o pliku tj ich dostep, date utworzenia oraz "
  echo "-s : <brak parametrow> -wyswietla laczna ilosc miejsca zajeta przez wszystkie pliki"
  echo "-l : 0/1/2/3... etc - definiuje stopien zaglebienia jaki powinien byc brany pod uwage podczas wyswietlania plikow"
  echo "-S : name/size/date - definiuje po jaki parametrze pliki powinny byc posortowane"
  echo "-B : <brak parametrow> - wlacza sortowania (domyslnie pliki beda sortowane po nazwie jesli nie zostal sprecyzowany zaden z innych parametrow)"
  echo "-r : <brak parametrow> - definiuje czy sortowanie powinno byc odwrocone "
}


DIR=`pwd`
DETAILED=false
VALUE='B'
SUMMARIZE=false
DEPTH_LEVEL=INFINITE
SORTED=false
SORT_BY=""
REVERSED=false


if [ $# = 0 ]
then
    echo "$DIR"
fi

if [ -z "$a" ]
then
   ALL=true
fi

 echo "ALL $ALL"



while getopts ":h:v:d:l:s:c:r:" opt; do
  case $opt in
    h)echo "h was triggered $OPTARG"
      help
      exit
      ;;
    v)echo "v was triggered $OPTARG"
      if [ $OPTARG == "B" ] || [ $OPTARG == "KB" ] || [ $OPTARG == "MB" ]; then
          VALUE=$OPTARG
      else
        echo " Tylko wartosci B/KB lub MB sa mozliwe"
        exit
      fi
      ;;
    d)echo "d was triggered $OPTARG"
      DETAILED=true
      ;;
    s)echo "s was triggered $OPTARG"
      SUMMARIZE=true
      ;;
    l)echo "l was triggered $OPTARG"
      DIRECTORY=$OPTARG
      ;;
    S)echo "S was triggered $OPTARG"
      DIRECTORY=$OPTARG
      ;;
    B)echo "B was triggered $OPTARG"
      DIRECTORY=$OPTARG
      ;;
    r)echo "r was triggered $OPTARG"
      DIRECTORY=$OPTARG
      ;;


    \?)
      echo "Invalid option: -$OPTARG" >&2
      help
      exit 1
      ;;

  esac
done

DZIELNIK=0;
if [ $VALUE == 'B' ];then
  DZIELNIK=0.001
elif [[ $VALUE == 'KB' ]]; then
  DZIELNIK=1
elif [[ $VALUE == 'MB' ]]; then
  DZIELNIK=1000
fi


if [ $SUMMARIZE == true ];then
  find $DIR -ls | while read line; do
    echo "$line"
  done
  exit
fi

find $DIR -ls | awk '{ print "| " $9/'$DZIELNIK' " '$HUMAN_READABLE' "  "\t""| " $11"\t"  }' #detailed search
