%{
#include "y.tab.h"  /* Include generated header file from Yacc */
%}

%%
[a-zA-Z][a-zA-Z0-9]*     { return ID; }   /* Match variable names */
[0-9]+                   { return NUM; }  /* Match numbers */
"="                      { return '='; }
"*"                      { return '*'; }
"+"                      { return '+'; }
[ \t]                    ;                 /* Ignore whitespace */
\n                       { return 0; }     /* Return 0 on new line (end of input) */
.                        { return yytext[0]; }
%%

int yywrap() {
    return 1;
}
