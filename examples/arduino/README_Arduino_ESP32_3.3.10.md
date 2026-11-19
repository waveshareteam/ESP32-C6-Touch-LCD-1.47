# ESP32-C6-Touch-LCD-1.47：Arduino-ESP32 3.3.10

## 编译环境

- 开发板管理器：**esp32 by Espressif Systems 3.3.10**。
- 开发板：**ESP32C6 Dev Module**。
- USB CDC On Boot：**Enabled**。
- Flash Size：**4MB**。
- Partition Scheme：**Default 4MB with spiffs**。
- CPU Frequency：**160MHz**。
- 串口波特率：**115200**。

这里的 3.3.10 指 ESP32 开发板包版本，不是 Arduino IDE 的版本。

## 安装依赖

请将本目录 `libraries` 中的以下四个文件夹复制到 Arduino 的草图文件夹下的 `libraries` 中，使用本项目提供的文件：

| 文件夹 | 版本/用途 |
| --- | --- |
| GFX_Library_for_Arduino | 1.5.9，包含本次 ESP32-C6 兼容补丁 |
| lvgl | 8.4.0 |
| FastIMU | 1.2.8，QMI8658 驱动 |
| esp_lcd_touch_axs5106l | 项目提供的触摸驱动 |

如果已经安装同名库，请先备份旧库，再替换为这里的版本，避免 Arduino 选择到其他副本。不要用未包含本补丁的 GFX 1.5.9 覆盖本项目提供的库。

`04`～`08` 使用 LVGL 8 API，请保留每个示例目录中的 `lv_conf.h`，不要替换成 LVGL 9。

## 编译示例

打开 `examples` 下对应文件夹内的同名 `.ino`，选择上述开发板设置，点击“验证”。

使用已安装 ESP32 3.3.10 的 Arduino CLI 时，可在本目录执行：

```powershell
arduino-cli compile --fqbn 'esp32:esp32:esp32c6:CDCOnBoot=cdc,FlashSize=4M,PartitionScheme=default' --libraries .\libraries .\examples\01_gfx_helloworld
```

其余示例替换最后的示例目录即可。`02` 只需 FastIMU 与 Core 内置 Wire；`03` 使用 Core 内置 FS、SD、SPI。

已安装 Arduino CLI 和 ESP32 3.3.10 后，可以在本目录运行 `./verify_3.3.10.ps1` 一次验证全部 8 个示例。CLI 不在 PATH 中时，通过 `-ArduinoCli '实际的 arduino-cli.exe 路径'` 指定。脚本将日志和 `results.json` 保存到 `work/build_3.3.10`，不执行烧录。

## 本次修改

1. 修复 GFX 的 `Arduino_HWSPI.cpp`、`Arduino_SWSPI.cpp`、`Arduino_SWPAR8.cpp`、`Arduino_SWPAR16.cpp`：ESP32-C6 与 ESP32-C3 一样使用单组 GPIO 寄存器，避免编译时引用不存在的 `GPIO_OUT1_W1TS_REG`、`GPIO_OUT1_W1TC_REG`。Arduino 会编译库内的其他总线源文件，因此需要同时修复这四处。
2. 亮度示例继续使用 3.x 的 `ledcAttach(pin, frequency, resolution)` 和 `ledcWrite(pin, duty)`；将占空比改为 `(1023 * percent) / 100`，避免先除以 100 造成精度损失，100% 时可输出完整占空比。
3. 移除 `Arduino_ESP32SPIDMA` 中未使用的 `_div` 成员及旧版 `spiFrequencyToClockDiv()` 调用，避免与 Core 3.3.10 的新函数签名冲突。DMA 的实际时钟仍通过 ESP-IDF 的 `clock_speed_hz` 配置。
4. 已兼容的示例保留原有 API，统一使用上述 Core 和随附库。

安装 Arduino CLI 后，也可运行 `verify_3.3.10.ps1` 一次编译全部 8 个示例；脚本先检查已安装 Core 必须为 3.3.10，编译日志与结果默认写入本目录的 `work/build_3.3.10`。

编译验证结果见交付的验证说明。编译通过与屏幕、触摸、SD 卡及 IMU 的硬件运行验证分别记录。
