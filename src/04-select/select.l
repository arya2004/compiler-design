%{       
%}


%%
a{1}[a-z ]*a{1}	 { fprintf(yyout, "%s", yytext); }
. {fprintf(yyout, "");}
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
	return 0;
}
