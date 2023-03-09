#!/usr/bin/env bash

set -eu -o functrace -o pipefail

echoerr() { echo "$@" >&2; }
die() { echoerr "$*"; exit 2; }  # complain to STDERR and exit with error
needs_arg() { if [ -z "$OPTARG" ]; then die "No arg for --$OPT option"; fi; }


usage="$(basename "$0") [options] mapping-file -- Unified RML wrapper launcher

where options are:
    -u --unique          Use the tool's native distinct feature (fails if unsupported)
    -s --sort            Use the tool's native sorting feature (fails if unsupported)
    -l --large           Use the tool's native large file feature
    -m --memory          Configure the tool for the given amount of memory in GIGABYTES.
       --out-file=path   Write output to the specified file. IMPORTANT: the '=' is mandatory.
       --out-format=fmt  (not yet supported; defaults to nquads)
    -k --keep            Keep temporary resources, such as generated config files, rather than removing them when done
    -x                   Enable bash debugging (set -x)
"

if [ $# -eq 0 ]; then
  echo "$usage"
  die "No arguments provided"
fi


OPT_UNIQUE=false
OPT_SORT=false
OPT_LARGE=false
OPT_MEMORY=
OPT_OUT_FILE=
OPT_KEEP=

# Based on https://stackoverflow.com/questions/402377/using-getopts-to-process-long-and-short-command-line-options
while getopts uslm:kx-: OPT; do
  if [ "$OPT" = "-" ]; then   # long option: reformulate OPT and OPTARG
    OPT="${OPTARG%%=*}"       # extract long option name
    OPTARG="${OPTARG#$OPT}"   # extract long o$ption argument (may be empty)
    OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
  fi
  case "$OPT" in
    u | unique )    OPT_UNIQUE=true ;;
    s | sort )      OPT_SORT=true ;;
    l | large )     OPT_LARGE=true ;;
    m | memory )    needs_arg; OPT_MEMORY="$OPTARG" ;;
        out-file )  needs_arg; OPT_OUT_FILE="$OPTARG" ;;
    k | keep )      OPT_KEEP=true ;;
    x )             set -x ;;
    ??* )           die "Illegal option --$OPT" ;;  # bad long option
    ? )             exit 2 ;;  # bad short option (error reported via getopts)
  esac
done
shift $((OPTIND-1)) # remove parsed options and args from $@ list

OPT_MAPPING_FILES=("$@")
echoerr "Config: unique=$OPT_UNIQUE, sort=$OPT_SORT, large=$OPT_LARGE, memory=$OPT_MEMORY, out-file=$OPT_OUT_FILE, keep=$OPT_KEEP, remaining args(${#OPT_MAPPING_FILES[@]})=$OPT_MAPPING_FILES"

