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

using Gcron.Widgets;
public class Gcron.Widgets.Buttons.DisplayButton : Gtk.Button{
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