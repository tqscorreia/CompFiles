%{
#include <stdio.h>
#include <ctype.h>

%}


%%
[a-z]       {printf("%c", toupper(yytext[0]));}
[A-Z]       {printf("%c", yytext[0]);}
.           {printf("%c", yytext[0]);}


%%
int main()
{
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}