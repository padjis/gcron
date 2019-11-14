#!/usr/bin/env python3

from os import path, environ
import subprocess

prefix = environ.get('MESON_INSTALL_PREFIX', '/usr/local')
datadir = path.join(prefix, 'share')

if not environ.get('DESTDIR'):
    print('Updating icon cache…')
    subprocess.call(['gtk-update-icon-cache', '-qtf', path.join(datadir, 'icons', 'hicolor')])
