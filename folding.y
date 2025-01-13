%{
	#include <stdio.h>
	#include <iostream>
	#include <string>
	#include <map>
	#include <math.h>
	using namespace std;
	#include "y.tab.h"
	extern FILE *yyin;
	extern int yylex();
	void yyerror(string s);
	
	int is_digit(char* str)
	{
		int i = 0;
		while (str[i])
		{
			if (str[i] < '0' || str[i] > '9')
				return 0;
			i++;
		}
		return 1;
	}
	
	int	ft_len(int n)
	{
		int	len;

		len = 0;
		if (n <= 0)
			len = 1;
		while (n != 0)
		{
			n = n / 10;
			len++;
		}
		return (len);
	}
	
	char	*ft_itoa(int n)
	{
		char	*str;
		int		len;
		long	number;

		number = n;
		len = ft_len(number);
		str = (char *)malloc(len + 1);
		if (!str)
			return (NULL);
		str[len] = '\0';
		len--;
		if (number == 0)
			*str = '0';
		if (number < 0)
		{
			str[0] = '-';
			number *= -1;
		}
		while (number != 0)
		{
			str[len] = (number % 10) + '0';
			number = number / 10;
			len--;
		}
		return (str);
	}
%}

%union
{
	int number;
	char * str;

}

%token <str> IDENTIFIER
%token <number> INTEGER
%token EQUALSYM PLUSOP SUBOP DIVIDEOP ASTERISKOP OVEROP SEMICOLON
%type<str> value expression
%%

program:
	statement
	|
	statement program
    ;

statement:
	IDENTIFIER EQUALSYM expression SEMICOLON
	{
		cout << $1 << " = " << $3 << ";" << endl;
	}
    ;

expression:
	value 
	{
		$$ = $1;
	}
	|
	value PLUSOP value     
	{
		if (is_digit($1) && is_digit($3))
		{
			int val;
			
			val = atoi($1) + atoi($3);
			$$ = ft_itoa(val);
		}
		else
		{
			sprintf($$, "%s %s %s", $1, "+", $3);
		}
	}
    |
	value SUBOP value     
	{
		if (is_digit($1) && is_digit($3))
		{
			int val;
			
			val = atoi($1) - atoi($3);
			$$ = ft_itoa(val);
		}
		else
		{
			sprintf($$, "%s %s %s", $1, "-", $3);
		}
	}
    |
	value ASTERISKOP value     
	{
		if (is_digit($1) && is_digit($3))
		{
			int val;
			
			val = atoi($1) * atoi($3);
			$$ = ft_itoa(val);
		}
		else
		{
			sprintf($$, "%s %s %s", $1, "*", $3);
		}
	}
    |
	value DIVIDEOP value
	{
		if (is_digit($1) && is_digit($3))
		{
			int val;
			
			val = atoi($1) / atoi($3);
			$$ = ft_itoa(val);
		}
		else
		{
			sprintf($$, "%s %s %s", $1, "/", $3);
		}
	}
	|
	value OVEROP value     
	{
		if (is_digit($1) && is_digit($3))
		{
			int val;
			
			val = pow(atoi($1), atoi($3));
			$$ = ft_itoa(val);
		}
		else
		{
			sprintf($$, "%s %s %s", $1, "^", $3);
		}
	}
    ;
	
value:
	INTEGER
	{
		$$ = ft_itoa($1);
	}
	|
	IDENTIFIER
	{
		$$ = $1;
	}
%%

void yyerror(string s){
	cout << "error: " << s << endl;
}
int yywrap(){
	return 1;
}
int main(int argc, char *argv[])
{
    yyin = fopen(argv[1], "r");
    yyparse();
    fclose(yyin);
    return 0;
}
