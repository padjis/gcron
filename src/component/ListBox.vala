/*
 *  Copyright (C) 2019 Emmanuel Padjinou
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *  Authored by: Emmanuel Padjinou <emmanuel@padjinou.com>
 *
 */

public class component.ListBox : Gtk.ListBox{

    public window.Window window { get; set;}

    public ListBox(window.Window window){
        Object(
            window:window
        );
    }

    private string getDate(){
        var now = new DateTime.now_local ();
        return now.to_string();
    }

    public void reset(){
        this.foreach ((element) => this.remove (element));
        add_info_log("The system will display messages here");
        window.resize(1,1);
        window.show_all();
    }

    public void add_info_log(string text){
        Gtk.Box box=new Gtk.Box(Gtk.Orientation.HORIZONTAL,0);
        var entry = new ReadOnlyEntry(getDate()+" - [Info] "+text);
        box.pack_start (entry, true, true, 0);
        prepend(box);
        window.show_all();
    }

    public void add_error_log(string text){
        Gtk.Box box=new Gtk.Box(Gtk.Orientation.HORIZONTAL,0);
        var entry = new ReadOnlyEntry(getDate()+" - [Error] "+text);
        entry.get_style_context ().add_class ("error-message");
        box.pack_start (entry, true, true, 0);
        prepend(box);
        window.show_all();
    }
}
