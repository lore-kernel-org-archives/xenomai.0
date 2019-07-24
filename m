MIME-Version: 1.0
References: <CAEmXcAwXBxZp9KcRyMs9J08nLKnwkYn13BuWPKTZ-pb6m95chg@mail.gmail.com>
 <b88d839c-eb9f-8712-eb47-5a5fc12cbf17@siemens.com>
 <CAEmXcAxMWcK1wsTQFJ2uQpJ1yjQiyfhoB5C-O=-bh-FTinNMjg@mail.gmail.com>
 <0fd69e88-c0db-f9ef-c8a1-b5d25afe917f@siemens.com>
 <CAEmXcAw+c-nBfMWRpU4yT_GbczRwwGCk=MFKh-g1F_tzwRytLQ@mail.gmail.com>
 <80b77618-4a1f-5554-1dfd-aa2369b3252f@siemens.com>
 <CAEmXcAzd3P9DkRHVbtvzgB_J52gUtaVd19h8=r-VL4frp0Gm3Q@mail.gmail.com>
 <CAEmXcAyPAnDa2OhQn-JoZo3cY6HN9BtBdtNAr5i0hpQ0UPvpZg@mail.gmail.com>
 <64f13545-b3a8-3c5d-1b0e-b953515f0f12@siemens.com>
In-Reply-To: <64f13545-b3a8-3c5d-1b0e-b953515f0f12@siemens.com>
From: danwe <daniel.wenninger92@gmail.com>
Date: Wed, 24 Jul 2019 10:15:55 +0200
Message-ID: <CAEmXcAw_Qek1jEguriG51MKoosN2QOVuAOHSjkW0j43rinryHA@mail.gmail.com>
Subject: Re: TDMA with RTnet on Xenomai
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

Today I have tried TDMA on rtnet with all the necessary modules/drivers.
Unfortunately I do not see any different output on rtping. It is the same
as before.
This is the output:

# rtping 192.168.127.11
Real-time PING 192.168.127.11 56(84) bytes of data.
64 bytes from 192.168.127.11: icmp_seq=1 time=226.7 us
64 bytes from 192.168.127.11: icmp_seq=2 time=142.2 us
64 bytes from 192.168.127.11: icmp_seq=3 time=151.1 us
64 bytes from 192.168.127.11: icmp_seq=4 time=128.8 us
64 bytes from 192.168.127.11: icmp_seq=5 time=135.1 us
64 bytes from 192.168.127.11: icmp_seq=6 time=122.9 us

--- 192.168.127.11 rtping statistics ---
6 packets transmitted, 6 received, 0% packet loss
worst case rtt = 226.7 us

And this are the modules which are loaded:

# lsmod
Module                  Size  Used by    Tainted: G
tdma                   18805  0
rtcfg                  45592  0
rtmac                   7219  1 tdma
rtudp                   7640  0
rtipv4                 18699  2 rtcfg,rtudp
rtpacket                4179  0
rt_ticpsw              26115  0
rt_davinci_mdio         4570  0
rt_smsc                 2165  0
rtnet                  28479  7
tdma,rtcfg,rtmac,rtudp,rtipv4,rtpacket,rt_ticpsw
omap_rng                4174  0

I would like to ask you if you could take a look at my settings for the
master in rtnet.conf and tdma.conf if everything is correct? For slave I
have just change "master" to "slave". Should I start realtime loopback
device and capturing interface? I do not have started the driver for
realtime loopback device. Is that a problem?

# This file is usually located in <PREFIX>/etc/rtnet.conf

# Please adapt it to your system.

# This configuration file is used with the rtnet script.



# RTnet installation path

prefix="/usr"

exec_prefix="/usr"

RTNET_MOD="/lib/modules/3.8.13-xeno/kernel"

RTIFCONFIG="${exec_prefix}/sbin/rtifconfig"

RTCFG="${exec_prefix}/sbin/rtcfg"

TDMACFG="${exec_prefix}/sbin/tdmacfg"



# Module suffix: ".o" for 2.4 kernels, ".ko" for later versions

MODULE_EXT=".ko"


# RT-NIC driver

RT_DRIVER="rt_eepro100"

RT_DRIVER_OPTIONS=""



# PCI addresses of RT-NICs to claim (format: 0000:00:00.0)

#   If both Linux and RTnet drivers for the same hardware are loaded, this

#   list instructs the start script to rebind the given PCI devices,
detaching

#   from their Linux driver, attaching it to the RT driver above. Example:

#   REBIND_RT_NICS="0000:00:19.0 0000:01:1d.1"

REBIND_RT_NICS=""



# IP address and netmask of this station

#   The TDMA_CONFIG file overrides these parameters for masters and backup

#   masters. Leave blank if you do not use IP addresses or if this station
is

#   intended to retrieve its IP from the master based on its MAC address.

IPADDR="192.168.127.10"

NETMASK=""



# Start realtime loopback device ("yes" or "no")

RT_LOOPBACK="yes"



# Use the following RTnet protocol drivers

RT_PROTOCOLS="udp packet"



# Start capturing interface ("yes" or "no")

RTCAP="no"







# Common RTcfg stage 2 config data (master mode only)

#   The TDMA_CONFIG file overrides this parameter.

STAGE_2_SRC=""



# Stage 2 config data destination file (slave mode only)

STAGE_2_DST=""



# Command to be executed after stage 2 phase (slave mode only)

STAGE_2_CMDS=""



# TDMA mode of the station ("master" or "slave")

#   Start backup masters in slave mode, it will then be switched to master

#   mode automatically during startup.

TDMA_MODE="master"





# Master parameters



# Simple setup: List of TDMA slaves

