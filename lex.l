digit	[0-9]
letter	[A-Za-z]
%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}
%%


[0-9]+ 	{
			yylval.number=atoi(yytext);
			return INTEGER;
		}

\;		return SEMICOLON;
\= 		return EQUALSYM;
\+		return PLUSOP;
\-		return SUBOP;
\*		return ASTERISKOP;
\^		return OVEROP;
\/		return DIVIDEOP;

{letter}({letter}|{digit})* 	{
		yylval.str=strdup(yytext);
		return IDENTIFIER;
	}
\n
[ \t]+
%%