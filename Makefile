all: folding algebraic pro

folding: lex yacc_folding
	g++ lex.yy.c y.tab.c -ll -o folding
	
algebraic: lex yacc_alge
	g++ lex.yy.c y.tab.c -ll -o algebraic
	
pro: lex yacc_pro
	g++ lex.yy.c y.tab.c -ll -o propagation

yacc_folding: folding.y
	yacc -d folding.y
	
yacc_alge: algebraic.y
	yacc -d algebraic.y 
	
yacc_pro: propagation.y
	yacc -d propagation.y 

lex: lex.l
	lex lex.l
fclean: 
	rm lex.yy.c y.tab.c  y.tab.h  folding algebraic propagation


