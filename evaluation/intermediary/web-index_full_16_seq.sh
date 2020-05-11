mkfifo {1,2,3}grams

cat "$IN_DIR/p1.out_16_00" "$IN_DIR/p1.out_16_01" "$IN_DIR/p1.out_16_02" "$IN_DIR/p1.out_16_03" "$IN_DIR/p1.out_16_04" "$IN_DIR/p1.out_16_05" "$IN_DIR/p1.out_16_06" "$IN_DIR/p1.out_16_07" "$IN_DIR/p1.out_16_08" "$IN_DIR/p1.out_16_09" "$IN_DIR/p1.out_16_10" "$IN_DIR/p1.out_16_11" "$IN_DIR/p1.out_16_12" "$IN_DIR/p1.out_16_13" "$IN_DIR/p1.out_16_14" "$IN_DIR/p1.out_16_15"|
  sed "s#^#$WIKI#" |
  extract_text |
  tr -cs A-Za-z '\n' |
  tr A-Z a-z |
  grep -vwFf $WEB_INDEX_DIR/stopwords.txt |
  $WEB_INDEX_DIR/stem-words.js |
  tee 3grams 2grams 1grams > /dev/null &

cat 1grams |
    sort |
    uniq -c |
    sort -rn > 1-grams.txt &

cat 2grams |
    tr -cs A-Za-z '\n' |
    tr A-Z a-z |
    bigrams_aux |
    sort |
    uniq -c |
    sort -rn > 2-grams.txt &

cat 3grams |
    tr -cs A-Za-z '\n' |
    tr A-Z a-z |
    trigrams_aux |
    sort |
    uniq -c |
    sort -rn # >> 3-grams.txt

rm {1,2,3}grams