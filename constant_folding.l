digit	[0-9]
letter	[A-Za-z]
%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}
%%

"int"		{
			return INTSYM;
		}

[0-9]+ 	{
			yylval.number=atoi(yytext);
			return INTEGER;
		}

\= 		return EQUAL;
\+		return PLUSOP;
\-		return SUBOP;
\*		return ASTERISKOP;
\/		return DIVIDEOP;

{letter}({letter}|{digit})* 	{
		yylval.str=strdup(yytext);
		return IDENTIFIER;
	}
\n
[ \t]+
%%
