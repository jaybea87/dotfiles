#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Enhanced logging functions
log() {
    echo "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')] $*${NC}"
}

log_info() {
    echo "${BLUE}[$(date '+%Y-%m-%d %H:%M:%S')] $*${NC}"
}

log_warning() {
    echo "${YELLOW}[$(date '+%Y-%m-%d %H:%M:%S')] WARNING: $*${NC}"
}

log_error() {
    echo "${RED}[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*${NC}" >&2
}

confirm() {
    local message="$1"
    echo "${PURPLE}${message}${NC}"
    echo "${BLUE}Proceed? (y/n)${NC}"
    read -r resp
    [[ "$resp" =~ ^[Yy]$ ]]
}

is_macos() {
    [[ "$OSTYPE" == darwin* ]]
}
