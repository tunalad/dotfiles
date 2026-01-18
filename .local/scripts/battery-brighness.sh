#!/bin/bash
max_brightness=$(brightnessctl max)
target_brightness=$((max_brightness * 20 / 100))

if acpi -a | grep "off-line" >/dev/null; then
    brightnessctl set $target_brightness
else
    brightnessctl set $max_brightness
fi

acpi_listen | while read -r line; do
    if [[ $line == *"ac_adapter"* ]]; then
        if acpi -a | grep "off-line" >/dev/null; then
            brightnessctl set $target_brightness
        else
            brightnessctl set $max_brightness
        fi
    fi
done
