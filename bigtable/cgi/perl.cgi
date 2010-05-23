#!/usr/bin/perl

print "Content-Type: text/html\n\n<table>";
for($i = 1000; $i--;) {
    print '<tr>';
    for($j = 1; $j <= 50; ++$j) {
        print "<td>$j</td>";
    }
    print '</tr>';
}
print '</table>';
