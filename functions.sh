#!/bin/bash
pg_x10_turn () {
    # $1: action [on|off]
    # $2: received order
    local -r order="$(jv_sanitize "$2")"
    while read device; do
        local sdevice="$(jv_sanitize "$device" ".*")"
        if [[ "$order" =~ .*$sdevice.* ]]; then
            local address="$(echo $pg_x10_config | jq -r ".devices[] | select(.name==\"$device\") | .address")"
            say "$(pg_x10_lg "switching_$1" "$2")..."
            local cmd="echo \"pl $address $1\" | nc localhost $pg_x10_mochad_port"
            $verbose && jv_debug "$> $cmd"
            eval $cmd # safe: cmd does not contain user input ($2)
            return $?
        fi
    done <<< "$(echo $pg_x10_config | jq -r '.devices[].name')"
    say "$(pg_x10_lg "no_device_matching" "$2")"
    return 1
}
