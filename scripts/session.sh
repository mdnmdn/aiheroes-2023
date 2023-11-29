#!/bin/bash
set -eo pipefail

base_path="$(dirname "$0")/.."
. $base_path/scripts/_commons.sh


main() {
  local command=$1
  if [ -z "$command" ]; then
    command="show"
  fi

  case $command in
    s|show)
      get_current_session
      ;;
    n|new)
      set_session
      ;;
    c|clear)
      clear_current_session
      ;;
    p|print)
      local session_id="(get_current_session)"
      echo "Session: $session_id"
      print_current_session
      ;;
    *)
      echo "Unknown command: $command"
      exit 1
      ;;
  esac
}

main "$@"

