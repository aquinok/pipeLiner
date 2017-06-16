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

function RunTest {
    echo "################################"
    echo "Build Information"
    echo "Directory: ${DIR}"
    echo "Filename: ${FILE}"
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
    echo -e "\t -r      Gather Report Information - Runs a report"
    echo -e "\t -s      Syntax - Runs a syntax check on an ansible playbooks"
}

function Syntax {
    find ./roles -name '*.yml' -maxdepth 3 | xargs -n1 yamllint -d relaxed -f parsable
}

# if no arguments are passed
if [ $# == 0 ];then
    Usage
    exit 1
fi

case "$1" in
# sets up ansible library
-r)     RunTest
        ;;
# sets up environment
-s)     Syntax
        ;;
# anything else go to Usage function
*)      Usage
        ;;
esac
