#!/usr/bin/env python
# -*- coding: utf-8 -*-
# vim: tabstop=4 shiftwidth=4 softtabstop=4

import sys
import visdom
import time
import os


def main():

    server = os.environ.get('VISDOM_SERVER', 'localhost')
    port = os.environ.get('VISDOM_PORT', 8097)

    vis = visdom.Visdom(server='http://{}'.format(server), port=port)

    attempts = 0
    print("Trying connect to visdom server at : http://{}:{}".format(server, port))
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
