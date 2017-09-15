# tests currently don't build properly inside Docker inside CircleCI
if [[ $(uname) == Linux ]]; then
  exit 0
fi

# tests currently don't run on macOS 10.9 when SSHing in:
# ETest file: /Volumes/100GB/conda/conda-bld/nbpresent_1505431353417/test_tmp/nbpresent/tests/js/test_notebook_basic.js
# Timeout for http://localhost:8888/a@b/
# Is the notebook server running?
if [[ $(uname) == Darwin ]]; then
  exit 0
fi

"${PREFIX}/bin/npm" install .
"${PREFIX}/bin/npm" run test
