#include "fcgi_stdio.h" /* fcgi library; put it first*/

#include <stdlib.h>

void main(void)
{
	while (FCGI_Accept() >= 0)   {
		int row;
		printf("Content-type: text/html\r\n\r\n<table>");
		for (row = 1000; row--;) {
			int col;
			printf("<tr>");
			for (col = 1; col <= 50; ++col) {
				printf("<td>%d</td>", col);
			}
			printf("</tr>");
		}
		printf("</table>");
	}
}
