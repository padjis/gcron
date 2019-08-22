using component;
public class component.button.DisplayButton : Gtk.Button{
    public Gtk.Label expressionLabel { get; construct;}
    public Gtk.Label commandLabel { get; construct;}
    public ListBox listBox { get; construct;}
    public DisplayButton(ListBox listBox,Gtk.Label expressionLabel,Gtk.Label commandLabel){
        Object(
            label:"Display",
            listBox:listBox,
            expressionLabel:expressionLabel,
            commandLabel:commandLabel
        );
        clicked.connect (this.log);
    }

    public void log(){
        if(expressionLabel.get_text ()==null || expressionLabel.get_text ().strip()=="" || commandLabel.get_text ()==null || commandLabel.get_text ().strip()==""){
            listBox.add_error_log("Cron expression or command empty");
        }else{
            listBox.add_info_log(expressionLabel.get_text ()+" "+commandLabel.get_text ());
        }
    }
}
