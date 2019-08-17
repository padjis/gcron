public class util.Descriptor : GLib.Object{  
    string periodicity;
    string command;
    
    public Descriptor(string periodicity,string command){
        this.periodicity=periodicity;
        this.command=command;
    }
    
    //returns -1 for a bad periodicity and -2 for a bad command
    public string explain(){
        if(!checkPeriodicity()){
            return "-1";
        }
        return periodicity+" - "+command;
    }
    
    private bool checkPeriodicity() {
        try{
             Regex regex = new Regex ("^\\s*($|#|\\w+\\s*=|(\\?|\\*|(?:[0-5]?\\d)(?:(?:-|/|,)(?:[0-5]?\\d))?(?:,(?:[0-5]?\\d)(?:(?:-|/|,)(?:[0-5]?\\d))?)*)\\s+(\\?|\\*|(?:[0-5]?\\d)(?:(?:-|/|,)(?:[0-5]?\\d))?(?:,(?:[0-5]?\\d)(?:(?:-|/|,)(?:[0-5]?\\d))?)*)\\s+(\\?|\\*|(?:[01]?\\d|2[0-3])(?:(?:-|/|,)(?:[01]?\\d|2[0-3]))?(?:,(?:[01]?\\d|2[0-3])(?:(?:-|/|,)(?:[01]?\\d|2[0-3]))?)*)\\s+(\\?|\\*|(?:0?[1-9]|[12]\\d|3[01])(?:(?:-|/|,)(?:0?[1-9]|[12]\\d|3[01]))?(?:,(?:0?[1-9]|[12]\\d|3[01])(?:(?:-|/|,)(?:0?[1-9]|[12]\\d|3[01]))?)*)\\s+(\\?|\\*|(?:[1-9]|1[012])(?:(?:-|/|,)(?:[1-9]|1[012]))?(?:L|W)?(?:,(?:[1-9]|1[012])(?:(?:-|/|,)(?:[1-9]|1[012]))?(?:L|W)?)*|\\?|\\*|(?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)(?:(?:-)(?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC))?(?:,(?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)(?:(?:-)(?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC))?)*)\\s+(\\?|\\*|(?:[0-6])(?:(?:-|/|,|#)(?:[0-6]))?(?:L)?(?:,(?:[0-6])(?:(?:-|/|,|#)(?:[0-6]))?(?:L)?)*|\\?|\\*|(?:MON|TUE|WED|THU|FRI|SAT|SUN)(?:(?:-)(?:MON|TUE|WED|THU|FRI|SAT|SUN))?(?:,(?:MON|TUE|WED|THU|FRI|SAT|SUN)(?:(?:-)(?:MON|TUE|WED|THU|FRI|SAT|SUN))?)*)(|\\s)+(\\?|\\*|(?:|\\d{4})(?:(?:-|/|,)(?:|\\d{4}))?(?:,(?:|\\d{4})(?:(?:-|/|,)(?:|\\d{4}))?)*))$");
            //check periodicity
		    if (regex.match (periodicity)){
			    print ("%s matched!\n", regex.get_pattern ());
			    return true;
		    }
        }catch(RegexError e){
          
        }        
		return false;
    }
    
    public static int main(string[] args){
        Descriptor descriptor=new Descriptor("Hello, this is what you should print \n","/usr/bin/ls");
        print(descriptor.explain());
        return 0;
    }
}
