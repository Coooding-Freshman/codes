#!/usr/local/bin/python
import sys
import os

def split(fileName, size):
    myFile=open(fileName)
    i = 0
    counter = 0
    output=open("output0.txt", 'a')
    for line in myFile:
        if counter == size:
            i += 1
            counter = 0
            output=open("output{}.txt".format(i), 'a')
        output.write(line)
        counter += 1

    myFile.close()
    if os.path.getsize("output{}.txt".format(i)) == 0:
        os.system("rm output{}.txt".format(i))

if __name__ == "__main__":
    split(sys.argv[1], int(sys.argv[2]))
