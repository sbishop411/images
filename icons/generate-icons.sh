#!/bin/bash


# NEED TO FIGURE OUT
    # Can I set the title of the document?
    # Can I set the ID of exported objects?
    # Note: In order to do this, Inkscape will almost certainly need to load the GUI
    # Note: If I use any actions or verbs, I need to include "--batch-process" at the end to tell Inkscape to close the GUI when it's done playing around.

# Values I'll need to auto-generating all icons:
    # file(s) to use as backgrounds for icons? (filepath, maybe we can do this i)
    # create square (bool)
    # create rounded-square (bool)
    # create circle (bool)
    # create outlines (bool)
    # logo scale for square (percent, default to 0.75)
    # logo scale for rounded-square (percent, default to 0.75)
    # logo scale for circle (percent, default to 0.75)

# Intermediate things I may need to track or calculate:
    # ID of logo object/path itself
    # ID of the background object.
    # ID of the tracing object to use with Exclusion (if we still use exclusion)
    # 

# Output path for newly generated SVG icons
# /images/icons/svg/$intermediate_path/$export_filename-$shape.svg





# Useful commang line ARGUMENTS that can be passed to the "inkscape" command:
    # --export-plain-svg       - Need to look into it more, but could be good for simplifying things.
    # --export-area-snap       - Expands exported area outward to nearest whole number, good to ensure that the redulting file is clean.
    # --actions                - Allows for actions (see below) to be called. Example: --actions="select-by-element:ellipse;transform-rotate:30;FileSave;FileClose"

# Useful ACTIONS for manipulating inkscape from the command line:
    # export-filename        :  Export file name.
    # export-type            :  Export file type.
    # export-overwrite       :  Whether or not to overwrite files found in the export location. Should probably be "yes".
    # export-height          :  Export height.
    # export-width           :  Export width.
    # export-area-snap       :  Export snap area to integer values.
    # export-area-page       :  Export page area.
    # export-do              :  Forces Inkscape to do the configured export at this time.
    # file-close             :  Close active document.
    # file-new               :  Open new document using template.
    # file-open              :  Open file.
    # object-set-attribute   :  Set or update an attribute on selected objects. Usage: object-set-attribute:attribute name, attribute value;
    # object-set-property    :  Set or update a property on selected objects. Usage: object-set-property:property name, property value;
    # select-by-id           :  Select by ID
    # transform-scale        :  Scale selected objects by scale factor.
    # verb                   :  Execute verb(s).

# Useful VERBS for manipulating inkscape from the command line:
    # AlignHorizontalLeft                   : Align left edges (Ctrl+Alt+4)
    # AlignVerticalTop                      : Align top edges (Ctrl+Alt+8)
    # AlignBothTopLeftToAnchor              : Align edges of objects to the top-left corner of the anchor
    # AlignBothTopLeft                      : Align edges of objects to the top-left corner of the anchor
    # DialogDocumentProperties              : Edit properties of this document (to be saved with the document) (Shift+Ctrl+D)
    # DialogMetadata                        : Edit document metadata (to be saved with the document)
    # EditCopy                              : Copy selection to clipboard (Ctrl+C)
    # EditPaste                             : Paste objects from clipboard to mouse point, or paste text (Ctrl+V)
    # EditDelete                            : Delete selection (Delete)
    # EditSelectAll                         : Select all objects or all nodes (Ctrl+A)
    # EditDeselect                          : Deselect any selected objects or nodes (Escape)
    # EditSwapFillStroke                    : Swap fill and stroke of an object
    # FileNew                               : Create new document from the default template (Ctrl+N)
    # FileOpen                              : Open an existing document (Ctrl+O)
    # FileSave                              : Save document (Ctrl+S)
    # FileSaveAs                            : Save document under a new name (Shift+Ctrl+S)
    # FileImport                            : Import a bitmap or SVG image into this document (Ctrl+I)
    # FileClose                             : Close this document window (Ctrl+W)
    # SelectionToFront                      : Raise selection to top (Home)
    # SelectionToBack                       : Lower selection to bottom (End)
    # SelectionRaise                        : Raise selection one step (Page Up)
    # SelectionLower                        : Lower selection one step (Page Down)
    # SelectionDiff                         : Create difference of selected paths (bottom minus top) (Ctrl+-)
    # SelectionIntersect                    : Create intersection of selected paths (Ctrl+*)
    # SelectionSymDiff                      : Create exclusive OR of selected paths (those parts that belong to only one path) (Ctrl+^)
    # SelectionCutPath                      : Cut the bottom paths stroke into pieces, removing fill (Ctrl+Alt+/)
    # SelectionGrow                         : Make selected objects bigger (.)
    # SelectionShrink                       : Make selected objects smaller (,)
    # SelectionSimplify                     : Simplify selected paths (remove extra nodes) (Ctrl+L)
    # org.inkscape.color.black_and_white    : Black and White...
    # org.inkscape.color.brighter           : Brighter
    # org.inkscape.color.custom             : Custom...
    # org.inkscape.color.darker             : Darker
    # org.inkscape.color.desaturate         : Desaturate
    # org.inkscape.color.grayscale          : Grayscale
    # org.inkscape.color.hsl_adjust         : HSL Adjust...
    # org.inkscape.color.less_hue           : Less Hue
    # org.inkscape.color.less_light         : Less Light
    # org.inkscape.color.less_saturation    : Less Saturation
    # org.inkscape.color.list_colours       : List All
    # org.inkscape.color.more_hue           : More Hue
    # org.inkscape.color.more_light         : More Light
    # org.inkscape.color.more_saturation    : More Saturation
    # org.inkscape.color.negative           : Negative
    # org.inkscape.color.randomize          : Randomize...
    # org.inkscape.color.remove_blue        : Remove Blue
    # org.inkscape.color.remove_green       : Remove Green
    # org.inkscape.color.remove_red         : Remove Red
    # org.inkscape.color.replace_color      : Replace color...
    # org.inkscape.color.rgb_barrel         : RGB Barrel



