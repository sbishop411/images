rem --- This script finds all .svg files in the "svg" directory and converts them to .png files in multiple sizes in the "png" directory using Inkscape.

@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

del commands.txt

rem for %%f in (filename.svg) do (
for %%f in (%cd%\svg\*.svg) do (
    set filename=%%~nf
    mkdir .\png\!filename!
    echo file-open:svg/!filename!.svg;>> commands.txt
    echo export-filename:%cd%\png\!filename!\!filename!-16x16.png; export-type:png; export-width:16; export-height:16; export-do>> commands.txt
    echo export-filename:%cd%\png\!filename!\!filename!-32x32.png; export-type:png; export-width:32; export-height:32; export-do>> commands.txt
    echo export-filename:%cd%\png\!filename!\!filename!-48x48.png; export-type:png; export-width:48; export-height:48; export-do>> commands.txt
    echo export-filename:%cd%\png\!filename!\!filename!-64x64.png; export-type:png; export-width:64; export-height:64; export-do>> commands.txt
    echo export-filename:%cd%\png\!filename!\!filename!-128x128.png; export-type:png; export-width:128; export-height:128; export-do>> commands.txt
    echo export-filename:%cd%\png\!filename!\!filename!-192x192.png; export-type:png; export-width:192; export-height:192; export-do>> commands.txt
    echo export-filename:%cd%\png\!filename!\!filename!-256x256.png; export-type:png; export-width:256; export-height:256; export-do>> commands.txt
    echo export-filename:%cd%\png\!filename!\!filename!-512x512.png; export-type:png; export-width:512; export-height:512; export-do>> commands.txt
)

echo quit >> commands.txt
inkscape --shell < commands.txt
del commands.txt
