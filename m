From: Yann Le Chevoir <yann.lechevoir@cae.com>
Subject: rtnet rt_igb I210 not working with ARM
Date: Thu, 2 Dec 2021 14:35:03 +0000
Message-ID: <AS8PR09MB53544DAD9617B02126202C6381699@AS8PR09MB5354.eurprd09.prod.outlook.com>
Content-Language: fr-FR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I have an issue with rt_igb not working with an Intel I210 on ARM (see
system configuration below).
With Wireshark, looks like rtping is sending garbage on the network (see
below).
I notice there is no interrupt in /proc/xenomai/irq (see below).
Looks like other people got issues with I210 in the past but I am not sure
if they were similar and I am not able to find any conclusion.

Below, I show you how I am inserting the kernel module + how I am able to
have it working with igb (no realtime) and rt_fec (different driver for the
other Ethernet controller on the same board).

What can I do to solve this issue?
Is there anything else I can try to give you more data?

Thanks for your help,

Yann

########################
# System configuration #
########################
ARM cortexa9t2hf, quad core, 32bits.
Custom board inspired from an i.MX6Q SABRE Lite.
Two Ethernet controllers: Freescale FEC + Intel I210 on the PCIe bus.
Kernel: Freescale/linux-fslc v4.9.67
(https://github.com/Freescale/linux-fslc/tree/953c6e30c9701fda69ef08e2476c5=
41dc4fb1453)
Xenomai: v3.0.9 and/or v3.0.12 (same results).
I-pipe: based on ipipe-core-4.9.51-arm-4.patch. It is slightly different
        for gpc.c to applied on Freescale/linux-fslc v4.9.67.
/proc/cmdline does not seem relevant:
    "console=3Dttymxc1,115200 earlyprintk=3Dserial,ttymxc1,115200
    root=3DPARTUUID=3D0002973b-03 rootwait ro ldo_active=3Don
    video=3Dmxcfb0:dev=3Dhdmi,if=3DRGB24,bpp=3D32"

#####################################################################
# Wireshark trace when 10.0.0.1 (rtnet + rt_igb) tries to ping      #
# 10.0.0.10 (Windows)                                               #
# Note: there is no traffic when 10.0.0.1 does not do the rtping    #
#       all the trace is generated during the rtping (some seconds) #
#####################################################################

No.     Time           Source                Destination           Protocol=
 Length Info
      1 0.000000000    00.00.00              00.00.00              FC      =
 98     Unknown frame
      2 5.000397000    39.15.80              00.00.00              FC      =
 98     Unknown frame
      3 6.000411000    80:e3:f5:a8:88:e3     61:bf:b8:f1:61:bf     0xf5a8  =
 98     Ethernet II
      4 12.000545000   1e:14:21:27:1e:14     XagylCom_14:11:27     0x3127  =
 98     Ethernet II
      5 13.000501000   01:d8:fb:4f:01:dc     fb:4f:01:ec:fb:4f     0xfb4f  =
 98     Ethernet II
      6 15.000537000   ImcNetwo_05:5c:ed     7a:e5:38:39:81:00     0x4358  =
 98     Ethernet II
      7 16.000589000   05:4f:6e:65:49:46     Nadatel_64:09:00      LLC     =
 98     U F, func=3DUA; DSAP 0x6c Group, SSAP 0x64 Response
      8 17.000552000   ad:00:07:74:69:6d     69:64:05:00:00:03     0x656f  =
 98     Ethernet II

#################################################
# /proc/xenomai/irq after performing the rtping #
#################################################

# cat /proc/xenomai/irq
  IRQ       CPU0        CPU1        CPU2        CPU3
   16:    865166      741239     1388290     2146141         [timer/0]
  301:         0           0           0           0         rteth0
 1032:         0           0           0           0         [sync]
 1033:         0           1           1           1         [timer-ipi]
 1034:         0           1           2           1         [reschedule]
 1035:         0           0           0           0         [virtual]
 1039:         1           0          31           0         [virtual]

