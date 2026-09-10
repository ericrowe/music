#!/usr/bin/env python3
"""
Render DOCX to PDF using Microsoft Word (macOS) or LibreOffice (Linux/macOS/Windows).
Usage:
    python3 render_pdf.py <path_to_docx> [output_pdf_path]
"""

import sys
import os
import subprocess
import shutil

def render_docx_to_pdf(docx_path, output_pdf_path=None):
    docx_path = os.path.abspath(docx_path)
    if not os.path.exists(docx_path):
        print(f"Error: Input DOCX does not exist: {docx_path}", file=sys.stderr)
        return False

    if output_pdf_path is None:
        output_pdf_path = os.path.splitext(docx_path)[0] + ".pdf"
    else:
        output_pdf_path = os.path.abspath(output_pdf_path)

    # 1. Try Microsoft Word via AppleScript on macOS
    if sys.platform == "darwin":
        # Clear quarantine attributes that might cause sandbox prompts
        subprocess.run(["xattr", "-d", "com.apple.quarantine", docx_path], capture_output=True)
        
        # Remove preexisting target PDF so Word does not prompt to overwrite
        if os.path.exists(output_pdf_path):
            try:
                os.remove(output_pdf_path)
            except OSError:
                pass

        apple_script = f"""
        tell application "Microsoft Word"
            set wasRunning to running
            set display alerts to alerts none
            with timeout of 120 seconds
                set doc to open file name "{docx_path}"
                save as doc file name "{output_pdf_path}" file format format PDF
                close doc saving no
            end timeout
            if not wasRunning then
                quit
            end if
        end tell
        """
        proc = subprocess.run(["osascript", "-e", apple_script], capture_output=True, text=True)
        if proc.returncode == 0 and os.path.exists(output_pdf_path):
            print(f"Successfully rendered PDF via Microsoft Word: {output_pdf_path}")
            return True
        elif proc.stderr.strip():
            print(f"Notice: Word AppleScript stderr: {proc.stderr.strip()}", file=sys.stderr)

    # 2. Try LibreOffice / soffice CLI
    soffice_cmd = shutil.which("libreoffice") or shutil.which("soffice") or "/Applications/LibreOffice.app/Contents/MacOS/soffice"
    if soffice_cmd and (os.path.exists(soffice_cmd) or shutil.which(soffice_cmd)):
        outdir = os.path.dirname(output_pdf_path)
        proc = subprocess.run([
            soffice_cmd, "--headless", "--convert-to", "pdf", docx_path, "--outdir", outdir
        ], capture_output=True, text=True)
        default_out = os.path.splitext(docx_path)[0] + ".pdf"
        if os.path.exists(default_out) and default_out != output_pdf_path:
            shutil.move(default_out, output_pdf_path)
        if os.path.exists(output_pdf_path):
            print(f"Successfully rendered PDF via LibreOffice: {output_pdf_path}")
            return True

    print(f"Error: Failed to render PDF for {docx_path}. Neither Microsoft Word nor LibreOffice succeeded.", file=sys.stderr)
    return False

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 render_pdf.py <path_to_docx> [output_pdf_path]", file=sys.stderr)
        sys.exit(1)
    docx_file = sys.argv[1]
    out_pdf = sys.argv[2] if len(sys.argv) > 2 else None
    success = render_docx_to_pdf(docx_file, out_pdf)
    sys.exit(0 if success else 1)
