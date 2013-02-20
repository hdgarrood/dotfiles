#!/bin/bash
# emulate the 'tree' program for listing all files and directories below the
# current one.

olddir=$PWD;
color="off";
stackheight=0;
for option in "$@"
do
    case $option in
        --color ) color="on"; shift;;
        -*      ) shift;;
        *       )      ;;
    esac
done

function listfiles() {
    cd "$1";
    for file in *
    do
        for ((i=-1; $i < $stackheight; i++))
        do
            printf '  '
        done

        # indentation shows the depth of the file
        if [ -d "$file" ]
        then
            if [ $color == "on" ]
            then
                printf "\e[34m";
                # display directory names in blue
            fi
        fi

        # print the filename
        printf "$file"
        if [ $color == "on" ]; then printf "\e[0m"; fi
        printf "\n"

        # recurse if we're in a directory
        if [ -d "$file" ]
        then
            stackheight=$stackheight+1;
            # more indentation
            listfiles "$file";
            # recursive listing of files
            cd ..;
        fi
    done
    let stackheight=$stackheight-1;
    # less indentation
}

echo `pwd`:
listfiles "$1";
cd $olddir;
unset i color stackheight;
