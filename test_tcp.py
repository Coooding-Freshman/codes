#!/usr/bin/env python
#-*- coding: utf-8 -*-
# Author: Zhenghao Li
# Date: 2018-04-11

import socket
import argparse


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--host", help = "ip address")
    parser.add_argument("--port", type = int, help = "port default 6341", default = 6341)
    parser.add_argument("--cmd", help = "command you need to send", default = 'None')
    args = parser.parse_args()

    mySocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    mySocket.connect((args.host, args.port))
    print "Connect to {}:{}".format(args.host, args.port)
    if args.cmd == 'None':
        print "Please input command:"
        while True:
            cmd = raw_input("> ")
            print "Send \"{}\".".format(cmd)
            mySocket.sendall('test'+cmd)
    else:
        print "Send \"{}\".".format(args.cmd)
        mySocket.sendall(args.cmd)

    mySocket.close()
