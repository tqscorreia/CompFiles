
%X DOCUMENT TITLE CHAPTER SECTION ITEMIZE ENUMERATE

%{
#include <stdio.h>
#include <ctype.h>
int chap = 0;
int sec = 1;
int en = 1;
%}

%%

"\\begin{document}" {BEGIN DOCUMENT;}
.   {;}
\n  {;}

<DOCUMENT>"\\end{document}" 	{BEGIN 0;}
<DOCUMENT>"\\title{"   			{printf("\n"); BEGIN TITLE;}
<DOCUMENT>"\\chapter{" 			{printf("%d. ", ++chap); sec = 1; BEGIN CHAPTER;}
<DOCUMENT>"\\section{" 			{printf("%d.%d", chap, sec++); BEGIN SECTION;}
<DOCUMENT>"\\begin{itemize}\n" 	{BEGIN ITEMIZE;}
<DOCUMENT>"\\begin{enumerate}\n" {en = 1; BEGIN ENUMERATE;}
<DOCUMENT>\\\\\n 				{printf("\n");}
<DOCUMENT>. 					{printf("%c", yytext[0]);}



<TITLE>[a-z]   					{printf("%c", toupper(yytext[0]));}  //funcao toupper passa para maiusculas
<TITLE>"}" 						{BEGIN DOCUMENT;}
<TITLE>\n 						{;}
<TITLE>. 						{ECHO;}

<CHAPTER>\n 					{;}
<CHAPTER>"}" 					{BEGIN DOCUMENT;}
<CHAPTER>. 						{printf("%c", yytext[0]);}

<SECTION>\n 					{;}
<SECTION>"}" 					{BEGIN DOCUMENT;}
<SECTION>.   					{printf("%c", yytext[0]);}

<ITEMIZE>"\\end{itemize}" 		{BEGIN DOCUMENT;}
<ITEMIZE>"\n\\end{itemize}" 	{BEGIN DOCUMENT;}
<ITEMIZE>"\\item" 				{printf(".");}
<ITEMIZE>\n 					{printf("\n");}
<ITEMIZE>. 						{printf("%c", yytext[0]);}

<ENUMERATE>"\\end{enumerate}" 	{BEGIN DOCUMENT;}
<ENUMERATE>"\n\\end{enumerate}" {BEGIN DOCUMENT;}
<ENUMERATE>"\\item" 			{printf("%d-", en++);}
<ENUMERATE>\n 					{printf("\n");}
<ENUMERATE>. 					{printf("%c", yytext[0]);}





%%
int main()
{
yylex(); return 0;
}
int yywrap() {
return 1;
}
