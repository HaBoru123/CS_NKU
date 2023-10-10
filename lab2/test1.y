%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#ifndef YYSTYPE
#define YYSTYPE double
#endif
int yylex();
//yyparse()不断调用yylex函数来得到token类型
extern int yyparse();
FILE* yyin;
void yyerror(const char* s);
%}

%token ADD
%token SUB
%token MUL
%token DIV
%token LBRACKET
%token RBRACKET
%token NUMBER

%left ADD SUB
%left MUL DIV
%right UMINUS

%%


lines   :   lines expr ';' { printf("%f\n", $2); }
        |   lines ';'
        |
        ;

expr    :   expr ADD expr { $$ = $1 + $3; }
        |   expr SUB expr { $$ = $1 - $3; }
        |   expr MUL expr { $$ = $1 * $3; }
        |   expr DIV expr { $$ = $1 / $3; }
        |   LBRACKET expr RBRACKET { $$ = $2; }
        |   SUB expr %prec UMINUS { $$ =-$2; }//优先级为UMINUS
        |   NUMBER {$$=$1;}
        ;

%%


int yylex()
{
    int t;
    while(1){
        t = getchar();
        if (t == ' ' || t == '\t' || t == '\n') {
            //do nothing
        }
        else if (isdigit(t)){
            yylval = 0;
            yylval = yylval * 10 + t - '0';
            int flag = 0;
            while (isdigit(t)){
                 yylval = 0;
                 while (isdigit(t)) {
                    yylval = yylval * 10 + t - '0';
                    t = getchar();
                 }
            }
            ungetc(t,stdin);
            return NUMBER;
        }
        else if (t == '+'){
            return ADD;
        }
        else if (t == '-'){
            return SUB;
        }
        else if (t == '*'){
            return MUL;
        }
        else if (t == '/'){
            return DIV;
        }
        else if(t=='('){
            return LBRACKET;
        }
        else if(t==')'){
            return RBRACKET;
        
        }
        else{
            return t;
        }
    }
    // place your token retrieving code here
    return getchar ();
}

int main(void)
{
    yyin = stdin ;
    do {
            yyparse();
    } while (! feof(yyin));
    return 0;
}
void yyerror(const char* s) {
    fprintf(stderr,"Parse error: %s\n",s);
    exit(1);
}