using component;
using util;
public class component.button.EmptyLineButton : Gtk.Button{
    public Gtk.Entry expressionEntry { get; construct;}
    public Gtk.Entry commandEntry { get; construct;}
    public ListBox listBox { get; construct;}
    public Cron cron { get; construct;}
    public EmptyLineButton(ListBox listBox,Gtk.Entry expressionEntry,Gtk.Entry commandEntry,Cron cron){
        Object(
            label:"Add new cron line",
            listBox:listBox,
            expressionEntry:expressionEntry,
            commandEntry:commandEntry,
            cron:cron
        );
        clicked.connect (this.log);
    }

    public void log(){
        string result=cron.writeCronFromUI(expressionEntry,commandEntry);
        if(result.has_suffix("-")){
            if(result.has_suffix("-1 ")){
                result=result.replace("-1 ","");
            }else if(result.has_suffix("-2 ")){
                result=result.replace("-2 ","");
            }
            listBox.add_error_log(result);
        }else{
            expressionEntry.text="";
            commandEntry.text="";
            listBox.add_info_log(result);
        }
    }
}
