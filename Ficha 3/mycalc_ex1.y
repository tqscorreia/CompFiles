%{
  #include <stdio.h>
  int yylex(void);
  void yyerror(const char*);
  char* yytext;
%}

%token NUMBER

%%

%right '=';
%left '+' '-';
%right '*' '/';


calc: expression '\n'                       {printf("%d\n", $1);}
    | calc expression '\n'                 {printf("%d\n", $2);}
    ;

expression: expression '+' expression   {$$=$1+$3;}
          | expression '-' expression   {$$=$1-$3;}
          | expression '*' expression   {$$=$1*$3;}
          | expression '/' expression   {if ($3==0){
                                          printf("Divide by zero\n");
                                          YYABORT;
                                        }else
                                          $$=$1/$3;}
          | '(' expression ')'          {$$=$2;}
          | '-' expression              {$$=-$2;}
          | '+' expression              {$$=$2;}
          | NUMBER                      {$$=$1;}
          ;
%%

int main() {
    yyparse();
    return 0;
}

void yyerror (const char *s) { 
     printf ("%s: %s\n", s, yytext);
}
