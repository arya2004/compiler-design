%{
	// yacc program

      #include<stdio.h>
	
%}

%token VERBTOKEN NOUNTOKEN PRONOUNTOKEN ADJTOKEN 
%token ADVTOKEN CONJTOKEN PREPTOKEN DEFTOKEN ARTICLETOKEN

%%
stat:	 compound	{printf("\n This Is A Compound Statement.\n\n");}
	|simple	{printf("\n This Is A Simple Statement.\n\n");}
	;

compound: simple CONJTOKEN simple
	;

simple:	 subject VERBTOKEN ARTICLETOKEN object
           |subject VERBTOKEN ARTICLETOKEN ADJTOKEN object
           |subject VERBTOKEN ADVTOKEN
	;
	
subject:	 NOUNTOKEN
		|PRONOUNTOKEN
			;
object:    NOUNTOKEN
%%

extern FILE *yyin;
int main(void)
{
	printf("\n\n Please put a dot . at the end of statement.");
	printf("\n Type quit to exit.\n\n");
	do
	{
		yyparse();
	}while(!feof(yyin));

	return 0;
}

int yyerror(char *s)
{
	printf("\n %s.\n", s);
}