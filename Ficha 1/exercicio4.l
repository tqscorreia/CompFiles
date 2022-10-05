name                [a-zA-Z]
%%

{name}+"@"{name}+"."{name}+("."{name}+)*    {printf("%s", yytext);}
{name}                                      {;}
.                                           {;}

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