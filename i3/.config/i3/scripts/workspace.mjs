#!/usr/bin/node

import { spawnSync } from 'node:child_process'

const MAX_WORKSPACE = 10

const main = () => {
    if (process.argv.length < 3 || process.argv.length > 4) {
        console.error(`Usage: ${process.argv[1]} next|prev [--move-window]`)
        process.exit(1)
    }

    const workspaces = spawnSync('i3-msg', ['-t', 'get_workspaces'])

    const focused_workspace = JSON.parse(
        workspaces.stdout.toString()
    ).find(workspace => workspace.focused).num

    let new_workspace
    if (process.argv[2] === 'next') {
        new_workspace = Math.min(focused_workspace + 1, MAX_WORKSPACE)
    } else if (process.argv[2] === 'prev') {
        new_workspace = Math.max(focused_workspace - 1, 1)
    } else {
        console.error(`unknown argument ${process.argv[2]} expected next|prev`)
        process.exit(1)
    }

    if (process.argv.length == 4) {
        if (process.argv[3] == '--move-window') {
            spawnSync('i3-msg', ['move', 'container', 'to', 'workspace', new_workspace])
        } else {
            console.error(`unknown argument ${process.argv[3]} expected --move-window`)
        }
    }

    spawnSync('i3-msg', ['workspace', new_workspace])
}

main()