######################################################################
# Interruptions are well bound to rt_igb. I insured that igb was not #
# loaded at boot time.                                               #
######################################################################

# ls /sys/bus/pci/drivers/rt_igb/
0000:01:00.0  bind  module  new_id  remove_id  uevent  unbind

##################################
# Inserting the module:          #
# rtnet + rt_igb, *not* working  #
##################################

# modprobe rt_igb
    *** RTnet for Xenomai v3.0.9 ***
    RTnet: initialising real-time networking
    rt_igb: Intel(R) Gigabit Ethernet Network Driver - version 5.2.18-k
    rt_igb: Copyright (c) 2007-2014 Intel Corporation.
    rt_igb 0000:01:00.0: enabling device (0140 -> 0142)
    RTnet: registered rteth0
    rt_igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection
    rt_igb 0000:01:00.0: rteth0: (PCIe:2.5Gb/s:Width x1) 00:50:64:00:d5:10
    rt_igb 0000:01:00.0: rteth0: PBA No: FFFFFF-0FF
    rt_igb 0000:01:00.0: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)
# modprobe rtudp
# modprobe rtpacket
# lsmod
    Module                  Size  Used by
    rtpacket                9111  0
    rtudp                  14160  0
    rtipv4                 31184  1 rtudp
    rt_igb                 84337  0
    rtnet                  52246  4 rt_igb,rtipv4,rtpacket,rtudp
    (fec                    40019  0) <-- Other NIC (see below)
# rtifconfig rteth0 up 10.0.0.1
    rt_igb: rteth0: igb: rteth0 NIC Link is Up 100 Mbps Full Duplex,
	                                             Flow Control: RX/TX
# rtroute add 10.0.0.10 FF:FF:FF:FF:FF:FF dev rteth0
# rtping 10.0.0.10
    Real-time PING 10.0.0.10 56(84) bytes of data.
    ... (*not* working) ^C
    --- 10.0.0.10 rtping statistics ---
    5 packets transmitted, 0 received, 100% packet loss
    worst case rtt =3D 0.0 us


#############################################
# Inserting the module:                     #
# igb (no rt), same Xenomai kernel, working #
#############################################

# modprobe igb
    igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
    igb: Copyright (c) 2007-2014 Intel Corporation.
    igb 0000:01:00.0: enabling device (0140 -> 0142)
    pps pps1: new PPS source ptp1
    igb 0000:01:00.0: added PHC on eth1
    igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection
    igb 0000:01:00.0: eth1: (PCIe:2.5Gb/s:Width x1) 00:50:64:00:d5:10
    igb 0000:01:00.0: eth1: PBA No: FFFFFF-0FF
    igb 0000:01:00.0: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)
# lsmod
    Module                  Size  Used by
    igb                   145781  0
    (fec                    40019  0) <-- Other NIC (see below)
# ifconfig eth1 up 10.0.0.1
    IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
    8021q: adding VLAN 0 to HW filter on device eth1
    igb 0000:01:00.0 eth1: igb: eth1 NIC Link is Up 100 Mbps Full Duplex,
	                                                  Flow Control: RX/TX
    IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
# ping 10.0.0.10
    ... (working)


########################################################
# Inserting the module:                                #
# rtnet + rt_fec (second Ethernet controller), working #
########################################################

# modprobe rt_fec
    ...
    RTnet: registered rteth0
# modprobe rtudp
# modprobe rtpacket
# lsmod
    Module                  Size  Used by
    rtpacket                9111  0
    rtudp                  14160  0
    rtipv4                 31184  1 rtudp
    rt_fec                 15832  1
    rtnet                  52182  4 rtipv4,rtpacket,rt_fec,rtudp
# rtifconfig rteth0 up 10.0.0.1
    Generic PHY 2188000.ethernet-1:10: attached PHY driver [Generic PHY]
	                    (mii_bus:phy_addr=3D2188000.ethernet-1:10, irq=3D-1)
# rtroute add 10.0.0.10 FF:FF:FF:FF:FF:FF dev rteth0
# rtping 10.0.0.10
    ... (working)

