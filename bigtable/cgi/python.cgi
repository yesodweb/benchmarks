#!/usr/bin/python
import sys

sys.stdout.write('Content-Type: text/html\n\n')

sys.stdout.write("<table>")

for i in range(1, 1001):
    sys.stdout.write('<tr>')
    for j in range (1, 51):
        sys.stdout.write("<td>%i</td>" % j)
    sys.stdout.write('</tr>')
sys.stdout.write('</table>')
