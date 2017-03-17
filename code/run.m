%% parse the train and test set
system('sed "1~3d" ../kaggle/sample_train.txt > ../kaggle/train_sentences.txt');
system('sed -n "p;N;N" ../kaggle/sample_train.txt > ../kaggle/train_labels.txt');
system('../stanford-parser-2011-09-14/lexparser.sh ../kaggle/train_sentences.txt > ../kaggle/train_parsed.txt');
system('../stanford-parser-2011-09-14/lexparser.sh ../kaggle/sample_test.txt > ../kaggle/test_parsed.txt');

%% parse the parse tree
parseTree('../kaggle/train_parsed.txt', 'train');
parseTree('../kaggle/test_parsed.txt', 'test');

%% run the paraphrase classification
simMat