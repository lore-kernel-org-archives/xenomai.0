Date: Wed, 23 Mar 2022 15:12:17 +0100 (CET)
From: Paal Tamas <paal_to@freemail.hu>
Subject: Re: RTNET setup issue
In-Reply-To: <d01-623b2280-33-400dfa00@254400388>
Message-ID: <freemail.20220323151217.87269.1@fmxmldata04.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Cc: xenomai@xenomai.org

=20
"Fran=C3=A7ois Legal" <devel@thom.fr.eu.org> =C3=ADrta:
>Le Mercredi, Mars 23, 2022 14:07 CET, Paal Tamas <paal_to@freemail.hu> a =
=C3=A9crit:
>
>>
>> "Fran=C3=A7ois Legal" <devel@thom.fr.eu.org> =C3=ADrta:
>> >Le Mercredi, Mars 23, 2022 10:48 CET, Paal Tamas via Xenomai <xenomai@x=
enomai.org> a =C3=A9crit:
>> >
>> >> Dear All,   I am trying to set up RTNET using the latest xenomai_3.2.=
1 on an x86_64 system. I need only the raw packet (e.g rtpacket layer). I t=
ried a lot of things but I still got errors like:  ioctl: Inappropriate ioc=
tl for device    I try to use this PCI device:
>> >> 01:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network =
Connection (rev 01)
>> >>     Subsystem: Intel Corporation Gigabit ET Dual Port Server Adapter
>> >>     Kernel driver in use: rt_igb
>> >>     Kernel modules: igb, rt_igb   What I do is: ifconfig enp1s0f0 dow=
n
>> >> ifconfig enp1s0f1 down
>> >> rmmod igbmodprobe rtnet
>> >> modprobe rtpacket
>> >> modprobe rt_igb
>> >> modprobe rtipv4
>> >> modprobe rtudp  set up the rtnet.conf file and start rtnet: /usr/xeno=
mai/sbin$ sudo ./rtnet start
>> >> ioctl: Inappropriate ioctl for device
>> >> ioctl: Inappropriate ioctl for device
>> >> ioctl: Inappropriate ioctl for device
>> >> Stage 1: searching for master...ioctl: Inappropriate ioctl for device=
Stage 2: waiting for other slaves...
>> >> Stage 3: waiting for common setup completion...ioctl: Inappropriate i=
octl for deviceclickandmove@clickandmove-desktop:/usr/xenomai/sbin$ sudo /u=
sr/xenomai/sbin/rtifconfig -a
>> >> ioctl: Inappropriate ioctl for device   The kernel log:  [   50.36025=
3] igb 0000:01:00.1: removed PHC on enp1s0f1
>> >> [   50.553797] igb 0000:01:00.0: removed PHC on enp1s0f0
>> >> [   81.769798] RTnet: registered rteth0
>> >> [   81.769802] rt_igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network=
 Connection
>> >> [   81.769804] rt_igb 0000:01:00.0: rteth0: (PCIe:2.5Gb/s:Width x1) 6=
c:b3:11:56:2e:32
>> >> [   81.769807] rt_igb 0000:01:00.0: rteth0: PBA No: Unknown
>> >> [   81.769808] rt_igb 0000:01:00.0: Using MSI-X interrupts. 1 rx queu=
e(s), 1 tx queue(s)
>> >> [   81.777139] rt_loopback: initializing loopback interface...
>> >> [   81.777315] RTnet: registered rtlo
>> >> [   81.787311] RTcfg: init real-time configuration distribution proto=
col
>> >> [   81.793326] RTmac: init realtime media access control
>> >> [   81.800424] RTmac/TDMA: init time division multiple access control=
 mechanism   Even rtifconfig returns the same error  /usr/xenomai/sbin/rtif=
config -aioctl: Inappropriate ioctl for device   What am I doing wrong? Tha=
nk you,Tamas
>> >>
>> >
>> > Hello,
>> >
>> >what makes you think it does not work ? Using the rtnet script, you&#39=
;re trying to configure rtmac & rtcfg which you stated are not necessary fo=
r your setup.
>> >
>> >Have you tried only rtifconfig rteth* up and checked the Tx/Rx counters=
 displayed there ?
>> >
>> >Fran=C3=A7ois
>>
>> >Hello,  The "rtifconfig rteth0 up" command returns the  "ioctl: Inappro=
priate ioctl for device" error too. That&#39;s why I think something is wro=
ng. Thank you,Tamas
>
> Alright,
>
>then you might want to take a look at the source code of the e1000 driver =
to verify that your device is supported by the xenomai release your using (=
you should find the PCI dev/prod id in some header file)
>
>Fran=C3=A7ois
>=20

>Yes. The first lines of the /igb/e1000hw.h file mentions the 82576 device:

>=20

>#define E1000_DEV_ID_82576            0x10C9
>#define E1000_DEV_ID_82576_FIBER        0x10E6
>#define E1000_DEV_ID_82576_SERDES        0x10E7
>#define E1000_DEV_ID_82576_QUAD_COPPER        0x10E8
>#define E1000_DEV_ID_82576_QUAD_COPPER_ET2    0x1526
>#define E1000_DEV_ID_82576_NS            0x150A
>#define E1000_DEV_ID_82576_NS_SERDES        0x1518
>#define E1000_DEV_ID_82576_SERDES_QUAD        0x150D
The kernel log above shows that the driver has been succesfully loaded and =
binded.What I suspect to be the cause of the problem is my "setup". I have =
a 64bit kernel and compiled the userspace to be 32bit mode (using -m32 comp=
iler switch), because I have 32bit application that need to work under Xeno=
mai. This is a legal case. Everything else is working fine. Only RTNET has =
issues. It is not impossible that the 64bit RTNET kernel layer is not "comp=
atible" with 32bit userland. I saw some issues like this on the mailing lis=
t for the CAN interface too a few month ago.I try to create 64bit userspace=
 and give RTNET a try there. This is not a solution for me, because I need =
32bit userspace, but can bring closer to the solution of this issue. 
