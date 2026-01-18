#!/usr/bin/env python3
import os
import sys
import subprocess
import patoolib  # `patool` module required
import tempfile
import shutil

FONT_EXTENSIONS = (".ttf", ".otf")


def install_fonts(font_sources):
    font_dir = os.path.expanduser("~/.local/share/fonts/")
    cache_command = "fc-cache -fv"

    # make sure fonts dir exists (it probably does tho)
    if not os.path.exists(font_dir):
        os.makedirs(font_dir)

    for source in font_sources:
        if source.endswith(FONT_EXTENSIONS):
            install_font(source, font_dir)
        else:
            install_from_archive(source, font_dir)

    # update cache
    try:
        subprocess.run(cache_command, shell=True, check=True)
        print("[fc-install] Cache updated successfully.")
    except subprocess.CalledProcessError as e:
        print(f"[fc-install] Error updating font cache: {e}")
        sys.exit(1)


def install_font(font_file, font_dir):
    try:
        subprocess.run(["cp", font_file, font_dir], check=True)
        print(f"[fc-install] {font_file} installed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"[fc-install] Error installing {font_file}: {e}")
        sys.exit(1)


def install_from_archive(archive_file, font_dir):
    try:
        # create temp dir in /tmp
        temp_dir = tempfile.mkdtemp(prefix="fc-install-")

        # extract fonts from the archive
        extracted_dir = patoolib.extract_archive(
            archive_file, outdir=temp_dir, interactive=False
        )

        # find fonts
        for root, dirs, files in os.walk(extracted_dir):
            for file in files:
                if file.lower().endswith(FONT_EXTENSIONS):
                    font_path = os.path.join(root, file)
                    install_font(font_path, font_dir)

        print(f"[fc-install] Fonts from {archive_file} installed successfully.")
    except Exception as e:
        print(f"[fc-install] Error installing fonts from {archive_file}: {e}")
        sys.exit(1)
    finally:
        # cleanup
        shutil.rmtree(temp_dir)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: fc-install <font_source1> [<font_source2> ...]")
        sys.exit(1)

    font_sources = sys.argv[1:]
    install_fonts(font_sources)
