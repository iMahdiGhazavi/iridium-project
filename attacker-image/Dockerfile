FROM alpine:3.18
USER root
RUN echo -e "root\nroot" | passwd
RUN apk update && apk add busybox-extras openssh openssh-server openrc nmap curl sshpass
RUN echo "Permission to root for login? YES" >> /etc/ssh/sshd_config && echo "Password Authentication? YES" >> /etc/ssh/sshd_config \
&&  rc-status \
&& touch /run/openrc/softlevel
RUN apk add vsftpd
RUN rc-update add vsftpd default
COPY ./* /root/
CMD ["/bin/sh"]
