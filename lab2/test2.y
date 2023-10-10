%{
#include <stdio.h>
#include <stdlib.h>
#include<string.h>
#include <ctype.h>
#ifndef YYSTYPE
#define YYSTYPE char* //输出字符串
#endif

char idStr[50];
char numStr[50];
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


lines   :   lines expr ';' { printf("%s\n", $2); }//输出字符串
        |   lines ';'
        |
        ;
//拼接字符串
expr  :    expr ADD expr  { $$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"+"); }
      |    expr SUB expr  { $$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"- "); }
      |    expr MUL expr  { $$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"* "); }
      |    expr DIV expr  { $$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"/ "); }
      |    LBRACKET expr RBRACKET  { $$ = (char *)malloc(50*sizeof(char));strcpy($$,$2);}
      |    SUB  expr %prec UMINUS  { $$ = (char*)malloc(50*sizeof(char)); strcpy($$,"- "); strcat($$,$2); }
      |    NUMBER         { $$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$," "); }
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
            int i=0;
            while(isdigit(t)){
                numStr[i]=t;//数字字符
                t=getchar();
                i++;
            }
            // 在字符串最后添加结束符\0
            numStr[i]='\0';
            // 将这个字符串的地址赋给yylval
            yylval=numStr;
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