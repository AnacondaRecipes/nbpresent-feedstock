# tests currently don't build properly inside Docker inside CircleCI
if [[ $(uname) == Linux ]]; then
  exit 0
fi

"${PREFIX}/bin/npm" install .
"${PREFIX}/bin/npm" run test
