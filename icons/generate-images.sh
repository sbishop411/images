#!/bin/bash

# Global Variables
_log=true
_log_verbose=false
_valid_export_types=('svg' 'png' 'ps' 'eps' 'pdf' 'emf' 'wmf' 'xaml')

# Functions
log() {
    if $_log ; then echo -e $1 ; fi
}

log_no_newline() {
    if $_log ; then echo -e -n $1 ; fi
}

log_if_verbose() {
    if $_log && $_log_verbose ; then echo -e $1 ; fi
}

log_error() {
    if $_log ; then echo -e "ERROR: $1" ; fi
    exit 
}

print_help() {
    echo "
Usage:
    generate-images.sh [options]

Help Options:
    -h, --help              Displays the help options.

File Import:
    -f, --source_path       Path where the script should recursively search for 
                            .svg files. Defaults to script's current working directory.

File Export:
    -o, --output_path       Path where the script should output generated files.

Export Options:
    -t, --export-types      Filetypes that Inkscape should export to. Valid
                            types are: svg, png, ps, eps, pdf, emf, wmf, xaml.
                            Defaults to 'png'.

    -s, --export-sizes      Square sizes that icons should be rendered at.
                            Defaults to '16 32 48 64 128 192 256'.

Logging:
    -v, --verbose           Tells the script to perform verbose logging.
    -q, --quiet             Tells the script to silence all logging output.
    
Notes:
    - The --export_types and --export_sizes options can be used multiple times
      to generate icons in multiple types and sizes.

    - If no --export_types are provided, the script defaults to exporting to
      only png.

    - If no --export_sizes are provided, the script defaults to generating the
      following sizes: 16, 32, 48, 64, 128, 192, 256.

Examples:
    Export the 'git-plain.svg' file in the 'src' directory as a 16x16 PNG.
        generate-images.sh -t png -s 16 src/tech/git/git-plain.svg .
    
    Export all tech icons in both PNG and PDF formats, and in several sizes.
        generate-images.sh -t png -t pdf -s 16 -s 32 -s 64 -s 128 src/tech/ .

    Default run for all icons (png, default sizes)
        generate-images.sh src ."
    exit
}

# Get options
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do
    case $1 in
        -h | --help )
            print_help
            ;;
        -v | --verbose )
            _log_verbose=true
            ;;
        -q | --quiet )
            _log=false
            ;;
        -f | --source_path )
            shift; source_path=$1
            ;;
        -o | --output_path )
            shift; output_path=$1
            ;;
        -t | --export-types )
            shift;
            if [[ " ${_valid_export_types[@]} " =~ " $1 " ]]; then
                if [[ ! " ${export_types[@]} " =~ " $1 " ]]; then
                    export_types+=($1)
                fi
            else
                log_error "The type '$1' is not a file type that Inkscape can export to. Valid types are: svg, png, ps, eps, pdf, emf, wmf, xaml"
            fi
            ;;
        -s | --export-sizes )
            shift
            if [[ ! " ${export_sizes[@]} " =~ " $1 " ]]; then
                export_sizes+=($1)
            fi
            ;;
    esac;
    shift;
done
if [[ "$1" == '--' ]]; then shift; fi

# Set default values if they weren't set by the caller
if [[ -z "$source_path" ]]; then source_path="src/" ; fi
if [[ -z "$output_path" ]]; then output_path="./" ; fi
if [[ ${#export_types[@]} == 0 ]]; then export_types=('png') ; fi
if [[ ${#export_sizes[@]} == 0 ]]; then export_sizes=('16' '32' '48' '64' '128' '192' '256') ; fi

log_no_newline "Finding sources..."

if [[ ! -r $source_path ]]; then # Check to see if source path is valid (exists, is readable)
    log_error "Unable to read from the provided source directory or file: $source_path."
elif [[ ! -d $source_path ]]; then # The source is a file
    if [[ ${source_path##*.} == "svg" ]]; then
        sources+=($source_path)
    else
        log_error "The specified source file must be a .svg file. Source file: $source_path"
    fi
elif [[ -d $source_path ]]; then # The source is a directory
    # This finds all svg files recursively and stores them in the 'sources' array
    readarray -d '' sources < <(find $source_path -name *.svg -print0)
else
    log_error "Could not find the source directory or file."
fi

log "\t\t\t\tdone. Found ${#sources[@]} files to convert."

# Check to see if export output path is valid (exists, is writable)
if [[ ! -w $output_path ]]; then
    log_error "Unable to write to the provided output path: '$output_path'."
elif [[ ! -d $output_path ]]; then
    log_error "The output path must be a directory, not a file."
fi

log_no_newline "Beginning Inkscape command generation..."
command_file=$(mktemp)

# For every source that we found, build out the instruction set to export it into the desired formats.
for source in "${sources[@]}"; do
    source_filename=$(basename $source .svg)
    source_directory=$(dirname $source)
    intermediate_path=${source_directory#"$source_path"}
    log_if_verbose "Processing source: $(dirname $source)"
    echo "file-open:$source">> "$command_file"

    for export_type in "${export_types[@]}"; do
        output_filepath="$output_path/$export_type/$(dirname ${source#$source_path})/$source_filename"
        
        if [[ $export_type == "svg" ]]; then
            log_if_verbose "\tCreating command for: $source_filename.$export_type"
            echo "export-filename:$output_filepath/$source_filename.$export_type; export-type:$export_type; export-area-snap; export-plain-svg; export-do;">> "$command_file"
        else
            for size in "${export_sizes[@]}"; do
                if [[ ! -d $output_filepath ]]; then
                    log_if_verbose "\tCreating directory: $output_filepath"
                    mkdir -p "$output_filepath"
                fi
                log_if_verbose "\tCreating command for: $source_filename-${size}x$size.$export_type"
                echo "export-filename:$output_filepath/$source_filename-${size}x$size.$export_type; export-type:$export_type; export-width:$size; export-height:$size; export-area-snap; export-do;">> "$command_file"
            done
        fi
    done

    echo "file-close:$source">> "$command_file"
done

log "\tdone. Command file contains $(wc -l < "$command_file") commands."

# Invoke inkscape with the instruction file we created.
log_no_newline "Generating images with Inkscape..."
inkscape --shell < "$command_file"
log "\t\tdone."

log_no_newline "Removing command file..."
rm "$command_file"
log "\t\t\tdone."
log "\nImage generation completed successfully. Enjoy your icons!"
