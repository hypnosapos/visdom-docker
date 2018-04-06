#!/usr/bin/env python
# -*- coding: utf-8 -*-
# vim: tabstop=4 shiftwidth=4 softtabstop=4

import sys
import visdom
import time
import os
import argparse


def main():

    parser = argparse.ArgumentParser(description='Test visdom server.')
    parser.add_argument('--port', type=int, metavar='port',
                        default=os.environ.get('VISDOM_PORT', 8097),
                        help='The server port. Defaults to VISDOM_PORT env variable or 8097')
    parser.add_argument('--server', type=str, metavar='server',
                        default=os.environ.get('VISDOM_SERVER', 'localhost'),
                        help='The server bind ip. Default to VISDOM_SERVER env variable or localhost')

    args = parser.parse_args()

    vis = visdom.Visdom(server='http://{}'.format(args.server), port=args.port)

    attempts = 0
    print("Trying connect to visdom server at: {}:{}".format(vis.server, vis.port))
    while not vis.check_connection() and attempts <= 10:
        attempts += 1
        time.sleep(2)
        print("Retrying connection ... [{}/{}]".format(attempts, 10))
    assert vis.check_connection(), "Unable to establish connection :-(("
    print("Connected!! :-)")


if __name__ == "__main__":
    try:
        main()
    except Exception as ex:
        print('Unexpected error: %s' % ex)
        sys.exit(1)
    sys.exit(0)
