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

public class Gcron.Widgets.Buttons.FullExplainButton : Gtk.Button {
    public ListBox listBox { get; construct;}
    public Descriptor descriptor { get; construct;}
    public FullExplainButton (ListBox listBox, string expression, string command) {
        Object (
            label: _("Explain"),
            listBox: listBox,
            descriptor: new Descriptor (expression, command)
        );

        clicked.connect (this.log);
    }

    public void log () {
        string result = descriptor.explain ();
        if (result.contains ("<>")) {
            //error
            if (result.contains ("<>1 ")) {
                result = result.replace ("<>1 ", "");
            } else if (result.contains ("<>2 ")) {
                result = result.replace ("<>2 ", "");
            }
            listBox.add_error_log (result);
        } else {
            listBox.add_info_log (result);
        }
    }
}
