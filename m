From: Thierry Grandpierre <thierry.grandpierre@esiee.fr>
Message-ID: <56DC4081.4040807@esiee.fr>
Date: Sun, 6 Mar 2016 15:36:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rtnet/xenomai-3.0.1+3.18.20kernel: tdma & nomac issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear all,

I spent a week testing and browsing carefully the web but  didn't find 
any answer to my problems, so I am writing here..

1) RTNET/TDMA : I am unsuccessfully  trying to run rtnet/xenomai 3 on 2 
virtual machines : a VM as master and a VM as slave. Synchro frames are 
sent by the master and received on the slave machine (seen with 
wireshark on the rteth0 of each machine) but slave never answer. Both 
machine are VMs connected by a  VM to VM private network  (VMnet0 in 
VMware)

Rtnet on the slave machine is waiting with message :
     /usr/xenomai/sbin/rtcfg rteth0 add 10.0.0.2 -stage1 -
     Waiting for all slaves.../usr/xenomai/sbin/rtcfg rteth0 wait"

Rtnet on the master machine is also hanging with message
   /usr/xenomai/sbin/rtifconfig rteth0 up 10.0.0.2
   Stage 1: searching for master...

I think rtnet on the slave machine doesn't see/understand the sync 
frames. Below all details are given.

2)RTNET/NOMAC:
When trying nomac, once everything is configured, I'm getting " ioctl: 
Resource temporarily unavailable" when pinging. Details are also given 
at the end.

Many thank for your help or pointer to look for.
Regards,
Thierry G.

PS : I know that using rtnet/tdma on virtual machines shouldn't work 
since they are not real time and consequently impossible to synchronize 
in a slot, but they should at first be able to discover mutually during 
the init process of rtnet ?
Moreover I want to experiment with udp/nomac after that (see 2nd part of 
this mail where nomac doesn't work either).


Here are the details :
====================RTNET/TDMA=====================
1) ubuntu:~$ uname -a
Linux ubuntu 3.18.20 #1 SMP Wed Feb 24 09:41:38 PST 2016 x86_64 x86_64 
x86_64 GNU/Linux
(I used a VM build from a Ubuntu 15.04, 64 bits but I changed the 
default  3.19.0.15 kernel to 3.18.20 to be compatible with Ipipe)
2) ipipe-core-3.18.20-x86-4.patch
3) Xenomai-3.0.1
4) /usr/xenomai/etc/rtnet.conf is only modified for rt_e1000 support and 
only 1 slave

Then I  run :
ifconfig eth0 down
rmmod e1000
modprobe rt_e1000 (need to to rmmod/modprobe twice in order to be catch 
by the PCI ethernet card in lspci -k)
then I get : spci -k :
     02:01.0 Ethernet controller: Intel Corporation 82545EM Gigabit 
Ethernet Controller (Copper) (rev 01)
     Subsystem: VMware PRO/1000 MT Single Port Adapter
     Kernel driver in use: rt_e1000

Then I  started rtnet :
esiee@ubuntu:~$ sudo /usr/xenomai/sbin/rtnet -v start
[sudo] password for esiee:
Turning on verbose mode
/usr/xenomai/sbin/rtifconfig rtlo up 127.0.0.1
/usr/xenomai/sbin/rtcfg rteth0 server
/usr/xenomai/sbin/rtifconfig rteth0 up 10.0.0.1
/usr/xenomai/sbin/tdmacfg rteth0 master 5000
/usr/xenomai/sbin/tdmacfg rteth0 slot 0 0
/usr/xenomai/sbin/rtcfg rteth0 add 10.0.0.2 -stage1 -
Waiting for all slaves.../usr/xenomai/sbin/rtcfg rteth0 wait 
<====================doesn't go further

On this master machine, wireshark show emitted sync frame :
100    0.494738000    Vmware_cc:8c:1b    Broadcast    TDMA    42 
Synchronisation (several time per second)

