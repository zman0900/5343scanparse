
public class MySymbol extends java_cup.runtime.Symbol {
  private int line;
  private int column;

  public MySymbol(int type, int line, int column) {
    this(type, line, column, -1, -1, null);
  }

  public MySymbol(int type, int line, int column, Object value) {
    this(type, line, column, -1, -1, value);
  }

  public MySymbol(int type, int line, int column, int left, int right, Object value) {
    super(type, left, right, value);
    this.line = line;
    this.column = column;
  }

  public int getLine() {
    return line;
  }

  public int getColumn() {
    return column;
  }

  private String getTokenName(int token) {
    try {
      java.lang.reflect.Field [] classFields = sym.class.getFields();
      for (int i = 0; i < classFields.length; i++) {
        if (classFields[i].getInt(null) == token) {
          return classFields[i].getName();
        }
      }
    } catch (Exception e) {
      e.printStackTrace(System.err);
    }

    return "UNKNOWN TOKEN";
  }


  public String toString() {   
      return "line "+line+", column "+column+", sym: "+getTokenName(sym) + (value == null ? "" : (", value: "+value+"[" + value.getClass().getName() + "]" ));
  }
}
