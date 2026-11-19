# 02_sd_card_test

[English](README.md) | [简体中文](README_ZH.md)

## What It Does

This example mounts a FAT32 TF card over the shared SPI bus and exercises directory and file operations.

## Hardware Required

- ESP32-C6-Touch-LCD-1.47 development board
- A FAT32 TF card

## How to Run

```bash
idf.py set-target esp32c6 build flash monitor
```

## Expected Result

The serial monitor reports the card type, capacity, directory listing and file operations.

## Troubleshooting

The LCD and TF card share SPI clock and MOSI pins. Keep the inactive chip select deasserted.
