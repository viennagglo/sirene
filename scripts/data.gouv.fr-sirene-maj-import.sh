#! /bin/bash

echo "1/8 : REPERTOIRE DE TRAVAIL - TELECHARGEMENT DU FICHIER SIRENE - MAJ MENSUELLE"
NOW=$(date +"%Y%m%d-%Hh%Mmins")
echo $NOW
MAJDATE=$(date --date='-1 month' +"%Y%m")
MAJFOLDER="sirene"'_'${MAJDATE}'_'"M_M"
chmod -Rf 777 cd /home/igeo/partage/sirene/data/data.gouv.fr/maj_mensuelle/
cd /home/igeo/partage/sirene/data/data.gouv.fr/maj_mensuelle/
rm -Rf $MAJFOLDER && mkdir $MAJFOLDER && cd $MAJFOLDER
#ON SE PLACE DANS LE DOSSIER DE TELECHARGEMENT ET ON TELECHARGE LE FICHIER DE MAJ MENSUELLE
wget http://files.data.gouv.fr/sirene/$MAJFOLDER.zip
unzip $MAJFOLDER".zip"
rm -Rf $MAJFOLDER".zip"
MAJFILE=${MAJFOLDER}".csv"
mv sirc*.csv $MAJFILE

echo "2/8 : DECOUPAGE DU FICHIER NATIONAL EN FICHIERS DEPARTEMENTAUX"
#for d in `seq -w 1 19` 2A 2B `seq 21 99`; do
for d in 38 69; do
  head -n 1 $MAJFILE > sirene_$d.csv
done
# split du fichier national sur DEPET (25ème colonne)
#awk -F";" -v OFS=";" 'BEGIN { FPAT = "([^;]+)|(\"[^\"]+\")" } {gsub("\"","",$25); print >> "sirene_"$25".csv" }' $MAJFILE
awk -F";" -v OFS=";"  'BEGIN { FPAT = "([^;]+)|(\"[^\"]+\")" } {gsub("\"","",$25); if($25 == '38' || $25 == '69') print >> "sirene_"$25".csv" }' $MAJFILE
cat sirene_.csv >> sirene_99.csv
rm sirene_DEPET.csv

echo "3/8 : FUSION DES 2 FICHIERS DEPARTEMENTAUX SUR LEQUEL SE TROUVE LE TERRITOIRE DE L'EPCI"
sed -i 1d sirene_69.csv
cat sirene_38.csv sirene_69.csv > _sirene_38_69.csv
shopt -s extglob
rm -f !(_sirene_38_69.csv)

echo "4/8 : REMBOURRAGE DE ZERO SUR LE CHAMP COMET (code INSEE)"
awk -F";" -v OFS=";" 'BEGIN { FPAT = "([^;]+)|(\"[^\"]+\")" } {gsub("\"","",$28); $28=sprintf("%03s", $28); print $0 }' _sirene_38_69.csv > sirene_38_69.csv
shopt -s extglob
rm -f !(sirene_38_69.csv)

echo "5/8 : DECOUPAGE DU FICHIER REUNISSANT LE DEPARTEMENT 38 ET 69 EN FICHIER EPCI"
for d in $(awk -F";" -v OFS=";" 'BEGIN { FPAT = "([^;]+)|(\"[^\"]+\")" } {gsub("\"","",$33); print $33}' sirene_38_69.csv | sort | uniq); do
  head -n 1 sirene_38_69.csv > sirene_$d.csv
done
awk -F";" -v OFS=";" 'BEGIN { FPAT = "([^;]+)|(\"[^\"]+\")" } {gsub("\"","",$33); print >> "sirene_"$33".csv" }' sirene_38_69.csv
shopt -s extglob
rm -f !(sirene_38_69.csv|sirene_243800455.csv|sirene_246900633.csv|sirene_200059392.csv)

echo "6/8 : FUSION DES FICHIERS EPCI EN UN SEUL FICHIER"
sed -i 1d sirene_200059392.csv | sed -i 1d sirene_246900633.csv
cat sirene_243800455.csv sirene_200059392.csv sirene_246900633.csv > sirene_epci_vca.csv
shopt -s extglob
rm -f !(sirene_38_69.csv|sirene_epci_vca.csv)

echo "7/8 : DECOUPAGE DES FICHIERS EPCI EN FICHIER COMMUNAL"
for d in $(awk -F";" -v OFS=";" 'BEGIN { FPAT = "([^;]+)|(\"[^\"]+\")" } {gsub("\"","",$28); print $25$28}' sirene_epci_vca.csv | sort | uniq); do
  head -n 1 sirene_epci_vca.csv > sirene_$d.csv
