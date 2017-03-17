# format training data
# with open('formatted_train.txt', 'w') as f1:
# 	with open('train.csv', 'r') as f2:
# 		lines = f2.readlines()
# 		for i, line in enumerate(lines):
# 			try:
# 				split = line.split('\",\"')
# 				sent1 = split[3]
# 				sent2 = split[4]
# 				isDuplicate = split[5].replace('"', '')

# 				f1.write(isDuplicate)
# 				f1.write(sent1)
# 				f1.write('\n')
# 				f1.write(sent2)
# 				f1.write('\n')
# 			except IndexError:
# 				print i
# 				print line.split('\",\"')

import re

# format test data
with open('formatted_test.txt', 'w') as f1:
	with open('test.csv', 'r') as f2:
		lines = f2.readlines()
		for i, line in enumerate(lines):
			try:
				start = line.find(',')
				split = (line[start+2:len(line)]).split('\",\"')
				sent1 = split[0]
				sent2 = split[1][0:len(split[1])-2]

				sent1split = re.split('(?<=[.:;?])\s', sent1)
				if len(sent1split) > 0:
					f1.write(sent1split[0])
				else: f1.write(sent1)
				f1.write('\n')

				sent2split = re.split('(?<=[.:;?])\s', sent2)
				if len(sent2split) > 0:
					f1.write(sent2split[0])
				else: f1.write(sent2)
				f1.write('\n')
			except IndexError:
				print i
				print line.split('\",\"')