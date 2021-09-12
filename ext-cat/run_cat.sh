SOURCE_FOLDER=""
MAIN_MAUDE=""
PROPRTY=""
if [ $# -ge 4 ]
then
  SOURCE_FOLDER=$1
  MAIN_MAUDE=$2
  PROPERTY=$3
else
  echo "Usage: $0 code_folder main_file property config"
  exit
fi
OUT_FOLDER=`basename $SOURCE_FOLDER`_copy
mkdir $OUT_FOLDER

CMD_FILE=$OUT_FOLDER/"_cmd_.txt"
CMD_OUT=$OUT_FOLDER/"_cmd_.out"

cp automonitor.maude $OUT_FOLDER/
cp full-maude.maude $OUT_FOLDER/

java -cp cat.jar edu.uiuc.maude.CatGenerateModule $SOURCE_FOLDER $MAIN_MAUDE $OUT_FOLDER

maude $CMD_FILE > $CMD_OUT


java -cp cat.jar edu.uiuc.maude.CatReplaceModule $SOURCE_FOLDER $MAIN_MAUDE $OUT_FOLDER $CMD_OUT
rm $CMD_FILE
rm $CMD_OUT

cp test-mc.maude.original $OUT_FOLDER/test-mc.maude
java -cp cat.jar edu.uiuc.maude.CatReplaceConfig $OUT_FOLDER test-mc.maude  $PROPERTY $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13}

maude $OUT_FOLDER/test-mc.maude > $OUT_FOLDER/cat.out; date >> $OUT_FOLDER/cat.out
