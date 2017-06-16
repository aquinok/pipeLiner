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

RunTest
