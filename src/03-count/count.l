%{
#include<stdio.h>
int lines=0,spaces=0,tabs=0,character=0,words=0;        
%}
 

%%
[\n] { lines++; character+=yyleng;}
[  \t] { spaces++; character+=yyleng;}
[^\t] { tabs++; character+=yyleng;}
[^\t\n ]+ { words++;  character+=yyleng;}  
%%
 
int yywrap(){
     return 1;
}


int main(){
    printf("Enter the Sentence : ");
    yylex();
    printf("Number of lines : %d\n",lines);
    printf("Number of spaces : %d\n",spaces);
    printf("Number of tabs, words, characterarc : %d , %d , %d\n",tabs,words,character);
     
    return 0;
}