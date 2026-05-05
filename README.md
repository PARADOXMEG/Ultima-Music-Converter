# 🎧 ULTIMA MUSIC CONVERTER

**High-performance parallel audio conversion powered by FFmpeg**

Ultima Music Converter is a lightweight command-line utility designed to batch-convert music libraries with speed and precision. It supports high-quality presets (320kbps) and lossless wrapping, ensuring your metadata and album art remain intact.

---

## 🚀 Features

* **Parallel Processing**: Converts up to 5 files simultaneously to maximize CPU usage.
* **Cross-Platform**: Includes a `.bat` script for Windows and a `.sh` script for Linux.
* **Deep Search**: Automatically scans subdirectories (recursive search) to find all your music.
* **Metadata Retention**: Preserves audio streams, album art (where supported), and metadata.
* **Smart Cleanup**: Deletes the source file only after a successful conversion.
* **Unicode Support**: Handles spaces, emojis, and special characters without errors.

---

## 📥 Installation

### 🪟 Windows

1. **Install FFmpeg**
   Open PowerShell or Command Prompt:

   ```powershell
   winget install ffmpeg
   ```

2. **Create the Script**
   Create a new file named:

   ```
   ultima music converter.bat
   ```

3. **Critical Saving Procedure**

   * Paste your script into Notepad
   * Go to **File > Save As**
   * Set **Save as type** → `All Files (*.*)`
   * Set **Encoding** → `UTF-8`
   * Save as:

     ```
     ultima music converter.bat
     ```

---

### 🐧 Linux

#### Debian / Ubuntu

```bash
sudo apt update && sudo apt install ffmpeg -y
```

#### Arch Linux

```bash
sudo pacman -S ffmpeg
```

#### Fedora

```bash
sudo dnf install ffmpeg
```

2. **Download Script**

```
UltimaMusicConverter.sh
```

3. **Grant Permissions**

```bash
chmod +x UltimaMusicConverter.sh
```

---

## 🛠 Usage

### 🪟 Windows

1. Place `ultima music converter.bat` in the **root folder of your music library**
   (the main folder containing all your subfolders and audio files)

2. Run the script:

   ```
   ultima music converter.bat
   ```

   or double-click it

3. Follow prompts to select:

   * Conversion type
   * Parallel task limit (1–5)

---

### 🐧 Linux

1. Place `UltimaMusicConverter.sh` in the **root folder of your music library**

2. Open terminal in that folder

3. Run:

   ```bash
   ./UltimaMusicConverter.sh
   ```

4. Follow the prompts inside the script

---

## 🎵 Supported Conversions

| Source | Target            | Quality / Method        |
| ------ | ----------------- | ----------------------- |
| FLAC   | MP3 / M4A / Opus  | 320kbps High Quality    |
| MP3    | Opus / M4A        | 320kbps High Quality    |
| MP3    | FLAC              | Lossless Wrapping       |
| M4A    | MP3 / Opus / FLAC | High Quality / Lossless |
| Opus   | MP3 / M4A / FLAC  | High Quality / Lossless |

---

## ⚠️ Requirements

* **FFmpeg must be installed**

  ```bash
  ffmpeg -version
  ```
* **Disk Space**
  Ensure enough space for temporary files before originals are deleted.

---

## 📌 Notes

* Script must be placed in the **root music folder** for proper recursive scanning
* Source files are deleted **only after successful conversion**
* Works with nested folders automatically
* Supports most common audio formats

---

## 📄 License

MIT License 

---

## 💡 Tip

For best performance, use SSD storage and increase parallel tasks based on your CPU capability.
