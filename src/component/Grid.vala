using component.button;
using util;
public class component.Grid : Gtk.Grid{

    public int position { get; set;}
    public int space { get; set;}
    public ListBox listBox { get; construct;}
    public uint numberOfLines { get; set;}
    public Cron cron { get; set;}

    public Grid(ListBox listBox,uint numberOfLines, Cron cron){
        Object(
            position:0,
            space:50,
            listBox:listBox,
            numberOfLines:numberOfLines,
            cron:cron
        );
        if(numberOfLines==0){
            listBox.add_info_log("No cron setup found, create a new cron");
        }
        add_space();
        add_explanation_line();
        add_space();
    }

    public void add_explanation_line(){
        var expressionLabel = new Gtk.Label("-CRON EXPRESSION-");
        attach(expressionLabel,0,position*space);

        var label2=new Gtk.Label("\t");
        attach_next_to(label2,expressionLabel,Gtk.PositionType.RIGHT);
        
        var commandLabel = new Gtk.Label("-CRON COMMAND-");
        attach_next_to(commandLabel,label2,Gtk.PositionType.RIGHT);

        position++;
    }


    public void add_space(){
        var label = new Gtk.Label("");
        attach(label,0,position*space);
        position++;
    }

    public void add_full_line(string expression,string command){
        var expressionLabel = new Gtk.Label(expression);
        attach(expressionLabel,0,position*space);

        var label2=new Gtk.Label("\t");
        attach_next_to(label2,expressionLabel,Gtk.PositionType.RIGHT);
        
        var commandLabel = new Gtk.Label(command);
        attach_next_to(commandLabel,label2,Gtk.PositionType.RIGHT);

        var label4=new Gtk.Label("\t");
        attach_next_to(label4,commandLabel,Gtk.PositionType.RIGHT);

        FullExplainButton fullExplainButton = new FullExplainButton (listBox,expressionLabel.get_text(),commandLabel.get_text());
        attach_next_to(fullExplainButton,label4,Gtk.PositionType.RIGHT);

        DisplayButton displayButton = new DisplayButton (listBox,expressionLabel,commandLabel);
        attach_next_to(displayButton,fullExplainButton,Gtk.PositionType.RIGHT);

        Gtk.Button button3 = new Gtk.Button.with_label ("Delete");
        attach_next_to(button3,displayButton,Gtk.PositionType.RIGHT);

        position++;
    }

    public void add_empty_line(){
        var entry1 = new Gtk.Entry();
        attach(entry1,0,position*space);

        var label2=new Gtk.Label("\t");
        attach_next_to(label2,entry1,Gtk.PositionType.RIGHT);
        
        var entry2 = new Gtk.Entry();
        attach_next_to(entry2,label2,Gtk.PositionType.RIGHT);

        var label4=new Gtk.Label("\t");
        attach_next_to(label4,entry2,Gtk.PositionType.RIGHT);

        EmptyLineButton button1 = new EmptyLineButton(listBox,entry1,entry2,cron);
        attach_next_to(button1,label4,Gtk.PositionType.RIGHT,3);

        position++;
        add_space();
    }
}
