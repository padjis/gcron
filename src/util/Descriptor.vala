public const string describedDays[8] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};

public const string describedMonths[12] = {"January", "February", "March", "April", "May", "June", "July", 
                                      "August", "September", "October", "November", "December"};

public const string ordinalNumbers[31] = {"1st", "2nd", "3rd", "4th", "5th", "6th", "7th","8th","9th","10th",
                                        "11th", "12th","13th","14th","15th","16th","17th","18th","19th","20th",
                                      "21st", "22nd", "23rd", "24th", "25th","26th","27th","28th","29th","30th","31th"};

public const string periods[5] = {"minute", "hour", "day of month", "month", "day of week"};

public const string days[8] = {"sun", "mon", "tue", "wed", "thu", "fri", "sat", "sun"};

public const string months[12] = {"jan", "feb", "mar", "apr", "may", "jun",
                                                 "jul", "aug", "sep", "oct", "nov", "dec"};

public class util.Descriptor : GLib.Object{  
    string periodicity;
    string command;
    
    public Descriptor(string periodicity,string command){
        this.periodicity=periodicity;
        this.command=command;
    }
    
    //returns -1 for a bad periodicity and -2 for a bad command
    public string explain(){
        string periodExplanation=getPeriodExplanation();
        if(periodExplanation.has_prefix("-1")){
            return periodExplanation;
        }
        else if(!isCommandValid()){
            return "-2 The command inserted is invalid";
        }else{
            periodExplanation=periodExplanation.strip();
            return "'"+periodExplanation+"' run '"+command+"'";
        }
    }
    
    private string getPeriodExplanation() {
        if (periodicity == "@reboot"){
            return "Every time the computer reboots";
        }else if(periodicity == "@yearly" || periodicity == "@annually"){
            return "Every year (1st of January at 0:00)";
        }else if( periodicity == "@monthly"){
            return "Every month (1st of the month at 0:00)";
        }else if(periodicity == "@weekly"){
            return "Every week (Sunday at 0:00)";
        }else if(periodicity == "@daily" || periodicity == "@midnight"){
            return "Every day (at 0:00)";
        }else if(periodicity == "@hourly"){
            return "Every hour"; 
        }else{
            return readAllCronExpression();
        }
    }
    
    private string readAllCronExpression(){
        if(periodicity==null || !periodicity.contains(" "))
            return "-1 invalid period '"+periodicity+"'";
        string[] expressions=periodicity.split(" ");
        if(expressions.length!=5)
            return "-1 cron elements has not 5 elements";
        string result="";
        int i=0;
        foreach (var expression in expressions) {
            string partialResult=readCronExpression(expressions[i],i);
            if(partialResult.has_prefix("-1")){
                return partialResult;
            }
            result+=partialResult;
            i++;
        }
        if(result.contains(" at every hour")){
            result=result.replace(" at every hour","");
        }
        if(result.contains(" on every day of month")){
            result=result.replace(" on every day of month","");
        }
        if(result.contains(" on every month")){
            result=result.replace(" on every month","");
        }
        if(result.contains(" on every day of week")){
            result=result.replace(" on every day of week","");
        }
        return result;
    }

    private string readRangeCronExpression(string expression,int periodPosition){
        string[] numbersAsString=expression.split("-");
        if(numbersAsString.length!=2 || int.parse(numbersAsString[0])==0 || 
        int.parse(numbersAsString[1])==0 || (int.parse(numbersAsString[0]) > int.parse(numbersAsString[1]))){
            return "-1 "+expression+" is not a valid interval";
        }
        return " from "+ordinalNumbers[int.parse(numbersAsString[0])-1]+" to "+ordinalNumbers[int.parse(numbersAsString[1])-1]+" "+periods[periodPosition];
    }

    private bool isZero(string value){
        for (int a = 0; a < value.length; a++) {
            if(value[a]!='0')
                return false;
        }
        return true;
    }

    private bool isValidRangeExpression(string value,int periodPosition){
        string[] expressions=value.split("-");

        if(expressions.length!=2){
            return false;
        }
        if(!isValidValue(expressions[0],periodPosition) || !isValidValue(expressions[1],periodPosition)){
            return false;
        }
        return true;
    }

    private bool isValidPeriodExpression(string expression,int periodPosition){
        string[] expressions=expression.split("/");
            
        if(expressions.length!=2){
            return false;
        }
        if(!isValidValue(expressions[1],periodPosition)){
            return false;
        }
        if(expressions[0].contains("-")){
            if(!isValidRangeExpression(expressions[0],periodPosition)){
                return false;
            }
        }
        else if(!isValidValue(expressions[0],periodPosition)){
            return false;
        }
        return true;
    }

    private bool isValidCommaExpression(string value,int periodPosition){
        string[] expressions=value.split(",");

        if(expressions.length!=2){
            return false;
        }
        if(!isValidValue(expressions[0],periodPosition) || !isValidValue(expressions[1],periodPosition)){
            return false;
        }
        return true;
    }

