#!/usr/local/bin/python3
# -*- coding: utf-8 -*-
import subprocess as sub
import os
import time

def decorator(fun):
    def _deco():
        print("---begin---")
        a = fun()
        print("end with %d" % (a))
    return _deco

@decorator
def fun():
    ans = sub.check_output("ps aux | grep '.*python.*'", shell = True)
    ansStr = bytes.decode(ans)
    ansList = ansStr.split('\n')
    returnCode = os.path.exists("/usr/bin/python")
    if not returnCode:
        sub.call("touch test.sem", shell = True)
    else:
        time.sleep(10)
    for line in ansList:
        print(line)
    return 1

if __name__ == '__main__':
    fun()
