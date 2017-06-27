#!/usr/bin/env bash
# name: pipeLiner.sh
# author: Nick Guyer
# email: guyern@gmail.com

set -o errexit
set -o nounset
set -o pipefail

# Global Variables
DIR="$(cd "$(dirname "${0}")"; echo $(pwd))"
BASE="$(basename "${0}")"
FILE="${DIR}/${BASE}"
HASH=$(git rev-parse HEAD)

function RunTest {
    echo "################################"
    echo "Build Information"
    echo "Directory: ${DIR}"
    echo "Filename: ${FILE}"
    echo "Commit: ${HASH}"
    echo "Version Information:"
    echo "Ansible Version: $(ansible --version)"
    echo "Ansible Playbook Version: $(ansible-playbook --version)"
    echo "Operating System: $(cat /etc/redhat-release)"
    echo "Kernel: $(uname -a)"
    echo "################################"
}

function Usage {
    echo "NAME:"
    echo -e "\t pipeLiner.sh - Script to setup jenkins pipelines"
    echo ""
    echo "USAGE:"
    echo -e "\t [environment options] ./pipeLiner.sh command"
    echo ""
    echo "VERSION:"
    echo -e "\t 0.1.0"
    echo ""
    echo "COMMANDS:"
    echo -e "\t -c      Check Run - Runs ansible-playbook with --check"
    echo -e "\t -r      Gather Report Information - Runs a report"
    echo -e "\t -s      Syntax - Runs a syntax check on an ansible playbook"
}

function Syntax {
    find ./roles -name '*.yml' -maxdepth 3 | xargs -n1 yamllint -d relaxed -f parsable
}

function CheckRun {
    ansible-playbook -i inventory test.yml --check --diff
}

# if no arguments are passed
if [ $# == 0 ];then
    Usage
    exit 1
fi

case "$1" in
# runs report
-r)     RunTest
        ;;
# runs yamllint
-s)     Syntax
        ;;
# runs ansible-playbook with --check
-c)     CheckRun
        ;;
# anything else go to Usage function
*)      Usage
        ;;
esac
