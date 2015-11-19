From: Umair Ali <ali.umair@tut.fi>
Date: Thu, 19 Nov 2015 11:44:50 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A70D64A@mb2010-1.intra.tut.fi>
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Problem: rtifconfig rteth0 hangs the terminal and
 applications except mouse cursor.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello Xenomai team,

I have faced a problem that when i am trying to run the command
"root@cpc:/usr/xenomai/sbin# ./rtifconfig rteth0 up 10.0.0.175 netmask 255.=
255.255.0" then my terminal and other applications hangs up but the mouse c=
ursor is still works but i can not close any terminal or anything else.
My aim was to make the 'rteth0' interface up. For doing this i have followe=
d the following steps
1) First unbind the driver 8139too from the NIC and bind the driver rt_8139=
too as specfied in the link https://lwn.net/Articles/143397/.
"root@cpc:/usr/xenomai/sbin# tree /sys/bus/pci/drivers/rt_8139too/
/sys/bus/pci/drivers/rt_8139too/
=1B$B('(!(!=1B(B 0000:05:04.0 -> ../../../../devices/pci0000:00/0000:00:1e.=
0/0000:05:04.0
=1B$B('(!(!=1B(B bind
=1B$B('(!(!=1B(B module -> ../../../../module/rt_8139too
=1B$B('(!(!=1B(B new_id
=1B$B('(!(!=1B(B remove_id
=1B$B('(!(!=1B(B uevent
=1B$B(&(!(!=1B(B unbind

2 directories, 5 files"


2) I followed this link for further steps
https://sir.upc.edu/wikis/roblab/index.php/Development/RTnet
 root@cpc:/usr/xenomai/sbin# mknod /dev/rtnet c 10 240
mknod: =1B$B!F=1B(B/dev/rtnet=1B$B!G=1B(B: File exists

3)root@cpc:/usr/xenomai/sbin# insmod /lib/modules/3.14.39-xenomai-3.0.1/ker=
nel/drivers/xenomai/net/stack/rtnet.ko
insmod: ERROR: could not insert module /lib/modules/3.14.39-xenomai-3.0.1/k=
ernel/drivers/xenomai/net/stack/rtnet.ko: File exists

4) root@cpc:/usr/xenomai/sbin# insmod /lib/modules/3.14.39-xenomai-3.0.1/ke=
rnel/drivers/xenomai/net/stack/ipv4/rtipv4.ko

5)root@cpc:/usr/xenomai/sbin# insmod /lib/modules/3.14.39-xenomai-3.0.1/ker=
nel/drivers/xenomai/net/stack/packet/rtpacket.ko

6)root@cpc:/usr/xenomai/sbin# insmod /lib/modules/3.14.39-xenomai-3.0.1/ker=
nel/drivers/xenomai/net/drivers/rt_loopback.ko

7)root@cpc:/usr/xenomai/sbin# insmod /lib/modules/3.14.39-xenomai-3.0.1/ker=
nel/drivers/xenomai/net/drivers/rt_8139too.ko
insmod: ERROR: could not insert module /lib/modules/3.14.39-xenomai-3.0.1/k=
ernel/drivers/xenomai/net/drivers/rt_8139too.ko: File exists

9)root@cpc:/usr/xenomai/sbin# insmod /lib/modules/3.14.39-xenomai-3.0.1/ker=
nel/drivers/xenomai/net/addons/rtcap.ko

10) root@cpc:/usr/xenomai/sbin# ./rtifconfig -a
rteth0    Medium: Ethernet  Hardware address: 00:00:B4:C3:08:97
          BROADCAST  MTU: 1500
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

rtlo      Medium: Local Loopback
          LOOPBACK  MTU: 1500

11) root@cpc:/usr/xenomai/sbin# ./rtifconfig rtlo up 127.0.0.1
root@cpc:/usr/xenomai/sbin#

But when i run the command "root@cpc:/usr/xenomai/sbin# ./rtifconfig rteth0=
 up 10.0.0.175 netmask 255.255.255.0" every thing hangs up and even i remov=
e the mod "rmmod 8139too" and the run the command again the results are sam=
e. I was thinking that may be 8139too is using same irq interrupts thats wh=
y i removed the module but problem persists.

I have the following setups:
"root@cpc:/usr/xenomai/sbin# dmesg |grep -i xenomai
[    0.000000] Linux version 3.14.39-xenomai-3.0.1 (root@cpc) (gcc version =
4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04) ) #2 SMP PREEMPT Tue Nov 10 18:02:47 EE=
T 2015
[    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-3.14.39-xeno=
mai-3.0.1 root=3DUUID=3De29fa266-6a54-4815-b5bd-ea0168f18fd7 ro quiet splas=
h crashkernel=3D384M-:128M vt.handoff=3D7
[    0.851788] [Xenomai] scheduling class idle registered.
[    0.851792] [Xenomai] scheduling class rt registered.
[    0.851839] [Xenomai] SMI-enabled chipset found, but SMI workaround disa=
bled
[    0.851839]           (see xenomai.smi parameter). You might encounter
[    0.851970] I-pipe: head domain Xenomai registered.
[    0.852615] [Xenomai] Cobalt v3.0.1 (Exact Zero) [DEBUG]
[    1.644181] usb usb1: Manufacturer: Linux 3.14.39-xenomai-3.0.1 ehci_hcd
[    1.645404] usb usb2: Manufacturer: Linux 3.14.39-xenomai-3.0.1 uhci_hcd
[    1.646271] usb usb3: Manufacturer: Linux 3.14.39-xenomai-3.0.1 uhci_hcd
[    1.647128] usb usb4: Manufacturer: Linux 3.14.39-xenomai-3.0.1 uhci_hcd
[    1.648021] usb usb5: Manufacturer: Linux 3.14.39-xenomai-3.0.1 uhci_hcd
[   11.424158] *** RTnet for Xenomai v3.0.1 ***"

root@cpc:/usr/xenomai/sbin# dmesg |grep -i rtnet
[   11.424158] *** RTnet for Xenomai v3.0.1 ***
[   11.424170] RTnet: initialising real-time networking
[  705.184317] RTnet: registered rteth0
[ 1025.632565] RTnet: registered rtlo

Can you tell me what is causing the problem. Actually i am working to build=
 a pcap replay tool in real time. Firstly i was trying to up the real time =
interface then send the packets as raw Ethernet but it seems the interface =
is having a problem. Can you also guide me that how i can read the pcap fil=
e. As in the non real-time Linux you have the libpcap library which have th=
e functions to open a pcap file in the offline mode and then read the data =
packet by packet. But I am trying to figure that is there library like libp=
cap which i can use with xenomai and rtnet to read pcap file. Please guide =
me

 Thanks & Regards
Ali




