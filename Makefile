.PHONY: all clean

all: MyLexer.class MySymbol.class Scanner.class sym.class

MyLexer.class MySymbol.class Scanner.class sym.class: MyLexer.class.intermediate

.INTERMEDIATE: MyLexer.class.intermediate
MyLexer.class.intermediate: MyLexer.java MySymbol.java Scanner.java parser.java sym.java
	rm -f *.class
	javac MyLexer.java

Scanner.java: simpleC.flex
	rm -f Scanner.java
	java JFlex.Main simpleC.flex

parser.java sym.java: simpleC.cup.intermediate

.INTERMEDIATE: simpleC.cup.intermediate
simpleC.cup.intermediate: simpleC.cup
	java java_cup.Main -interface < simpleC.cup

clean:
	rm -f *.class Scanner.java sym.java parser.java
