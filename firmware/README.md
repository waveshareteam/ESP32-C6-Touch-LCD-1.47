# Firmware

[English](README.md) | [简体中文](README_ZH.md)

Ready-to-flash firmware tested on the ESP32-C6-Touch-LCD-1.47 board. The image is a merged image flashed at `0x0`; the date in the file name is its version.

| File | Purpose |
| --- | --- |
| [`ESP32-C6-Touch-LCD-1.47_FactoryOnly_20261119.bin`](ESP32-C6-Touch-LCD-1.47_FactoryOnly_20261119.bin) | Updated factory/demo firmware |
| [`ESP32-C6-Touch-LCD-1.47_FactoryOnly_20250508.bin`](ESP32-C6-Touch-LCD-1.47_FactoryOnly_20250508.bin) | Factory firmware, restores the out-of-box demo |

Flash with esptool:

```bash
python -m pip install esptool
esptool.py --chip esp32c6 --port <PORT> erase_flash
esptool.py --chip esp32c6 --port <PORT> write_flash 0x0 ESP32-C6-Touch-LCD-1.47_FactoryOnly_20250508.bin
```

The 2026-11-19 image SHA-256 is `0DD9C8C64309AA69D32AF8BD5D79C505E4C561F5069AEA57E3EE21F40867FB9A`. The 2025-05-08 image SHA-256 is `349D3902334E8669462780EC9FAAADF60BECD8829D38CDD09B062092A9125666`.
