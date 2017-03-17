sed '1~3d' sample_train.txt > train_sentences.txt
sed -n 'p;N;N' formatted_train.txt > train_labels.txt

../stanford-parser-2011-09-14/lexparser.sh train_sentences.txt > train_parsed.txt
../stanford-parser-2011-09-14/lexparser.sh formatted_test.txt > test_parsed.txt