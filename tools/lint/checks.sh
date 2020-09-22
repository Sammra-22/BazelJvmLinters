#!/bin/bash

function log() {
  echo "$@" >&2
}

function process_lint_results() {
  failing_targets=()
  for lint_target in "$@"; do
    target_package=${lint_target/:*/}
    target_name=${lint_target/*:/}
    output="$PWD/bazel-bin/${target_package/\/\//}/${target_name}.OUTPUT"
    if [ -s "$output" ]; then
      if [[ $target_name == *formatter ]]; then
        failing_targets+=("$lint_target.FIX")
        log "[ERROR] Detected linting errors. Run \"bazel run $lint_target.FIX\""
      else
        log "[WARN] Detected linting issues. Run \"bazel build $lint_target\""
      fi
    fi
  done
  [ -n "${failing_targets[*]}" ] && log ">> Linting failed!" && exit 1
  log ">> All checks successful!"
}

lint_targets=$(bazel query --noshow_progress "kind('code_style_lint_check', //src/...)")
[ -z "$lint_targets" ] && log "No checks found" && exit 0
bazel build $lint_targets
process_lint_results $lint_targets
