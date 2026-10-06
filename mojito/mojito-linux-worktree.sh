#!/bin/sh
# Run mojito's reactor on Linux against the CURRENT WORKING TREE, not just committed state.
#
# mojito-linux.sh clones /repo, so it only ever tests what is committed. During the AI repair
# phase the fixes are deliberately left uncommitted for review, and a clone-based run keeps
# failing on the baseline commit's compile error no matter what was repaired. This variant
# applies the uncommitted changes on top of the clone, exported as /sp/wip.patch beforehand
# (exporting on the Windows side keeps Git for Windows' autocrlf normalization, so the patch
# is clean LF and applies onto the container's LF checkout).
#
# Invoke from Git Bash on Windows -- export the patch first, then run:
#
#   cd /d/scripts/box__mojito && git diff --binary > /c/Users/Giannis/Desktop/Thesis/dataset/baseline-setup/wip.patch
#
#   MSYS_NO_PATHCONV=1 docker run --rm \
#     -v "D:/scripts/box__mojito:/repo:ro" \
#     -v "C:/Users/Giannis/.m2/repository:/m2" \
#     -v "C:/Users/Giannis/Desktop/Thesis/dataset/baseline-setup:/sp" \
#     maven:3.9-eclipse-temurin-21 sh /sp/mojito-linux-worktree.sh [maven goal, default: test]
#
# Note: `git diff` does not carry UNTRACKED files. If new files were created, run
# `git add -N .` in /d/scripts/box__mojito before exporting the patch.
#
# Prerequisite: `git fetch --unshallow` must have been run in /repo (see mojito-linux.sh).
set -e

GOAL="${1:-test}"

git config --global --add safe.directory /repo
git clone /repo /build
cd /build

if [ -s /sp/wip.patch ]; then
    git apply --verbose /sp/wip.patch
fi

# Empty 'expected' directory that git cannot track -- see mojito-linux.sh.
mkdir -p cli/src/test/resources/com/box/l10n/mojito/cli/command/PullCommandTest_IO/pullAndroidStringsSkipEmpty/expected

mvn -B "$GOAL" -P '!frontend' -Dmaven.repo.local=/m2
