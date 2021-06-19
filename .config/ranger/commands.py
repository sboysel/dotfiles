# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)

# You can import any python module as needed.
import path
import datetime
import os

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command
from ranger.core.loader import CommandLoader


class todo(Command):
    """:todo
    Creates a new TODO note in ~/todo and opens the file in $EDITOR.  File is
    named `YYYY-MM-DD.md` where `YYYY-MM-DD` defaults to the current date.
    """

    # The execute method is called when you run this command in ranger.
    def execute(self):

        todo_path = path.Path('~/repos/todo').expanduser()
        note_today = path.Path(str(datetime.date.today()) + '.md')
        target_filename = str(todo_path / note_today)

        self.fm.edit_file(target_filename)


class extract_here(Command):
    def execute(self):
        """ extract selected files to current directory."""
        cwd = self.fm.thisdir
        marked_files = tuple(cwd.get_selection())

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        one_file = marked_files[0]
        cwd = self.fm.thisdir
        original_path = cwd.path
        au_flags = ['-x', cwd.path]
        au_flags += self.line.split()[1:]
        au_flags += ['-e']

        self.fm.copy_buffer.clear()
        self.fm.cut_buffer = False
        if len(marked_files) == 1:
            descr = "extracting: " + os.path.basename(one_file.path)
        else:
            descr = "extracting files from: " + os.path.basename(
                one_file.dirname)
        obj = CommandLoader(args=['aunpack'] + au_flags
                            + [f.path for f in marked_files], descr=descr,
                            read=True)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)
