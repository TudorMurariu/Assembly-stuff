// 3
//Se dau doua siruri continand caractere. Sa se calculeze si sa se afiseze rezultatul concatenarii tuturor //caracterelor tip cifra zecimala din cel de-al doilea sir dupa cele din primul sir si invers, rezultatul //concatenarii primului sir dupa al doilea.

#include <stdio.h>
void concat(char a[],char b[],char c[]);

char a[101],b[101],c[101],d[101];

int main()
{
    // citim sirurile
    scanf("%s",&a);
    scanf("%s",&b);

    concat(a,b,c);
    printf("\n%s",c);
    concat(b,a,d);
    printf("\n%s",d);
	return 0;
}