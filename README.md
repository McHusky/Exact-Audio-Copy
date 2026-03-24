<p align="left">
  <img src="https://raw.githubusercontent.com/mchusky/Exact-Audio-Copy/main/icon.png" width="64" align="left" style="margin-right:15px;" />
</p>

# Exact Audio Copy (EAC) Docker Container

![GHCR](https://img.shields.io/badge/GHCR-available-blue)
![Unraid](https://img.shields.io/badge/Unraid-template-orange)

This project provides a fully preconfigured Docker container for running **Exact Audio Copy (EAC)** using Wine.

It is designed to work out-of-the-box:

* No manual Wine setup required
* No .NET installation required
* No EAC configuration required
* Insert CD → Start ripping

---

## 🚀 Features

* Preconfigured Wine environment
* Exact Audio Copy fully installed
* .NET 2.0 / 4.0 already configured
* Optical drive support (`/dev/sr0` + `/dev/sgX`)
* Web interface via noVNC
* Output directly to your filesystem
* **Configured for 100% accurate FLAC ripping**

---

## 📦 Docker Image

```bash
ghcr.io/mchusky/exact-audio-copy:latest
```

---

# 🧰 Unraid (Recommended)

The easiest way to use this container is via the Unraid template.

## Install Template

Run this command on your Unraid server:

```bash
wget -O /boot/config/plugins/dockerMan/templates-user/exact-audio-copy.xml \
https://raw.githubusercontent.com/McHusky/Exact-Audio-Copy/main/unraid-templates/exact-audio-copy.xml
```

Then:

1. Go to **Docker tab**
2. Click **Add Container**
3. Select **Exact-Audio-Copy**

---

# ▶️ Quick Start (Docker / Linux)

```bash
docker run -d \
  --name exact-audio-copy \
  -p 8080:8080 \
  -v /path/to/output:/output \
  --device /dev/sr0:/dev/sr0 \
  --device /dev/sg1:/dev/sg1 \
  ghcr.io/mchusky/exact-audio-copy:latest
```

Open:

```text
http://localhost:8080/eac.html
```

---

# 📀 Finding your CD/DVD drive

Run:

```bash
ls -l /dev/s* | grep -Ei "cd|dvd"
```

Example:

```text
/dev/sr0
/dev/sg1
```

Use both devices.

---

# 🎧 Perfect FLAC Ripping (Recommended Workflow)

This container is preconfigured for **secure and accurate FLAC ripping**.

To create perfect rips:

1. Insert your CD
2. Open EAC in the browser
3. Run the following steps:

```
1. Action → Detect Gaps
2. Action → Create CUE Sheet → Multiple WAV Files With Gaps... (Noncompliant)
3. Test & Copy Selected Tracks → Compressed...
```

👉 This ensures:

* AccurateRip verification
* Proper gap detection
* Bit-perfect FLAC output

---

# 📁 Output directory

Inside EAC:

```
Z:\output
```

Maps to:

```
/path/to/output
```

---

# 🧠 Notes

* Works with USB optical drives
* All configuration is baked into the image
* Ready for AccurateRip
* `cdrdao` is disabled (not needed for standard ripping)

---

# 🛠️ Development

```bash
docker build -t eac-unraid .
```

---

# ❤️ Credits

* Exact Audio Copy by Andre Wiethoff
* Wine project
* noVNC

---

# ⚖️ Disclaimer

This image contains a preconfigured Windows environment using Wine.
Ensure compliance with all applicable software licenses when using or distributing.

---

# 🚀 Status

✔ Fully working
✔ Reproducible
✔ GHCR published
✔ Unraid & Linux compatible

---

Enjoy ripping 🎧
