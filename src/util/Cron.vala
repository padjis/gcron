public class util.Cron : GLib.Object{

    string cronContent="";

    public string writeCronFromUI (Gtk.Entry expressionEntry,Gtk.Entry commandEntry){
        string expression=expressionEntry.text;
        string command=commandEntry.text;
        Descriptor descriptor=new Descriptor(expression,command);
        string result=descriptor.explain();
        if(result.has_prefix("-"))
            return result;
        string newresult=writeCron(expression+" "+command);
        return newresult;
    }

    public string writeCron (string cronLine){
        readCron();
        if(cronContent.length==0){
            cronContent=cronContent+cronLine+"\n";
        }else{
            cronContent=cronContent+"\n"+cronLine+"\n";
        }
        //string result="";
        try {
            FileIOStream iostream;
            string fileName= "cron-XXXXXX.txt";
            File file = File.new_tmp (fileName, out iostream);
            //print ("tmp file name: %s\n", file.get_path ());

            OutputStream ostream = iostream.output_stream;
            DataOutputStream dostream = new DataOutputStream (ostream);
            dostream.put_string (cronContent);
            execute("crontab "+file.get_path ());
            return cronLine+" has succesfully been added";
            //execute("rm "+file.get_path ());
        } catch (Error e) {
            //stderr.printf ("%s\n", e.message);
            return e.message;
        }
        //return result;
    }

    public Array<Array<string>> readCron () {
        Array<Array<string>> finalResult= new Array<Array<string>> ();
        string result= execute("crontab -l");
        if(result==null || result.length==0)
            return finalResult;
            
        string getResult=result;
        cronContent=result;
        string[] lines=getResult.split("\n");
        for (int a = 0; a < lines.length; a++) {
            if(lines[a]!=null && lines[a].length!=0 && !lines[a].has_prefix("#")){
                string expression="";
                string command="";
                string[] datas=lines[a].split(" ");
                //string line=lines[a];
                Array<string> aResult= new Array<string> ();
                if(datas[0]=="@reboot" || datas[0]=="@yearly" || datas[0]=="@annually" || datas[0]=="@monthly" || 
                    datas[0]=="@weekly" || datas[0]=="@daily" || datas[0]=="@midnight" || datas[0]=="@hourly" ){
                        expression=datas[0];
                        for (int b = 1; b < datas.length; b++) {
                            if(b!=1){
                                command=command+" ";
                            }
                            command=command+datas[b];
                        }
                    }else{
                        for (int b = 0; b < 5; b++) {
                            if(b!=0){
                                expression=expression+" ";
                            }
                            expression=expression+datas[b];
                        }
                        for (int b = 5; b < datas.length; b++) {
                            if(b!=5){
                                command=command+" ";
                            }
                            command=command+datas[b];
                        }
                    }
                aResult.append_val (expression);
                aResult.append_val (command);
                finalResult.append_val(aResult);
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
    
    /*public static int main(string[] args){
        Cron cron=new Cron();
        Array<Array<string>> result=cron.readCron();
        for (int i = 0; i < result.length ; i++) {
            Array<string> aResult=result.index(i);
            for (int j = 0; j < aResult.length ; j++) {
                print ("%s", aResult.index (j));
                print ("\t");
            }
            print("\n");
        } 
        print (cron.writeCron("* * * * * ls"));
        return 0;
    }*/
}