Now the slave side :
---------------------------
this VM is a clone of the master.
I just changed rtnet.conf : ethernet driver, slave mode, IP address
Then I unload the linux ethernet driver, load the real time one (same 
way as the master)
and ran rtnet:
esiee@ubuntu:~$ sudo /usr/xenomai/sbin/rtnet -v start
Turning on verbose mode
/usr/xenomai/sbin/rtifconfig rtlo up 127.0.0.1
/usr/xenomai/sbin/tdmacfg rteth0 slave
/usr/xenomai/sbin/rtifconfig rteth0 up 10.0.0.2
Stage 1: searching for master...   <====================doesn't go further

and wireshark capture on this slave gave :
204    0.484035000    Vmware_cc:8c:1b    Broadcast    TDMA    64 
Synchronisation (several time per second)

dmesg on both machine doesn't give any error message :
a)dmesg on master:
   [  271.011125] Intel(R) PRO/1000 Network Driver - version 7.1.9
   [  271.011129] Copyright (c) 1999-2006 Intel Corporation.
   [  271.330610] e1000: 0000:02:01.0: e1000_probe: (PCI:66MHz:32-bit) 
00:0c:29:cc:8c:1b
   [  271.368979] RTnet: registered rteth0
   [  271.368982] e1000: rteth0: e1000_probe: Intel(R) PRO/1000 Network 
Connection
   [  332.364777] initializing loopback...
   [  332.364785] RTnet: registered rtlo
   [  332.373486] RTcap: real-time capturing interface
   [  332.509475] RTcfg: init real-time configuration distribution protocol
   [  332.545567] RTmac: init realtime media access control
   [  332.565151] RTmac/TDMA: init time division multiple access control 
mechanism
   [  332.572842] e1000: rteth0: e1000_watchdog: NIC Link is Up 1000 
Mbps Full Duplex
   [  373.353682] Bluetooth: Core ver 2.19
   [  373.353829] NET: Registered protocol family 31
   [  373.353830] Bluetooth: HCI device and connection manager initialized
   [  373.353836] Bluetooth: HCI socket layer initialized
   [  373.353838] Bluetooth: L2CAP socket layer initialized
   [  373.353845] Bluetooth: SCO socket layer initialized
   [  373.422197] Netfilter messages via NETLINK v0.30.
   [  377.406595] device rteth0 entered promiscuous mode
   [  386.228459] device rteth0 left promiscuous mode

b)dmesg on the slave :
   [   76.935549] Intel(R) PRO/1000 Network Driver - version 7.1.9
   [   76.935553] Copyright (c) 1999-2006 Intel Corporation.
   [   77.259212] e1000: 0000:02:01.0: e1000_probe: (PCI:66MHz:32-bit) 
00:0c:29:a5:4d:5c
   [   77.297059] RTnet: registered rteth0
   [   77.297062] e1000: rteth0: e1000_probe: Intel(R) PRO/1000 Network 
Connection
   [  155.912939] initializing loopback...
   [  155.912947] RTnet: registered rtlo
   [  155.921569] RTcap: real-time capturing interface
   [  155.999186] RTcfg: init real-time configuration distribution protocol
   [  156.014221] RTmac: init realtime media access control
   [  156.025028] RTmac/TDMA: init time division multiple access control 
mechanism
   [  156.045304] e1000: rteth0: e1000_watchdog: NIC Link is Up 1000 
Mbps Full Duplex
   [  204.929595] Bluetooth: Core ver 2.19
   [  204.930107] NET: Registered protocol family 31
   [  204.930109] Bluetooth: HCI device and connection manager initialized
   [  204.930115] Bluetooth: HCI socket layer initialized
   [  204.930116] Bluetooth: L2CAP socket layer initialized
   [  204.930121] Bluetooth: SCO socket layer initialized
   [  204.988581] Netfilter messages via NETLINK v0.30.
   [  210.730557] device rteth0 entered promiscuous mode
   [  427.270842] device rteth0 left promiscuous mode
   [  636.409601] device rteth0 entered promiscuous mode
  ==================================================================================
================================================================================== 

                                II - Issue with rtnet/nomac :
================================================================================== 

================================================================================== 


I restarted both VM, and execute the following commands on them after  :

