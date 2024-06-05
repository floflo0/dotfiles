set -l commands daemon profile graphics charge-thresholds help

complete --command system76-power --no-files
complete --command system76-power --condition "not __fish_seen_subcommand_from $commands" --arguments daemon            --description 'Runs the program in daemon mode'
complete --command system76-power --condition "not __fish_seen_subcommand_from $commands" --arguments profile           --description 'Query or set the power profile'
complete --command system76-power --condition "not __fish_seen_subcommand_from $commands" --arguments graphics          --description 'Query or set the graphics mode'
complete --command system76-power --condition "not __fish_seen_subcommand_from $commands" --arguments charge-thresholds --description 'Set thresholds for battery charging'
complete --command system76-power --condition "not __fish_seen_subcommand_from $commands" --arguments help              --description 'Print this message or the help of the given subcommand(s)'

complete --command system76-power --condition "not __fish_seen_subcommand_from $commands" --short-option h --long-option help    --description 'Print help'
complete --command system76-power --condition "not __fish_seen_subcommand_from $commands" --short-option V --long-option version --description 'Print version'

complete --command system76-power --condition "__fish_seen_subcommand_from daemon" --short-option q --long-option quiet   --description "Set the verbosity of daemon logs to 'off'"
complete --command system76-power --condition "__fish_seen_subcommand_from daemon" --short-option v --long-option verbose --description "Set the verbosity of daemon logs to 'debug'"
complete --command system76-power --condition "__fish_seen_subcommand_from daemon" --short-option h --long-option help    --description 'Print help'

complete --command system76-power --condition "__fish_seen_subcommand_from profile" --arguments battery
complete --command system76-power --condition "__fish_seen_subcommand_from profile" --arguments balanced
complete --command system76-power --condition "__fish_seen_subcommand_from profile" --arguments performance

complete --command system76-power --condition "__fish_seen_subcommand_from profile" --short-option h --long-option help --description 'Print help'

complete --command system76-power --condition "__fish_seen_subcommand_from graphics" --arguments compute --description 'Like integrated, but the dGPU is available for compute'
complete --command system76-power --condition "__fish_seen_subcommand_from graphics" --arguments hybrid --description 'Set the graphics mode to Hybrid (PRIME)'
complete --command system76-power --condition "__fish_seen_subcommand_from graphics" --arguments integrated --description 'Set the graphics mode to integrated'
complete --command system76-power --condition "__fish_seen_subcommand_from graphics" --arguments nvidia --description 'Set the graphics mode to NVIDIA'
complete --command system76-power --condition "__fish_seen_subcommand_from graphics" --arguments switchable --description 'Determines if the system has switchable graphics'
complete --command system76-power --condition "__fish_seen_subcommand_from graphics" --arguments power --description 'Query or set the discrete graphics power state'
complete --command system76-power --condition "__fish_seen_subcommand_from graphics" --arguments help --description 'Print this message or the help of the given subcommand(s)'

complete --command system76-power --condition "__fish_seen_subcommand_from graphics" --short-option h --long-option help --description 'Print help'

set -l charge_profiles full_charge balanced max_lifespan
complete --command system76-power --condition "__fish_seen_subcommand_from charge-thresholds" --long-option profile               --description 'Profile name [possible values: full_charge, balanced, max_lifespan]' --exclusive --arguments "full_charge balanced max_lifespan"
complete --command system76-power --condition "__fish_seen_subcommand_from charge-thresholds" --long-option list-profiles         --description 'List profiles'
complete --command system76-power --condition "__fish_seen_subcommand_from charge-thresholds" --short-option h --long-option help --description 'Print help'
