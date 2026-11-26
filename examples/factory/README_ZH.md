# 01 出厂演示

[English](README.md) | [简体中文](README_ZH.md)

## 功能

本示例演示 ESP32-C6-Touch-LCD-1.47 的触摸测试和出厂界面。

## 硬件需求

- ESP32-C6-Touch-LCD-1.47 开发板

## 怎么运行

```bash
idf.py set-target esp32c6 build flash monitor
```

## 预期现象

上电后屏幕进入触摸测试，点击或滑动可绘制轨迹。按下 BOOT 键进入出厂演示界面。

## 常见问题

如果仍停留在触摸测试界面，请按 BOOT 键退出测试。
