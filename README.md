# **Emergency Sudo Restore for Linux Mint**


**Purpose:**
This script safely restores the sudo command on Linux Mint 22.2 if it becomes broken or corrupted. It is intended to be used from a Linux Mint Live USB.


# **Usage**


**1.** Boot your computer from a Linux Mint Live USB.

**2.** Copy the script to a writable location, such as your home folder or a separate USB.

**3.** Open a terminal and navigate to the script:

```bash
cd /path/to/script
```

**4.** Make the script executable:

```bash
chmod +x emergency_sudo_restore.sh
```

**5.** Run the script:

```bash
./emergency_sudo_restore.sh
```

**6.** Follow the on-screen prompts to select the installed root partition.

**7.** Once finished, reboot into your installed system. sudo should now work.


# **Safety Notes**

- Only the selected root partition will be modified. Other drives or USBs remain untouched.

- The script requires explicit confirmation before proceeding.


# **License**

MIT License — free to use and modify.