done
awk -F";" -v OFS=";" 'BEGIN { FPAT = "([^;]+)|(\"[^\"]+\")" } {gsub("\"","",$28); print >> "sirene_"$25$28".csv" }' sirene_epci_vca.csv
shopt -s extglob
rm -f !(sirene_epci_vca.csv|sirene_38087.csv|sirene_38107.csv|sirene_38110.csv|sirene_38131.csv|sirene_38157.csv|sirene_38160.csv|sirene_38199.csv|sirene_38215.csv|sirene_38232.csv|sirene_38238.csv|sirene_38318.csv|sirene_38336.csv|sirene_38459.csv|sirene_38480.csv|sirene_38484.csv|sirene_38487.csv|sirene_38544.csv|sirene_38558.csv|sirene_69007.csv|sirene_69064.csv|sirene_69080.csv|sirene_69097.csv|sirene_69118.csv|sirene_69119.csv|sirene_69189.csv|sirene_69193.csv|sirene_69235.csv|sirene_69236.csv|sirene_69252.csv|sirene_69253.csv)

echo "8/8 : FUSION DES FICHIERS COMMUNAUX EN UN SEUL FICHIER AFIN DE CONSTRUIRE LE FICHIER DE L'EPCI"
sed -i 1d sirene_38107.csv| sed -i 1d sirene_38110.csv| sed -i 1d sirene_38131.csv| sed -i 1d sirene_38157.csv| sed -i 1d sirene_38160.csv| sed -i 1d sirene_38199.csv| sed -i 1d sirene_38215.csv| sed -i 1d sirene_38232.csv| sed -i 1d sirene_38238.csv| sed -i 1d sirene_38318.csv| sed -i 1d sirene_38336.csv| sed -i 1d sirene_38459.csv| sed -i 1d sirene_38480.csv| sed -i 1d sirene_38484.csv| sed -i 1d sirene_38487.csv| sed -i 1d sirene_38544.csv| sed -i 1d sirene_38558.csv| sed -i 1d sirene_69007.csv| sed -i 1d sirene_69064.csv| sed -i 1d sirene_69080.csv| sed -i 1d sirene_69097.csv| sed -i 1d sirene_69118.csv| sed -i 1d sirene_69119.csv| sed -i 1d sirene_69189.csv| sed -i 1d sirene_69193.csv| sed -i 1d sirene_69235.csv| sed -i 1d sirene_69236.csv| sed -i 1d sirene_69252.csv| sed -i 1d sirene_69253.csv
cat sirene_38087.csv sirene_38107.csv sirene_38110.csv sirene_38131.csv sirene_38157.csv sirene_38160.csv sirene_38199.csv sirene_38215.csv sirene_38232.csv sirene_38238.csv sirene_38318.csv sirene_38336.csv sirene_38459.csv sirene_38480.csv sirene_38484.csv sirene_38487.csv sirene_38544.csv sirene_38558.csv sirene_69007.csv sirene_69064.csv sirene_69080.csv sirene_69097.csv sirene_69118.csv sirene_69119.csv sirene_69189.csv sirene_69193.csv sirene_69235.csv sirene_69236.csv sirene_69252.csv sirene_69253.csv > sirene_vca.csv
shopt -s extglob
rm -f !(sirene_38_69.csv|sirene_epci_vca.csv|sirene_vca.csv)

echo "BDD - 1/1"
#ON SE PLACE DANS LE REPERTOIRE DES REQUETES SQL
chmod -Rf 777 cd /home/igeo/partage/sirene/data/data.gouv.fr/maj_mensuelle/$MAJFOLDER/
MAJTABLE="sirene.vca_maj_sirene_"$MAJDATE
INPUTMAJFOLDER="/home/igeo/partage/sirene/data/data.gouv.fr/maj_mensuelle/$MAJFOLDER/sirene_vca.csv"
OUTPUTCSVFILE="/home/igeo/partage/sirene/data/data.gouv.fr/maj_mensuelle/$MAJFOLDER/EUDONET_MAJ"'_'$MAJFOLDER".csv"
chmod -Rf 777 /home/igeo/partage/sirene/data/data.gouv.fr/maj_mensuelle/$MAJFOLDER
sudo -u postgres psql -d vca -c "SET client_encoding = 'utf-8'"
sudo -u postgres psql -d vca -v table=$MAJTABLE -v folder="'$INPUTMAJFOLDER'" -f "/home/igeo/partage/sirene/sql/01-CREATE_vca_maj_sirene.sql"
sudo -u postgres psql -d vca -v table=$MAJTABLE -v output_csvfile="'$OUTPUTCSVFILE'" -f "/home/igeo/partage/sirene/sql/02-EXPORT_vca_maj_sirene_TO_Eudonet.sql"
unoconv --format xls -i FilterOptions="59,34,0,1,1/2/13/2/87/5,1036,true,true" "EUDONET_MAJ"'_'$MAJFOLDER".csv"

echo -ne "Bonjour,\nVoici la pièce jointe.\nCordialement" | mutt "fallamanche@vienne-condrieu-agglomeration.fr" -b "igeo@vienne-condrieu-agglomeration.fr" -s "EXPORT MENSUEL - SIRENE" -a "EUDONET_MAJ"'_'$MAJFOLDER".xls"