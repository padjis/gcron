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
using Gcron.Util;

public class Gcron.Widgets.Buttons.EmptyLineButton : Gtk.Button {
    public Gtk.Entry expressionEntry { get; construct;}
    public Gtk.Entry commandEntry { get; construct;}
    public ListBox listBox { get; construct;}
    public Cron cron { get; construct;}

    public EmptyLineButton (ListBox listBox, Gtk.Entry expressionEntry, Gtk.Entry commandEntry, Cron cron) {
        Object (
            label: _("Add new cron job"),
            listBox: listBox,
            expressionEntry: expressionEntry,
            commandEntry: commandEntry,
            cron: cron
        );
        clicked.connect (this.log);
        this.get_style_context ().add_class ("gray-button");
    }

    public void log () {
        string result = cron.writeCronFromUI (expressionEntry, commandEntry);
        if (result.contains ("<>")) {
            if (result.contains ("<>1 ")) {
                result=result.replace ("<>1 ", "");
            } else if (result.contains ("<>2 ")) {
                result=result.replace ("<>2 ", "");
            }
            listBox.add_error_log (result);
        } else {
            listBox.window.reset ();
        }
    }
}
