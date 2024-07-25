
%{


%}

%%

[\n] {
	printf("Hello World\n");	
}

	
%%
int yywrap(void){}
int main()
{

 yylex();
 return 0;
}