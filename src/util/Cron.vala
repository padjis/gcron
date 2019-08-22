public class util.Cron : GLib.Object{

    public string readCronAsString () {
        string result= execute("crontab -l");
        if(result==null || result.length==0)
            return "-1";
        string getResult=result;
        string[] lines=getResult.split("\n");
        string finalResult="";
        int addGoToNewLine=0;
        for (int a = 0; a < lines.length; a++) {
            if(lines[a]!=null && lines[a].length!=0 && !lines[a].has_prefix("#")){
                if(addGoToNewLine==1){
                    finalResult+="\n";
                }
                finalResult=finalResult+lines[a];
                if(addGoToNewLine==0)
                    addGoToNewLine=1;
            }
            
        } 
        return finalResult;
    }

    public string execute (string command) {
        int exit_status = -1;
    
        string std_out, std_err;
    
        try {
            Process.spawn_command_line_sync (command, out std_out,
                                                  out std_err,
                                                  out exit_status);
    
            if (exit_status != 0) {
                warning ("Error encountered while executing [" + command + "]:\n"+ std_err);
            }
        }
        catch (SpawnError e) {
            warning ("Error encountered while executing [" + command + "]:\n"+ std_err);
            return "-1";
        }
    
        return std_out;
    }
    
    public static int main(string[] args){
        Cron cron=new Cron();
        print(cron.readCronAsString());
        return 0;
    }
}