    private bool isValidValue(string value,int periodPosition){
        int intValue=int.parse(value);
        if(periodPosition==0){
            if(isZero(value)){
                return true;
            }else if(intValue<=59 && intValue>0){
                return true;
            }
        }
        else if(periodPosition==1){
            if(isZero(value)){
                return true;
            }else if(intValue<=23 && intValue>0){
                return true;
            }
        }
        else if(periodPosition==2){
            if(intValue==0 && !isZero(value)){
                //we can have days here
                foreach (var day in days) {
                    if(day==value){
                        return true;
                    }
                }
            }else if(intValue<=31 || intValue>=1){
                return true;
            }
        }
        else if(periodPosition==3){
            if(intValue==0 && !isZero(value)){
                //we can have months here
                foreach (var month in months) {
                    if(month==value){
                        return true;
                    }
                }
            }else if(intValue<=12 || intValue>=1){
                return true;
            }
        }
        else if(periodPosition==4){
            if(intValue==0 && !isZero(value)){
                //we can have days here
                foreach (var day in days) {
                    if(day==value){
                        return true;
                    }
                }
            }else if(intValue<=6 || intValue>0 || isZero(value)){
                return true;
            }
        }
        return false;
    }

    private bool isValidCronExpression(string expression,int periodPosition){
        if(expression=="*"){
            return true;
        }else if(expression.contains("/")){
            if(isValidPeriodExpression(expression,periodPosition)){
                return true;
            }
        }else if(expression.contains("-")){
            if(isValidRangeExpression(expression,periodPosition)){
                return true;
            }
        }else if(expression.contains(",")){
            if(isValidCommaExpression(expression,periodPosition)){
                return true;
            }
        }else if(isValidValue(expression,periodPosition)){
            return true;
        }
        return false;
    }

    private string readCronExpression(string expressionSent,int periodPosition){
        string expression=expressionSent.down();
        string startWith="";
        if(periodPosition>1){
            startWith=" on";
        }else{
            startWith=" at";
        }

        if(!isValidCronExpression(expression,periodPosition)){
            return "-1 Invalid cron expression";
        }
            
        if(expression=="*"){
            return startWith+" every "+periods[periodPosition];
        }else if(expression.contains("/")){
            string[] expressions=expression.split("/");
            
            if(expressions[0].contains("-")){
                startWith=readRangeCronExpression(expressions[0],periodPosition);
                if(startWith.has_prefix("-1")){
                    return startWith;
                }
            }
            int number=int.parse(expressions[1]);
            return startWith+" every "+ordinalNumbers[number-1]+" "+periods[periodPosition];
        }else if(expression.contains("-")){
            return readRangeCronExpression(expression,periodPosition);
        }else{
            string toReturn=startWith+" "+periods[periodPosition]+" ";
            string[] partsAsString=null;
            if(expression.contains(",")){
                partsAsString=expression.split(",");
            }else{
                partsAsString=new string[1];
                partsAsString[0]=expression;
            }
            int count=0;
            foreach (var part in partsAsString) {
                if(int.parse(part)==0 && !isZero(part)){
                    if(periodPosition==2 || periodPosition==4){
                        //we can have days here
                        int i=0;
                        foreach (var day in days) {
                            if(day==part){
                                part=describedDays[i];
                                toReturn+=part;
                                continue;
                            }
                            i++;
                        }
                        
                    }else if(periodPosition==3){
                        //we can have months here
                        int i=0;
                        foreach (var month in months) {
                            if(month==part){
                                part=describedMonths[i];
                                toReturn+=part;
                                continue;
                            }
                            i++;
                        }
                    }else if(expression.contains("-")){
                        return readRangeCronExpression(expression,periodPosition);
                    }
                  
                    
                }else{
                    int value =int.parse(part);
                
                    if(periodPosition==3){
                        part=describedMonths[value];
                        toReturn+=part;
                    }else if(periodPosition==4){
                        part=describedDays[value];
                        toReturn+=part;
                    }else{
                        toReturn+=value.to_string();
                    }
                }
                
                if(partsAsString.length!=1){
                    if(count==partsAsString.length-2){
                        toReturn+=" and ";
                    }else if(count!=partsAsString.length-1){
                        toReturn+=",";
                    }
                
                    count++;
                }
              
            }
            return toReturn;
        }
    }
    
     private bool isCommandValid() {
	    if (command==null || command==""){
		    return false;
	    }else{
	        return true;
	    }
    }
    
    /*public static int main(string[] args){
        Descriptor descriptor=new Descriptor("23 1-20/2 * * *","/usr/bin/ls");
        //if(descriptor.isZero("0000"))
        print(descriptor.explain());
        return 0;
    } */
}
