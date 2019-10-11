%{
#include<stdio.h>
#include<string.h>

char jan[] = "January";
char feb[] = "February";
char mar[] = "March";
char apr[] = "April";
char may[] = "May";
char jun[] = "June";
char jul[] = "July";
char aug[] = "August";
char sep[] = "September";
char oct[] = "October";
char nov[] = "November";
char dec[] = "December";

char m[] = "mo";
char d[] ="da";
char y[] = "year";
char date[50];
%}



%%
[0-3][0-9][\t" "]([a-zA-Z]+)[\t" "][0-2][0-9][0-9][0-9] {
d[0]=yytext[0]; d[1]=yytext[1];
y[0]=yytext[strlen(yytext)-4]; y[1]=yytext[strlen(yytext)-3]; y[2]=yytext[strlen(yytext)-2]; y[3]=yytext[strlen(yytext)-1]; y[4]='\0';
strncpy(date,yytext+3,strlen(yytext)-8); strcat(date, " "); strcat(date, d); strcat(date, ", "); strcat(date, y);
fprintf(yyout, "%s", date);} 

[0-2][0-9][0-9][0-9][\t" "]([a-zA-Z]+)[\t" "][0-3][0-9] {
y[0]=yytext[0]; y[1]=yytext[1]; y[2]=yytext[2]; y[3]=yytext[3];
d[0]=yytext[strlen(yytext)-2]; d[1]=yytext[strlen(yytext)-1];
strncpy(date, yytext+5, strlen(yytext)-3); strcat(date, ", "); strcat(date, y);
fprintf(yyout, "%s", date);}

[0-9][0-9]\/[0-3][0-9]\/[0-2][0-9][0-9][0-9] {
m[0]=yytext[0]; m[1]=yytext[1];
d[0]=yytext[3]; d[1] = yytext[4];
y[0]=yytext[6]; y[1]=yytext[7];y[2]=yytext[8];y[3]=yytext[9];
if (strcmp(m, "1")==0){strcpy(date,jan);} else if (strcmp(m, "2")==0){strcpy(date,feb);} else if (strcmp(m, "3")==0){strcpy(date,mar);} else if (strcmp(m, "4")==0){strcpy(date,apr);}
else if (strcmp(m, "5")==0){strcpy(date,may);} else if (strcmp(m, "6")==0){strcpy(date,jun);} else if (strcmp(m, "7")==0){strcpy(date,jul);}  else if (strcmp(m, "8")==0){strcpy(date,aug);}
else if (strcmp(m, "9")==0){strcpy(date,sep);} else if (strcmp(m, "10")==0){strcpy(date,oct);} else if (strcmp(m, "11")==0){strcpy(date, nov);} else {strcpy(date, dec);}
strcat(date, " "); strcat(date, d); strcat (date, ", "); strcat(date, y);
fprintf(yyout, "%s",date);}

.            fprintf(yyout, "%s", yytext);
%%


int yywrap()
{
return 1;
}

int main()
{
extern FILE *yyin, *yyout;
yyin=fopen("input_file.txt", "r");
yyout=fopen("output_file.txt", "w");
yylex();
} 