#TDMA_SLAVES="10.0.0.2 10.0.0.3 10.0.0.4"



# Simple setup: Cycle time in microsecond

#TDMA_CYCLE="5000"



# Simple setup: Offset in microsecond between TDMA slots

#TDMA_OFFSET="200"



# Advanced setup: Config file containing all TDMA station parameters

#   To use this mode, uncomment the following line and disable the

#   three master parameters above (SLAVES, CYCLE, and OFFSET).

TDMA_CONFIG="/etc/tdma.conf"


And here is the tdma.conf: I am only using master with IP 192.168.127.10
and slave with IP 192.168.127.11.

#

# Examplary TDMA configuration file

#



# Primary master



master:

ip 192.168.127.10

cycle 5000

slot 0 0

slot 1 1000





# Backup master

#  Cycle is defined by the primary master



backup-master:

ip 192.168.127.12

backup-offset 200

slot 0 400





# Slave A

#  MAC is unknown, slave will be pre-configured to the given IP



slave:

ip 192.168.127.11

slot 0 2000

slot 1 2200 1/2





# Slave B

#  IP is assigned to the slave via its known MAC address



slave:

ip 192.168.127.13

mac 00:12:34:56:AA:FF

slot 0 2400

slot 1 2200 2/2


Am Di., 23. Juli 2019 um 19:13 Uhr schrieb Jan Kiszka <
jan.kiszka@siemens.com>:

> On 23.07.19 18:09, danwe via Xenomai wrote:
> > Am Di., 23. Juli 2019 um 18:08 Uhr schrieb danwe <
> > daniel.wenninger92@gmail.com>:
> >
> >>
> >>
> >> Am Di., 23. Juli 2019 um 17:38 Uhr schrieb Jan Kiszka <
> >> jan.kiszka@siemens.com>:
> >>
> >>> On 23.07.19 17:32, danwe wrote:
> >>>>
> >>>>
> >>>> Am Di., 23. Juli 2019 um 16:58 Uhr schrieb Jan Kiszka <
> >>> jan.kiszka@siemens.com
> >>>> <mailto:jan.kiszka@siemens.com>>:
> >>>>
> >>>>     On 23.07.19 16:28, danwe wrote:
> >>>>     >     On 22.07.19 17:58, danwe via Xenomai wrote:
> >>>>     >     > Hi,
> >>>>     >     >
> >>>>     >     > I have Xenomai 2 with RTnet on a BeagleBone Black. I ask
> >>> myself how  I
> >>>>     >
> >>>>     >     I cannot tell you in advance if my answers applied to
> version
> >>> 2 as well,
> >>>>     >     probably, but no one is working on that anymore.
> >>>>     >
> >>>>     >     > can run TDMA on BeagleBone Black? Programs like RTping and
> >>> Roundtrip
> >>>>     >     > program are working.
> >>>>     >     >
> >>>>     >     > I have changed the rtnet.conf file so that it will use
> >>> TDMA.conf file.
> >>>>     >     > In TDMA.conf all parameters like IP-address, clock cycle
> >>> and slottime
> >>>>     >     > are determined.
> >>>>     >     > In rtnet file I saw some drivers like rtmac. Do I have to
> >>> load that
> >>>>     >     > driver for using TDMA as it is not loaded yet? Are there
> >>> any other
> >>>>     >     > drivers beside rtudp, rtipv4, rtpacket, rt_ticpsw,
> >>> rt_davinci_mdio,
> >>>>     >     > rt_smsc, rtnet and omap_rng which need to be loaded?
> >>>>     >
> >>>>     >     The RTnet startup scripts should load all necessary stack
> >>> components
> >>>>     for you.
> >>>>     >     rtmac.ko belongs to them, tdma.ko will not load without it.
> In
> >>>>     addition, the
> >>>>     >     scripts will load rtcfg in order to distribute the IP and
> TDMA
> >>>>     configuration
> >>>>     >     from the master to the slaves.
> >>>>     >
> >>>>     >
> >>>>     > I do not have tdma.ko nor rtcfg.ko. Is it possible to copy/paste
> >>> them to my
> >>>>     > sd-card where Xenomai / RTnet is running and load them in the
> >>> RTnet startup
> >>>>     > scripts? Or do they need to be installed during building the
> >>> kernel and
> >>>>     Xenomai
> >>>>     > / RTnet on top? Do you have those files you can give me?
> >>>>     >
> >>>>
> >>>>     If you enable the related kernel features, they are generated as
> >>> part of the
> >>>>     normal kernel build. Watch out for
> >>> CONFIG_XENO_DRIVERS_NET_RTMAC/TDMA/RTCFG.
> >>>>
> >>>> Do you mean in my buildroot folder where I can use the command "make
> >>> menuconfig"
> >>>> and select different kernel build things?
> >>>> I have watched out for this but did not find anything. TDMA and rtcfg
> >>> folder in
> >>>> my compiled buildroot folder existing though. But I don't see any
> >>> tdma.ko or
> >>>> rtcfg.ko files.
> >>>
> >>> Then you need to adjust your kernel config. make menuconfig if
> >>> interactively,
> >>> but I don't know where that result is reused for the next buildroot
> run.
> >>>
> >>
> >> I have searched for the TDMA and rtcfg folder and run the makefile with
> >> make command. It compiled and generated my tdma.ko and rtcfg.ko. Now I
> have
> >> just to copy it on sd-card and run it with my rtnet scripts right? Do
> they
> >> need in specific folders on my sd-card?
> >>
>
> These are just more kernel modules, like those for RTnet (rtnet.ko,
> <driver>.ko)
> that likely already exist - unless those are built-in.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
