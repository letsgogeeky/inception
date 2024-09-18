#!/bin/bash

## write config function
write_config() {
cat <<EOL > /etc/vsftpd.conf
listen=YES
listen_port=21
listen_address=0.0.0.0
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
xferlog_enable=YES
xferlog_file=/var/log/vsftpd.log
log_ftp_protocol=YES
connect_from_port_20=YES
chroot_local_user=YES
allow_writeable_chroot=YES
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
pasv_enable=YES
pasv_min_port=30000
pasv_max_port=30009
secure_chroot_dir=/var/run/vsftpd/empty
local_root=/home/$FTP_USER/ftp
utf8_filesystem=YES
ssl_enable=NO
EOL
}

# set ftp user and password
if id -u $FTP_USER &>/dev/null; then
    echo "User $FTP_USER already exists"
else
    useradd -m "$FTP_USER"
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
    echo "User $FTP_USER created"
    echo "$FTP_USER" > /etc/vsftpd.userlist

    mkdir -p /home/$FTP_USER/ftp/files

    chown nobody:nogroup /home/$FTP_USER/ftp
    chmod a-w /home/$FTP_USER/ftp
    chown $FTP_USER:$FTP_USER /home/$FTP_USER/ftp/files

    # Secure chroot jail
    mkdir -p /var/run/vsftpd/empty
    write_config
    fi


# run vsftpd
/usr/sbin/vsftpd /etc/vsftpd.conf