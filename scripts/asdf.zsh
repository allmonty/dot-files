# Update a tool in every .tool-versions under the current folder that already lists it
# usage: asdf_set_all flutter 3.47.9-stable
asdf_set_all() {
  [[ -n "$1" && -n "$2" ]] || { echo "usage: asdf_set_all <tool> <version>"; return 1 }
  local file
  find . \( -name node_modules -o -name .git \) -prune -o -name .tool-versions -print |
  while read -r file; do
    grep -qE "^$1[[:space:]]" "$file" || continue
    echo "📌 $1 $2: $file"
    (cd "${file:h}" && asdf set "$1" "$2")
  done
}
