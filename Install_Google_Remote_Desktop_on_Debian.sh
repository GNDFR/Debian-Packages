wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo apt update
sudo apt install -y xfce4 dbus-x11 falkon ./chrome-remote-desktop_current_amd64.deb
rm chrome-remote-desktop_current_amd64.deb
cat > ~/.chrome-remote-desktop-session <<'EOF'
#!/bin/bash
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
export XKL_XMODMAP_DISABLE=1
exec startxfce4
EOF
chmod +x ~/.chrome-remote-desktop-session
echo "Please visit https://remotedesktop.google.com/headless on another computer and copy/paste the command here to complete setup."
