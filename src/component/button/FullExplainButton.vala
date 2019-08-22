using component;
using util;
public class component.button.FullExplainButton : Gtk.Button{
    public ListBox listBox { get; construct;}
    public Descriptor descriptor { get; construct;}
    public FullExplainButton(ListBox listBox,string expression,string command){
        Object(
            label:"Explain",
            listBox:listBox,
            descriptor:new Descriptor(expression,command)
        );
        clicked.connect (this.log);
    }

    public void log(){
        string result = descriptor.explain();
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
