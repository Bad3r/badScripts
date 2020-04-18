#! /bin/python

import re
import sys
import requests
# USAGE: python3 find_WHOIS.py Google LLC
for i in re.findall(r'<tr><td>([^<]+)</td>',requests.get("https://viewdns.info/reversewhois/?q="+'+'.join(sys.argv[1:]),headers={'User-Agent':"Mozilla"}).text)[1:]:
    print(i)