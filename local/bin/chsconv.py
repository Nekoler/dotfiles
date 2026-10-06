#!/usr/bin/python
import sys
import opencc

if len(sys.argv) == 1:
    print(sys.argv[0], 'files')
    exit(1)

conv = opencc.OpenCC('tw2sp')
mapping = {'妳': '你', '牠': '它'}
trans = str.maketrans(mapping)

for i in sys.argv[1:]:
    text = open(i, 'rb+')
    temp = text.read()
    try:
        temp = temp.decode('utf-8')
    except:
        temp = temp.decode('gbk')
    temp = conv.convert(temp)
    temp = temp.translate(trans)
    text.seek(0)
    text.truncate(0)
    text.write(temp.encode())
    text.close()
