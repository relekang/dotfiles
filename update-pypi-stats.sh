#!/bin/bash
PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
cd ~/dev/pypi-stats/

pyps update -q django-nopassword
pyps total -q django-nopassword_stats.pkl > django-nopassword-total.txt
#echo "django-nopassword: "; cat django-nopassword-total.txt; echo " "
