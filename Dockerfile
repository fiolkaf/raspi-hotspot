FROM jsurf/rpi-raspbian
RUN apt-get update 
RUN apt-get install dnsmasq hostapd iptables nat
RUN echo "denyinterfaces wlan0" >> /etc/dhcpcd.conf

COPY ./interfaces /etc/network/
COPY ./hostapd.conf /etc/hostapd/
COPY ./dnsmasq.conf /etc

RUN sed -i '/net.ipv4.ip_forward/s/^#//g'  /etc/sysctl.conf
#RUN sysctl --system
#RUN sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"

COPY ./run.sh /
CMD ["/run.sh"]
