#!/bin/sh

# $1 - action
# $2 - type of file

action=$1
filetype=$2

[ -n "${MC_XDG_OPEN}" ] || MC_XDG_OPEN="xdg-open"

do_view_action() {
    filetype=$1

    case "${filetype}" in
    html)
        cat "${MC_EXT_FILENAME}"
        ;;
    *)
        ;;
    esac
}

do_open_action() {
    filetype=$1

    case "${filetype}" in
    html)
        (if [ -n "x-www-browser" -a  -n "$DISPLAY" ]; then
            (x-www-browser file://"${MC_EXT_CURRENTDIR}"/"${MC_EXT_BASENAME}" &) 1>&2
        else
            elinks "${MC_EXT_FILENAME}" || \
                links "${MC_EXT_FILENAME}" || \
                lynx -force_html "${MC_EXT_FILENAME}" || \
                ${PAGER:-more} "${MC_EXT_FILENAME}"
        fi) 2>/dev/null
        ;;
    *)
        ;;
    esac
}

case "${action}" in
view)
    do_view_action "${filetype}"
    ;;
open)
    ("${MC_XDG_OPEN}" "${MC_EXT_FILENAME}" >/dev/null 2>&1 &) || \
        do_open_action "${filetype}"
    ;;
*)
    ;;
esac
