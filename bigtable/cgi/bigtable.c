#include <stdio.h>

int main(void)
{
	int row;
	printf("Content-Type: text/html\n\n<table>");
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
