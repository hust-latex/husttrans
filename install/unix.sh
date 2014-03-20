#!/usr/bin/env bash
# LaTeX package install script
# Author: Xu Cheng

command_exists () {
    type "$1" &> /dev/null ;
}

if ! command_exists realpath ; then
    if command_exists grealpath ; then
        realpath() {
            grealpath "$1"
        }
    else
        realpath() {
            [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
        }
    fi
fi

SCRIPT_PATH=$(realpath $(cd $(dirname $0);pwd))
cd $SCRIPT_PATH/..

TEXMFLOCAL=`kpsewhich --var-value=TEXMFLOCAL | awk -v RS="" -v FS="[\r\n]" '{print $1}' `

install(){
echo "Install husttrans.cls template into local."
mkdir -p "${TEXMFLOCAL}/tex/latex/husttrans/"
cp -f ./husttrans/husttrans.cls "${TEXMFLOCAL}/tex/latex/husttrans/"
mkdir -p "${TEXMFLOCAL}/doc/latex/husttrans/"
cp -f ./husttrans/husttrans.pdf "${TEXMFLOCAL}/doc/latex/husttrans/"
mkdir -p "${TEXMFLOCAL}/doc/latex/husttrans/example/"
cp -f ./husttrans/husttrans-example.pdf "${TEXMFLOCAL}/doc/latex/husttrans/example/"
cp -f ./husttrans/husttrans-example.tex "${TEXMFLOCAL}/doc/latex/husttrans/example/"
cp -f ./husttrans/fig-example.pdf "${TEXMFLOCAL}/doc/latex/husttrans/example/"
cp -f ./husttrans/ref-example.bib "${TEXMFLOCAL}/doc/latex/husttrans/example/"
hash
}

uninstall(){
echo "Uninstall husttrans.cls template."
rm -rf "${TEXMFLOCAL}/tex/latex/husttrans/"
rm -rf "${TEXMFLOCAL}/doc/latex/husttrans/"
hash
}

hash(){
echo "Refresh TeX hash database."
texhash
}

help(){
echo "Usage:"
echo " $(basename $0) install          - install husttrans.cls template into local."
echo " $(basename $0) uninstall        - uninstall husttrans.cls template."
echo ""
}

if [[ $1 = "install" ]]; then
    install
elif [[ $1 = "uninstall" ]]; then
    uninstall
else
    help
fi
