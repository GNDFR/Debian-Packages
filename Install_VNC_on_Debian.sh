sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla
sudo apt update
sudo apt install -y xfce4 tigervnc-standalone-server dbus-x11 nodejs git firefox
git clone https://github.com/novnc/noVNC.git
vncserver :1
vncserver -kill :1
cat > ~/.vnc/xstartup <<'EOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
export XKL_XMODMAP_DISABLE=1
export DISPLAY=:1
exec startxfce4
EOF
chmod +x ~/.vnc/xstartup
cat > run_vnc.sh << 'EOF'
#!/bin/bash
vncserver :1
./noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 6080
EOF
chmod +x run_vnc.sh
./run_vnc.sh
