# NetLogin SDDM Theme (Fixed for KDE/Plasma 6+)

This is a **fixed and updated version of the NetLogin SDDM theme** for KDE Plasma. The original theme was not compatible with the latest versions of KDE/Plasma and SDDM due to QML import changes. This repository provides a patched version that works on modern systems.

## About

- **Original Author:** [NetLogin on KDE Store](https://store.kde.org/p/1425334/)
- **Original License:** GPLv2 or later
- **Modifications by:** [ArchCapone](https://github.com/ArchCapone)
- **What was fixed:**  
  Updated all QML files to use `import QtQuick 2.15` instead of `import QtQuick 6.0`, restoring compatibility with recent SDDM and KDE/Plasma versions.

## Attribution

This repository is a derivative work based on the original NetLogin SDDM theme.  
All original credits remain with the original author.  
The only modification is updating QML import statements for compatibility.

## Installation

1. **Clone or Download:**
   ```bash
   git clone https://github.com/ArchCapone/NetLogin-SDDM-Fix.git
   ```

2. **Copy to SDDM Themes Directory (requires root):**
   ```bash
   sudo cp -r NetLogin-SDDM-Fix /usr/share/sddm/themes/NetLogin
   ```

3. **Select the Theme:**
   - Open KDE System Settings.
   - Go to **Startup and Shutdown > Login Screen (SDDM)**.
   - Click **"Get New Login Screens"** to refresh, or select **NetLogin** from the list.
   - Apply the changes.

4. **Restart SDDM (optional):**
   ```bash
   sudo systemctl restart sddm
   ```

## Changelog

- **2025-05-18:**  
  - Updated QML imports to `QtQuick 2.15` for Plasma 6+ compatibility.

## License

This project is licensed under the GNU General Public License v2.0 or later.  
See [LICENSE](LICENSE) for details.

---

### Links

- [Original NetLogin Theme on KDE Store](https://store.kde.org/p/1425334/)
