#/bin/sh

if [ $# -lt 2 ]; then
        echo "== Generate manpage for create-changelog =="
        echo "Usage: $(basename $0) INFILE OUTFILE."
        echo "Where INFILE is the readme file in markdown format"
        echo "and OUTFILE is the target output file."
        exit 1
fi

TEMPFILE="${2}.tmp"

tee > "$TEMPFILE" <<'EOF'
%CCL(1)

# NAME

ccl - _C_reate end-user-friendly _c_hange _l_ogs from Git commit messages.

# SYNOPSIS

**ccl** ["Heading for most recent changes without Git tag"] [**-d** WORKING_DIRECTORY]  
**ccl** **-r**|**--only-recent**  
**ccl** **-n**|**--no-recent**  
**ccl** **-h**|**--help**  
**ccl** **-v**|**--version**  

# DESCRIPTION
EOF

sed -r '0,/^## DESCRIPTION/Id' "$1" >> "$TEMPFILE"
sed -r -i 's/^## (.+)$/# \U\1/' "$TEMPFILE"
pandoc --standalone -f markdown -t man "$TEMPFILE" -o "$2"
rm "$TEMPFILE"
