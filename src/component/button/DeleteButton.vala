using component;
using util;
public class component.button.DeleteButton : Gtk.Button{
    public ListBox listBox { get; construct;}
    public int position { get; construct;}
    public Cron cron { get; construct;}
    public DeleteButton(ListBox listBox,int position,Cron cron){
        Object(
            label:"Delete",
            listBox:listBox,
            position:position,
            cron:cron
        );
        clicked.connect (this.delete);
    }

    public void delete(){
        string result = cron.deleteCron(position);
        if(result.has_prefix("-")){
            //error
            if(result.has_prefix("-1 ")){
                result =result.replace("-1 ","");
            }else if(result.has_prefix("-2 ")){
                result =result.replace("-2 ","");
            }
            listBox.add_error_log(result);
        }else{
            listBox.add_info_log(result);
        }
    }
}
