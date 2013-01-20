import java.io.*;
import java_cup.runtime.Symbol;

/**
 * Simple test driver for the java lexer. Just runs it on some
 * input files and produces debug output. Needs Symbol class from
 * parser. 
 */
public class MyLexer {

  public static void main(String argv[]) {

    for (int i = 0; i < argv.length; i++) {
      try {
        System.out.println("Lexing ["+argv[i]+"]");
        Scanner scanner = new Scanner(new FileReader(argv[i]));
                
        Symbol s;
        do {
          s = scanner.next_token();
          System.out.println("TOKEN: " + s);
        } while (s.sym != sym.EOF);
        
        System.out.println("No errors.");
      }
      catch (Exception e) {
        e.printStackTrace(System.out);
        System.exit(1);
      }
    }
  }
}
