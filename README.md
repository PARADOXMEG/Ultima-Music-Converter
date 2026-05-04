# Ultima-Music-Converter
Ultima Music Converter is a high-speed, parallelized Windows command-line tool powered by FFmpeg.

# 🎵 Ultima Music Converter

A powerful, all-in-one Windows batch script to **convert and organize your music library** with minimal effort. Built around FFmpeg, this tool supports multiple formats and batch processing — all through a simple menu interface.

---

## 🚀 Features

* 🔄 Convert audio formats:

  * FLAC → MP3 / M4A
  * MP3 → OPUS
  * Multi-format → OPUS (bulk mode)
* 📂 Recursive processing (handles entire folders automatically)
* 🧹 Optional deletion of original files
* 🎧 Metadata preservation (tags & album art when supported)
* ⚡ High-quality encoding via FFmpeg
* 🖥️ Simple interactive menu (no coding needed)

---

## 📦 Requirements

### 1. Install FFmpeg (Full Version via Winget)

Open **Command Prompt** or **Terminal** and run:

```bash id="6bn66v"
winget install --id Gyan.FFmpeg.Full -e
```

✅ This installs the **full FFmpeg build** with all major codecs (MP3, OPUS, AAC, etc.)

---

### 2. Verify Installation

```bash id="rrsizt"
ffmpeg -version
```

If installed correctly, version details will appear.

---

## 📁 Folder Setup

Place the script inside your music directory:

```id="okjt54"
Music/
│
├── Album1/
│   ├── song1.mp3
│   ├── song2.flac
│
├── Album2/
│   ├── track1.wav
│
└── ultima music converter.bat
```

---

## ▶️ Usage

1. Double-click `ultima music converter.bat`
2. Choose an option from the menu
3. The script will:

   * Scan all subfolders
   * Convert matching files
   * Save output in the same location

---

## 📜 Menu Options

| Option | Action             |
| ------ | ------------------ |
| 1      | FLAC → MP3         |
| 2      | FLAC → M4A         |
| 3      | MP3 → OPUS         |
| 4      | ALL formats → OPUS |
| 5      | Exit               |

> ⚠️ Options may vary slightly depending on your version.

---

## 🎧 Supported Formats

### Input

* `.mp3`, `.flac`,   `.m4a`, `.opus`

### Output

* `.mp3`, `.opus`, `.m4a`, `.flac`

---

## ⚙️ How It Works

* Uses FFmpeg for conversion
* Recursively scans directories
* Maintains original filenames
* Outputs files in the same folder as source

---

## 🛠️ Troubleshooting

### ❌ Script closes instantly

Run it manually:

```bash id="709bnk"
cmd
cd path\to\music
ultima music converter.bat
```

---

### ❌ `ffmpeg` not recognized

* Restart terminal
* Ensure installation completed
* Test:

```bash id="oj811t"
ffmpeg -version
```

---

### ❌ Conversion fails

* Check if codec is supported
* Ensure FFmpeg full build is installed
* Verify file integrity

---

## 💡 Tips

* 🔁 Backup files before bulk conversion
* 🎧 Use OPUS for best quality/size balance
* 💽 Use 320kbps MP3 for maximum compatibility

---

## 🧪 Example Commands (FFmpeg)

```bash id="ipb2vq"
ffmpeg -i input.flac output.mp3
ffmpeg -i input.mp3 output.opus
```

---

## 🔐 Safety Notes

* Files **may be overwritten** depending on script settings
* Deletion options are irreversible — use carefully

---

## 📜 License

This project is open-source. You are free to modify, distribute, and improve it.

---

## 🙌 Credits

* FFmpeg — encoding engine

---

## ⭐ Contributing

Contributions are welcome!

* Improve script performance
* Add new formats
* Enhance error handling
* Add UI improvements

Fork the repo and submit a pull request 🚀

---

## 📌 Future Ideas

* GUI version
* Drag & drop support
* Playlist-based conversion
* Auto-tagging (artist/title lookup)

---

Enjoy fast, clean, and powerful music conversion with **Ultima Music Converter** 🎶
