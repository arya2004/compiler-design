%{
#include<stdio.h>
#include<stdlib.h>       
%}

%%
a{1}[a-z ]*a{1}	 { fprintf(yyout, "%s", yytext); }
. {}
%%


int yywrap(){
     return 1;
}


int main()
{


	extern FILE *yyin, *yyout;

	
	yyin = fopen("input.txt", "r");

	yyout = fopen("output.txt", "w");

	yylex();

    fclose(yyin);
    fclose(yyout);

    FILE *fptr1, *fptr2;
    char filename[100];
    int c;


    // Open one file for reading
    fptr1 = fopen("output.txt", "r");



    // Open another file for writing
    fptr2 = fopen("input.txt", "w");


    // Read contents from file
    while ((c = fgetc(fptr1)) != EOF)
    {
        fputc(c, fptr2);
    }

    fclose(fptr1);
    fclose(fptr2);

	return 0;
}
