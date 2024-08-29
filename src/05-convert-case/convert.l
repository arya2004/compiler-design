%{
#include <stdio.h>
%}

%%

"/*"([^*]|\*+[^*/])*\*+    { printf("%s", yytext); } 
"//".*                     { printf("%s", yytext); } 
[A-Z]                      { printf("%c", yytext[0] + 'a' - 'A'); }
[a-z]                      { printf("%c", yytext[0] + 'A' - 'a'); } 
\n                         { printf("\n"); } 
.                           { printf("%s", yytext); } 

%%



int yywrap(){
     return 1;
}


int main(void) {
    yylex();
    return 0;
}
