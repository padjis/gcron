public class grid.Grid : Gtk.Grid{
    public Grid(){
    }
    
    construct{
        var label1 = new Gtk.Label("* * * * *");
        attach(label1,0,0);

        var label2=new Gtk.Label("\t");
        attach_next_to(label2,label1,Gtk.PositionType.RIGHT);
        
        var label3 = new Gtk.Label("/usr/bin/lsrgergergerherherheherherjerjerj");
        attach_next_to(label3,label2,Gtk.PositionType.RIGHT);

        var label4=new Gtk.Label("\t");
        attach_next_to(label4,label3,Gtk.PositionType.RIGHT);

        Gtk.Button button1 = new Gtk.Button.with_label ("Explain");
        attach_next_to(button1,label4,Gtk.PositionType.RIGHT);

        Gtk.Button button2 = new Gtk.Button.with_label ("Delete");
        attach_next_to(button2,button1,Gtk.PositionType.RIGHT);


        var label5 = new Gtk.Label("*/5 1-20/4 * * 2");
        attach(label5,0,50);

        var label6=new Gtk.Label("\t");
        attach_next_to(label6,label5,Gtk.PositionType.RIGHT);
        
        var label7 = new Gtk.Label("/usr/bin/loirejihfoiehrfoiehrfoiehrfsrgergergerherherheherherjerjerj");
        attach_next_to(label7,label6,Gtk.PositionType.RIGHT);

        var label8=new Gtk.Label("\t");
        attach_next_to(label8,label7,Gtk.PositionType.RIGHT);

        Gtk.Button button3 = new Gtk.Button.with_label ("Explain");
        attach_next_to(button3,label8,Gtk.PositionType.RIGHT);

        Gtk.Button button4 = new Gtk.Button.with_label ("Delete");
        attach_next_to(button4,button3,Gtk.PositionType.RIGHT);


        var entry1 = new Gtk.Entry();
        attach(entry1,0,100);

        var label9=new Gtk.Label("\t");
        attach_next_to(label9,entry1,Gtk.PositionType.RIGHT);
        
        var entry2 = new Gtk.Entry();
        attach_next_to(entry2,label9,Gtk.PositionType.RIGHT);

        var label10=new Gtk.Label("\t");
        attach_next_to(label10,entry2,Gtk.PositionType.RIGHT);

        Gtk.Button button5 = new Gtk.Button.with_label ("Explain");
        attach_next_to(button5,label10,Gtk.PositionType.RIGHT);

        Gtk.Button button6 = new Gtk.Button.with_label ("Add");
        attach_next_to(button6,button5,Gtk.PositionType.RIGHT);

    }
}
