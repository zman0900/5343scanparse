.PHONY: all clean

all: Main.class MySymbol.class Scanner.class sym.class

Main.class MySymbol.class Scanner.class sym.class: Main.class.intermediate

.INTERMEDIATE: Main.class.intermediate
Main.class.intermediate: Main.java MySymbol.java Scanner.java parser.java sym.java
	rm -f *.class
	javac Main.java

Scanner.java: simpleC.flex
	rm -f Scanner.java
	java JFlex.Main simpleC.flex

parser.java sym.java: simpleC.cup.intermediate

.INTERMEDIATE: simpleC.cup.intermediate
simpleC.cup.intermediate: simpleC.cup
	java java_cup.Main -interface < simpleC.cup

clean:
	rm -f *.class Scanner.java sym.java parser.java
