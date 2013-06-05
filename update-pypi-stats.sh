#!/bin/bash
PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
cd ~/dev/pypi-stats/

pyps update -q django-memento
pyps total -q django-memento_stats.pkl > django-memento-total.txt
pyps update -q django-nopassword
pyps total -q django-nopassword_stats.pkl > django-nopassword-total.txt
