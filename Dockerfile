FROM scratch

#ADD https://downloads.openwrt.org/chaos_calmer/15.05.1/x86/64/openwrt-15.05.1-x86-64-rootfs.tar.gz /
ADD openwrt-15.05.1-x86-64-rootfs.tar.gz /

RUN mkdir /var/lock && \
    opkg update && \
    opkg install uhttpd-mod-lua && \
    opkg install luci-i18n-base-zh-cn && \
    opkg install shadowsocks-client && \
    opkg install minidlna && \
    opkg install luci-i18n-minidlna-zh-cn && \
    opkg install lftp && \
    opkg install openssh-server && \
    opkg install openssh-sftp-server && \
    opkg install samba36-server && \
    opkg install luci-i18n-samba-zh-cn && \
    uci set uhttpd.main.interpreter='.lua=/usr/bin/lua' && \
    uci commit uhttpd

USER root

EXPOSE 80

# using exec format so that /sbin/init is proc 1 (see procd docs)
CMD ["/sbin/init"]
