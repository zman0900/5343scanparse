import java.io.*;
   
public class Main {
  static public void main(String argv[]) {    
      System.out.println("/* [Main] start. */");	
      try {
	  parser p = new parser(new Scanner(new FileReader(argv[0])));
	  Object result = p.parse().value; 
	  System.out.println(result);
      } catch (Exception e) {
	  /* do cleanup here -- possibly rethrow e */
	  e.printStackTrace();
      }
      System.out.println("/* [Main] end. */");	
  }
}


