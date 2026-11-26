# 01 Factory Demo

[English](README.md) | [简体中文](README_ZH.md)

## What It Does

This ESP-IDF project builds the open factory demonstration firmware for the ESP32-C6-Touch-LCD-1.47 board.

## Hardware Required

- ESP32-C6-Touch-LCD-1.47 development board

## How to Run

```bash
idf.py set-target esp32c6 build flash monitor
```

## Expected Result

The LCD starts in touchscreen test mode. Tap or drag to draw on the display, then press BOOT to enter the factory demo interface.

## Troubleshooting

If the factory interface has not appeared, press BOOT to exit the touchscreen test.
