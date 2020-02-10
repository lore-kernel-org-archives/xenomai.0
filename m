From: "Kloock, Lennard" <Lennard.Kloock@meg.mee.com>
Subject: Installing RTnet
Date: Mon, 10 Feb 2020 13:10:30 +0000
Message-ID: <62607370399744fa9b6b6b3fe761f190@meg.mee.com>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello all,

i have succesfully installed Xenomai 3.0.5 with linux 4.9.90, but I am havi=
ng trouble installing RTnet on an i218-lm.

I followed these steps:
1) ifconfig eth0 down
2) rmmod e1000e
3) configured /usr/xenomai/etc/rtnet.conf according to https://gitlab.denx.=
de/Xenomai/xenomai/-/wikis/RTnet
4) modprobe rtpacket
5) modprobe rtnet
6) modprobe rt_e1000e

But now if I try to run rtnet with  ./rtnet start I get the following error=
s:

ioctl: No such device
ioctl: No such device
ioctl: No such device
ioctl: No such device
ioctl (add): No such device
ioctl (add): No such device
ioctl (add): No such device
ioctl (add): No such device
vnic0: ERROR while getting interface flags: No such device
SIOCSIFADDR: No such device
vnic0: ERROR while getting interface flags: No such device
SIOCSIFNETMASK: No such device
Waiting for all slaves...ioctl: No such device
ioctl: No such device

./rtifconfig only show the local loopback but not rteth0

Dmesg shows that rtnet and the driver are being loaded

[  391.184595]
               *** RTnet for Xenomai v3.0.5 ***

[  391.184596] RTnet: initialising real-time networking
[  400.034853] rt_e1000e: Intel(R) PRO/1000 Network Driver - 1.5.1-k-rt
[  400.034854] rt_e1000e: Copyright(c) 1999 - 2011 Intel Corporation.

But with lspci -knn it shows that the NIC doesn't pick up the real time dri=
ver:

00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connection I=
219-LM [8086:156f] (rev 21)
                Subsystem: Gigabyte Technology Co., Ltd Ethernet Connection=
 I219-LM [1458:e000]
                Kernel modules: e1000e

Did I do something wrong or is my I219-LM NIC not supported by RTnet?

Many Thanks

Lennard Kloock

