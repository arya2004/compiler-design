%{
#include <stdio.h>
#include <string.h>

int vowel_count(const char *str) {
    int count = 0;
    int seen[5] = {0};  
    while (*str) {
        switch (*str) {
            case 'a': if (!seen[0]) { count++; seen[0] = 1; } break;
            case 'e': if (!seen[1]) { count++; seen[1] = 1; } break;
            case 'i': if (!seen[2]) { count++; seen[2] = 1; } break;
            case 'o': if (!seen[3]) { count++; seen[3] = 1; } break;
            case 'u': if (!seen[4]) { count++; seen[4] = 1; } break;
        }
        str++;
    }
    return count;
}
%}

%%

[a-z]+  {
    if (vowel_count(yytext) == 5) {
        printf("%s\n", yytext);
    }
}


%%

int yywrap(){
     return 1;
}


int main(void) {
    yylex();
    return 0;
}
