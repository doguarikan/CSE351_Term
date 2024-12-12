%{
	#include <stdio.h>
	#include <iostream>
	#include <string>
	using namespace std;
	#include "y.tab.h"
	extern FILE *yyin;
	extern int yylex();
	void yyerror(string s);
	int res = 0;
%}

%union
{
	int number;
	char * str;
}

%token <str> IDENTIFIER
%token <number> INTEGER
%token INTSYM EQUALSYM PLUSOP SUBOP DIVIDEOP ASTERISKOP


%%

decls:
	decls decl
	|
	decl
	;
decl:
	INTSYM IDENTIFIER EQUAL operand {
		cout << "int " << $2 << " = " << res << endl;
		res = 0;
	}
	;

operand:
	INTEGER
	{
		res += $1;
	}
	|
	INTEGER PLUSOP INTEGER
	{
		res = $1 + $3;
	}
	|
	INTEGER SUBOP INTEGER
	{
		res = $1 - $3; 
	}
	|
	INTEGER DIVIDEOP INTEGER
	{
		res = $1 / $3;
	}
	|
	INTEGER ASTERISKOP INTEGER
	{
		res = $1 * $3; 
	}
	;

%%
void yyerror(string s){
	cout << "error: " << s << endl;
}
int yywrap(){
	return (1);
}
int main(int argc, char **argv)
{
    yyin = fopen(argv[1], "r");
    yyparse();
    fclose(yyin);
    return (0);
}
