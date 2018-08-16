From: =?iso-8859-1?Q?St=E9phane_Reichert?= <sreichert@sepro-group.com>
Date: Thu, 16 Aug 2018 15:23:15 +0200 (CEST)
Message-ID: <004e01d43564$4970d4c0$dc527e40$@sepro-group.com>
MIME-Version: 1.0
Content-Language: fr
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] RTNet - how to setup rt_fec on IMX6Q (Xenomai 3.0.7)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,



We are trying to use the rt_fec driver for RTNet on a iMX6Q board.



I have patched the KConfig to add this driver on buildroot and it compiles
perfectly.



But now, I am not able to use it on our board (it works when I =93rtping=94
the loopback,

but it doesn=92t work if I try to ping an external board).



Each time I try to use the device, the rt_ping command returns

=93ioctl: Resource temporarily unavailable=94.



The same occurs if I try with or without tdma.



To reproduce the problem, here is the initialization sequence:

# modprobe rtnet

# modprobe rtipv4

# modprobe rt_fec

# echo 2188000.ethernet > /sys/bus/platform/drivers/fec/unbind

# echo 2188000.ethernet > /sys/bus/platform/drivers/rt_fec/bind

# modprobe rtudp

# modprobe rtpacket

# rtifconfig rteth0 up 192.168.214.30 netmask 255.255.0.0 hw ether
00:07:AC:81:0

# rtifconfig

rteth0    Medium: Ethernet  Hardware address: 00:07:AC:81:00:5D

          IP address: 192.168.214.30  Broadcast address: 192.168.255.255

          UP BROADCAST  MTU: 1500

          RX packets:0 errors:0 dropped:0 overruns:0 frame:0

          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0

          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

# rtroute add 192.168.214.250 00:50:56:a2:d2:b6 dev rteth0

# rtroute

Host Routing Table

Hash    Destination     HW Address              Device

3A      192.168.214.250 00:50:56:A2:D2:B6       rteth0

3F      192.168.255.255 FF:FF:FF:FF:FF:FF       rteth0



Network Routing Table

Hash    Destination     Mask                    Gateway

# rtping 192.168.214.250

Real-time PING 192.168.214.250 56(84) bytes of data.

ioctl: Resource temporarily unavailable



Linux :   4.1.46

Xenomai : 3.0.7



Did anyone face this problem (I found some similary issues, but they
didn=92t solve my problem on rt_fec) ?



St=E9phane




Sepro

St=E9phane REICHERT

  _____

 <http://www.sepro-group.com/fr> www.sepro-group.com |
<https://twitter.com/seprogroup> twitter@SeproGroup






-------------- next part --------------
A non-text attachment was scrubbed...
Name: image001.jpg
Type: image/jpeg
Size: 26078 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20180816/c9b84399/at=
tachment.jpg>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image004.png
Type: image/png
Size: 818 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20180816/c9b84399/at=
tachment.png>
