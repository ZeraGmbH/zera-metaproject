#!/usr/bin/python3

import sys
import webbrowser
import re
from pathlib import Path
from ansi2html import Ansi2HTMLConverter

# If ansi2html is missing: run
# fedora-setup/setup-xfce-spin - or
# pip install ansi2html

def convert_log_to_html(input_filename, output_filename):
    try:
        conv = Ansi2HTMLConverter(dark_bg=True, title="ZENUX Log")

        with open(input_filename, 'r', encoding='utf-8', errors='replace') as infile:
            ansi_content = infile.read()

        # Strip OSC 8 terminal hyperlinks ---
        # Matches the start of an OSC 8 link (\x1b]8;), any parameters/URL,
        # and stops at the string terminator (BEL/ \a or ESC \ )
        ansi_content = re.sub(r'\x1b\]8;.*?(?:\a|\x1b\\)', '', ansi_content)

        html_content = conv.convert(ansi_content)

        with open(output_filename, 'w', encoding='utf-8') as outfile:
            outfile.write(html_content)

        print(f"Successfully converted '{input_filename}' to '{output_filename}'")
        return True  # Indicate success

    except FileNotFoundError:
        print(f"Error: Could not find the file '{input_filename}'")
        return False
    except Exception as e:
        print(f"An error occurred: {e}")
        return False

if __name__ == "__main__":
    # 1. Parameter Handling
    if len(sys.argv) >= 3:
        # Both parameters provided
        in_file = sys.argv[1]
        out_file = sys.argv[2]
    elif len(sys.argv) == 2:
        # Only input file provided
        in_file = sys.argv[1]

        # Use pathlib to replace the extension with '.html'
        # If there is no extension (e.g., just "logfile"), it appends '.html'
        # It automatically saves to the same folder as the input file.
        out_file = str(Path(in_file).with_suffix('.html'))
    else:
        # No parameters provided, fall back to defaults
        in_file = "logfile"
        out_file = "logfile.html"

    # Run the conversion
    success = convert_log_to_html(in_file, out_file)
    
    # 2. Open in Default Browser
    if success:
        # Resolve to an absolute path, then convert to a file:// URI.
        # This prevents issues with spaces in filenames or relative paths
        # confusing the web browser on different operating systems.
        file_uri = Path(out_file).resolve().as_uri()

        print(f"Opening in browser: {file_uri}")

        # webbrowser automatically uses xdg-open on Linux,
        # os.startfile on Windows, and open on macOS.
        webbrowser.open(file_uri)
