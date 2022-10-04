numero				[0-9]+
float               [0-9]+("."|",")[0-9]+

%%

{numero}				    {printf("Integer");}
{numero}l                   {printf("Long");}
{numero}f                   {printf("Float");}
{numero}u                   {printf("Unsigned int");}
{numero}ul                  {printf("Unsigned long");}
{float}e("+"|"-"){numero}   {printf("Floating point");}
{numero}e("+"|"-"){numero}  {printf("Floating point");}
{float}                 	{printf("Float");}
"-"{numero}				    {printf("Inteiro negativo");}
"-"{float}          	    {printf("Real negativo");}
ab+c|a*(bc)+                {printf("token!");}

%%
int main(){
    yylex();
    return 0;
}

int yywrap(){
    return 1;
}

