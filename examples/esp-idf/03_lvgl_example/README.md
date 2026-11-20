# 03_lvgl_example

[English](README.md) | [简体中文](README_ZH.md)

## What It Does

This example initializes the JD9853 LCD and AXS5106L touch controller, then runs a touch-enabled LVGL interface.

## Hardware Required

- ESP32-C6-Touch-LCD-1.47 development board

## How to Run

```bash
idf.py set-target esp32c6 build flash monitor
```

## Expected Result

The LCD displays the LVGL interface and responds to touch input.

## Troubleshooting

None yet.
