import java_cup.runtime.*;

%%

%public
%class Scanner
%implements sym

%line
%column

%cup
%cupdebug

%{
  StringBuffer string = new StringBuffer();
  
  private Symbol symbol(int type) {
    return new MySymbol(type, yyline+1, yycolumn+1);
  }

  private Symbol symbol(int type, Object value) {
    return new MySymbol(type, yyline+1, yycolumn+1, value);
  }
%}

/* White spaces */
WhiteSpace = [ \t\f\r\n\v]

/* comments: no need to worry about them: assume the C preprocessor
 * was already executed - it strips away comments 
 */

/* Identifiers: TODO - make them general, as described in Section
 * 6.4.2.1 in the ANSI C document. Ignore "universal-character-name"
 * and "other implementation-defined characters" mentioned in Section
 * 6.4.2.1.
 */

/* Replace this placeholder with your own definitions */
Identifier = [A-Za-z_][A-Za-z_0-9]*

/* Integer literals: TODO - handle integer literals as described in
 * Section 6.4.4.1 of the ANSI C document. For simplicity, do NOT
 * handle the 'long long' cases. But DO handle long, unsigned,
 * hexadecimal, and octal constants.
 */

/* Replace this placeholder with your own definitions */
DecInteger = [1-9][0-9]*
OctInteger = 0 | 0[1-7][0-7]*
HexInteger = 0[xX][1-9a-fA-F][0-9a-fA-F]*

DecIntegerLiteral = {DecInteger} [uU]?
OctIntegerLiteral = {OctInteger} [uU]?
HexIntegerLiteral = {HexInteger} [uU]?

LongDecIntegerLiteral = {DecInteger} ( [lL] | [uU][lL] | [lL][uU] )
LongOctIntegerLiteral = {OctInteger} ( [lL] | [uU][lL] | [lL][uU] )
LongHexIntegerLiteral = {HexInteger} ( [lL] | [uU][lL] | [lL][uU] )

/* Floating point literals: TODO - handle floating point literals as 
 * described in Section 6.4.4.2 of the ANSI C document. For
 * simplicity, do NOT handle the 'long double' cases. But DO handle
 * hexadecimal floating constants, e/E and p/P notation, and f/F
 * suffixes.
 */        

/* Replace this placeholder with your own definitions */
ExponentPart = [eE][+-]?[0-9]+
Float = [0-9]+ ( \. [0-9]* {ExponentPart}? | {ExponentPart} )

DoubleLiteral = {Float} [lL]?
FloatLiteral = {Float} [fF]

%%

<YYINITIAL> {

  /* Keywords: TODO - add all keywords from Section 6.4.1 */

  "double"                       { return symbol(DOUBLE); }
  "for"                          { return symbol(FOR); }
  "int"                          { return symbol(INT); }
  "return"                       { return symbol(RETURN); }
  "void"                         { return symbol(VOID); }
  
  /* Punctuators: TODO - add all punctuators from Section 6.4.6 except
  for the last eight punctuators */

  "("                            { return symbol(LPAREN); }
  ")"                            { return symbol(RPAREN); }
  "{"                            { return symbol(LBRACE); }
  "}"                            { return symbol(RBRACE); }
  "["                            { return symbol(LBRACK); }
  "]"                            { return symbol(RBRACK); }
  ";"                            { return symbol(SEMICOLON); }
  ","                            { return symbol(COMMA); }
  "="                            { return symbol(ASSGN); }
  "<"                            { return symbol(LT); }
  "++"                           { return symbol(PLUSPLUS); }
  "+"                            { return symbol(PLUS); }
  "-"                            { return symbol(MINUS); }
  "/"                            { return symbol(DIV); }
  "*"                            { return symbol(STAR); }

  
  /* Integer literals: TODO - for any such literal, the token type
   * should be INTEGER_LITERAL, as shown below. The attribute value
   * should be either a Java Integer object (for values that are not
   * 'long') or a Java Long object (for values that are 'long'). You
   * can assume that the value of the literal is always small enough
   * to fit in a Java Integer or Long, respectively. For example, if
   * the literal is "17", "0x11", or "021", you should create a Java
   * Integer object containing the Java 'int' value 17. 
   */

  /* replace this placeholder with your own definitions */
  {DecIntegerLiteral}            { return symbol(INTEGER_LITERAL, Integer.valueOf(yytext().replaceAll("[uU]",""),10)); }
  {HexIntegerLiteral}            { return symbol(INTEGER_LITERAL, Integer.valueOf(yytext().replaceAll("[uU]","").substring(2),16)); }
  {OctIntegerLiteral}            { return symbol(INTEGER_LITERAL, Integer.valueOf(yytext().replaceAll("[uU]","").substring(1),8)); }
  
  // Longs
  {LongDecIntegerLiteral}            { return symbol(INTEGER_LITERAL, Long.valueOf(yytext().replaceAll("[uUlL]","").substring(0),10)); }
  {LongHexIntegerLiteral}            { return symbol(INTEGER_LITERAL, Long.valueOf(yytext().replaceAll("[uUlL]","").substring(2),16)); }
  {LongOctIntegerLiteral}            { return symbol(INTEGER_LITERAL, Long.valueOf(yytext().replaceAll("[uUlL]","").substring(1),8)); }

  /* Floating-point literals: TODO - for any such literal, the token
   * type should be FLOATING_POINT_LITERAL, as shown below. The
   * attribute value should be either a Java Float object (for values
   * that are 'float') or a Java Double object (for values that are
   * 'double'). You can assume that the value of the literal is always
   * small enough to fit in a Java Float or Double, respectively. For
   * example, if the literal is ".5625f", "5625e-4f", or "0X1.2p-1f",
   * you should create a Java Float object containing the Java 'float'
   * value 0.5625.
   */

  /* replace this placeholder with your own definitions */
  {DoubleLiteral}                { return symbol(FLOATING_POINT_LITERAL, Double.valueOf(yytext().replaceAll("[lL]",""))); }
  {FloatLiteral}                { return symbol(FLOATING_POINT_LITERAL, Float.valueOf(yytext())); }
  
  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }

  /* identifiers */ 
  {Identifier}                   { return symbol(IDENTIFIER, yytext()); }  
}

/* error fallback */
.|\n                             { throw new RuntimeException("Illegal character \""+yytext()+
                                                              "\" at line "+(yyline+1)+", column "+(yycolumn+1)); }
<<EOF>>                          { return symbol(EOF); }