esiee@ubuntu:~$ sudo ifconfig eth0 down
esiee@ubuntu:~$ sudo rmod e1000
esiee@ubuntu:~$ modprobe rt_e1000
esiee@ubuntu:~$ lspci -k <======no module attached to pci, I retry :
esiee@ubuntu:~$ rmmod rt_e1000
esiee@ubuntu:~$ modprobe rt_e1000
esiee@ubuntu:~$ lspci -k ======> this time it is attached
esiee@ubuntu:~$ sudo modprobe rtnet
esiee@ubuntu:~$ sudo modprobe rtipv4
esiee@ubuntu:~$ sudo modprobe rtudp
esiee@ubuntu:~$ sudo modprobe rtpacket
esiee@ubuntu:~$ sudo modprobe rtmac
esiee@ubuntu:~$ sudo modprobe nomac
esiee@ubuntu:~$ sudo /usr/xenomai/sbin/rtifconfig rteth0 up 10.0.0.1 
netmask 255.0.0.0
esiee@ubuntu:~$ sudo /usr/xenomai/sbin/rtifconfig
rteth0    Medium: Ethernet  Hardware address: 00:0C:29:CC:8C:1B
           IP address: 10.0.0.1  Broadcast address: 10.255.255.255
           UP BROADCAST RUNNING  MTU: 1500
esiee@ubuntu:~$ sudo /usr/xenomai/sbin/nomaccfg rteth0 attach
esiee@ubuntu:~$ sudo /usr/xenomai/sbin/rtroute solicit 10.0.0.2 dev rteth0
esiee@ubuntu:~$ sudo /usr/xenomai/sbin/rtroute
     Host Routing Table
     Hash    Destination    HW Address        Device
     3F    10.255.255.255    FF:FF:FF:FF:FF:FF    rteth0 ========> no 
route discovered
sudo /usr/xenomai/sbin/rtroute add 10.0.0.2 00:0C:29:A5:4D:5C dev rteth0 
==> I add the route manually
esiee@ubuntu:~$ sudo /usr/xenomai/sbin/rtroute
Host Routing Table
Hash    Destination    HW Address        Device
02    10.0.0.2      00:0C:29:A5:4D:5C    rteth0
3F    10.255.255.255    FF:FF:FF:FF:FF:FF    rteth0

================
on the second VM :
================
same commands, until :
esiee@ubuntu:~$ sudo /usr/xenomai/sbin/rtifconfig
rteth0    Medium: Ethernet  Hardware address: 00:0C:29:A5:4D:5C
           IP address: 10.0.0.2  Broadcast address: 10.0.0.255
           UP BROADCAST RUNNING  MTU: 1500
esiee@ubuntu:~$ sudo /usr/xenomai/sbin/nomaccfg rteth0 attach
esiee@ubuntu:~$ sudo /usr/xenomai/sbin/rtroute solicit 10.0.0.1 dev rteth0
esiee@ubuntu:~$ sudo /usr/xenomai/sbin/rtroute
Host Routing Table
Hash    Destination    HW Address        Device
3F    10.0.0.255    FF:FF:FF:FF:FF:FF    rteth0 ========> no route 
discovered
esiee@ubuntu:~$ sudo /usr/xenomai/sbin/rtroute add 10.0.0.1 
00:0C:29:CC:8C:1B dev rteth0
esiee@ubuntu:~$ sudo /usr/xenomai/sbin/rtroute
Host Routing Table
Hash    Destination    HW Address        Device
01    10.0.0.1      00:0C:29:CC:8C:1B    rteth0
3F    10.0.0.255    FF:FF:FF:FF:FF:FF    rteth0


Once configuration done, VM are still unable to ping themselves :
1) on first VM (IP= 10.0.0.1)
     esiee@ubuntu:~$ sudo /usr/xenomai/sbin/rtping 10.0.0.2
     Real-time PING 10.0.0.2 56(84) bytes of data.
     ioctl: Resource temporarily unavailable


2) on second VM (IP = 10.0.0.2)
     esiee@ubuntu:~$ sudo /usr/xenomai/sbin/rtping 10.0.0.1
     Real-time PING 10.0.0.1 56(84) bytes of data.
     ioctl: Resource temporarily unavailable

  I am also unable to use wireshark since rteth0  is not listed..
Does I need to load rtcfg ?

Many thanks again
Thierry






