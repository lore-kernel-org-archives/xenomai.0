From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <freemail.20220323140747.6187.1@fmxmldata10.freemail.hu>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 23 Mar 2022 14:37:28 +0100
MIME-Version: 1.0
Message-ID: <d01-623b2280-33-400dfa00@254400388>
Subject: =?utf-8?q?Re=3A?= RTNET setup issue
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paal Tamas <paal_to@freemail.hu>
Cc: xenomai@xenomai.org

Le Mercredi, Mars 23, 2022 14:07 CET, Paal Tamas <paal=5Fto@freemail.hu=
> a =C3=A9crit: 
 
>  
> "Fran=C3=A7ois Legal" <devel@thom.fr.eu.org> =C3=ADrta:
> >Le Mercredi, Mars 23, 2022 10:48 CET, Paal Tamas via Xenomai <xenoma=
i@xenomai.org> a =C3=A9crit:
> >
> >> Dear All,   I am trying to set up RTNET using the latest xenomai=5F=
3.2.1 on an x86=5F64 system. I need only the raw packet (e.g rtpacket l=
ayer). I tried a lot of things but I still got errors like:  ioctl: Ina=
ppropriate ioctl for device    I try to use this PCI device:
> >> 01:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Netwo=
rk Connection (rev 01)
> >>     Subsystem: Intel Corporation Gigabit ET Dual Port Server Adapt=
er
> >>     Kernel driver in use: rt=5Figb
> >>     Kernel modules: igb, rt=5Figb   What I do is: ifconfig enp1s0f=
0 down
> >> ifconfig enp1s0f1 down
> >> rmmod igbmodprobe rtnet
> >> modprobe rtpacket
> >> modprobe rt=5Figb
> >> modprobe rtipv4
> >> modprobe rtudp  set up the rtnet.conf file and start rtnet: /usr/x=
enomai/sbin$ sudo ./rtnet start
> >> ioctl: Inappropriate ioctl for device
> >> ioctl: Inappropriate ioctl for device
> >> ioctl: Inappropriate ioctl for device
> >> Stage 1: searching for master...ioctl: Inappropriate ioctl for dev=
iceStage 2: waiting for other slaves...
> >> Stage 3: waiting for common setup completion...ioctl: Inappropriat=
e ioctl for deviceclickandmove@clickandmove-desktop:/usr/xenomai/sbin$ =
sudo /usr/xenomai/sbin/rtifconfig -a
> >> ioctl: Inappropriate ioctl for device   The kernel log:  [   50.36=
0253] igb 0000:01:00.1: removed PHC on enp1s0f1
> >> [   50.553797] igb 0000:01:00.0: removed PHC on enp1s0f0
> >> [   81.769798] RTnet: registered rteth0
> >> [   81.769802] rt=5Figb 0000:01:00.0: Intel(R) Gigabit Ethernet Ne=
twork Connection
> >> [   81.769804] rt=5Figb 0000:01:00.0: rteth0: (PCIe:2.5Gb/s:Width =
x1) 6c:b3:11:56:2e:32
> >> [   81.769807] rt=5Figb 0000:01:00.0: rteth0: PBA No: Unknown
> >> [   81.769808] rt=5Figb 0000:01:00.0: Using MSI-X interrupts. 1 rx=
 queue(s), 1 tx queue(s)
> >> [   81.777139] rt=5Floopback: initializing loopback interface...
> >> [   81.777315] RTnet: registered rtlo
> >> [   81.787311] RTcfg: init real-time configuration distribution pr=
otocol
> >> [   81.793326] RTmac: init realtime media access control
> >> [   81.800424] RTmac/TDMA: init time division multiple access cont=
rol mechanism   Even rtifconfig returns the same error  /usr/xenomai/sb=
in/rtifconfig -aioctl: Inappropriate ioctl for device   What am I doing=
 wrong? Thank you,Tamas
> >>
> >
> > Hello,
> >
> >what makes you think it does not work ? Using the rtnet script, you&=
#39;re trying to configure rtmac & rtcfg which you stated are not neces=
sary for your setup.
> >
> >Have you tried only rtifconfig rteth* up and checked the Tx/Rx count=
ers displayed there ?
> >
> >Fran=C3=A7ois
> 
> >Hello,  The "rtifconfig rteth0 up" command returns the  "ioctl: Inap=
propriate ioctl for device" error too. That&#39;s why I think something=
 is wrong. Thank you,Tamas
 
 Alright,

then you might want to take a look at the source code of the e1000 driv=
er to verify that your device is supported by the xenomai release your =
using (you should find the PCI dev/prod id in some header file)

Fran=C3=A7ois


