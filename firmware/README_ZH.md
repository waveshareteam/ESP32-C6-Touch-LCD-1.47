# 固件

[English](README.md) | [简体中文](README_ZH.md)

这是在 ESP32-C6-Touch-LCD-1.47 开发板上实测、可直接烧录的固件。文件是从 `0x0` 烧录的合并镜像，文件名中的日期是版本。

| 文件 | 用途 |
| --- | --- |
| [`ESP32-C6-Touch-LCD-1.47_FactoryOnly_20261119.bin`](ESP32-C6-Touch-LCD-1.47_FactoryOnly_20261119.bin) | 更新后的出厂/演示固件 |
| [`ESP32-C6-Touch-LCD-1.47_FactoryOnly_20250508.bin`](ESP32-C6-Touch-LCD-1.47_FactoryOnly_20250508.bin) | 出厂固件，恢复开箱演示 |

使用 esptool 烧录：

```bash
python -m pip install esptool
esptool.py --chip esp32c6 --port <PORT> erase_flash
esptool.py --chip esp32c6 --port <PORT> write_flash 0x0 ESP32-C6-Touch-LCD-1.47_FactoryOnly_20250508.bin
```

2026-11-19 镜像 SHA-256 为 `0DD9C8C64309AA69D32AF8BD5D79C505E4C561F5069AEA57E3EE21F40867FB9A`，2025-05-08 镜像 SHA-256 为 `349D3902334E8669462780EC9FAAADF60BECD8829D38CDD09B062092A9125666`。
