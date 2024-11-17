# VLC Protocol

Easily open `vlc://` links directly from your web browser and play them with VLC Media Player.

## 🚀 Features
- **Seamless Integration**: Open `vlc://` links directly in VLC Media Player.
- **Protocol Correction**: Automatically fixes common issues with malformed URLs.
- **Enhanced Handling**: Improved support for various URL formats and edge cases.

## 📂 Installation

### Option 1: Automated Setup (Recommended)
Set up the VLC protocol handler effortlessly using the provided PowerShell script.

#### Steps:
1. **Open PowerShell as Administrator**  
   - Right-click on PowerShell and select **Run as Administrator**.

2. **Run the Setup Script**  
   Execute the following command to download and set up the required files:

   ```powershell
   irm https://tanmoythebot.github.io/vlc-protocol/vlc-protocol-setup.ps1 | iex
   ```

---

### Option 2: Manual Setup
Follow these steps if you prefer manual installation:

1. **Download the Required Files**  
   Copy the files from the `bat` directory into your VLC installation directory:  
   *(Default: `C:\Program Files\VideoLAN\VLC`)*

2. **Register the Protocol**  
   Run the `vlc-protocol-register.bat` file as administrator:  
   - Right-click on the file and select **Run as Administrator**.

3. **Completion**  
   Once the protocol is registered, your browser will recognize `vlc://` links and open them in VLC Media Player.

---

## 🛠️ Troubleshooting
- **Permission Errors**:  
  Ensure that `vlc-protocol-register.bat` is run as an administrator. Elevated permissions are required for system-wide protocol registration.

- **Installation Path Issues**:  
  Confirm that VLC Media Player is installed in the default directory. If not, adjust the `.bat` files' location accordingly.

- **Browser Compatibility**:  
  Some browsers may need additional configuration to support custom protocols. Refer to your browser's documentation for enabling protocol handlers.

---

## 📝 Credits
This project builds upon [Stefan Sundin's VLC Protocol Handler](https://github.com/stefansundin/vlc-protocol), introducing:
- **Protocol Correction**: Automatically fixes malformed URLs.
- **Modern Compatibility**: Improved support for newer browsers.
