From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <freemail.20220323104813.20528.1@fmxmldata10.freemail.hu>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 23 Mar 2022 12:05:24 +0100
MIME-Version: 1.0
Message-ID: <d01-623aff00-2f-400dfa00@254399035>
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

Le Mercredi, Mars 23, 2022 10:48 CET, Paal Tamas via Xenomai <xenomai@x=
enomai.org> a =C3=A9crit: 
 
> Dear All,   I am trying to set up RTNET using the latest xenomai=5F3.=
2.1 on an x86=5F64 system. I need only the raw packet (e.g rtpacket lay=
er). I tried a lot of things but I still got errors like:  ioctl: Inapp=
ropriate ioctl for device    I try to use this PCI device: 
> 01:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network =
Connection (rev 01)
>     Subsystem: Intel Corporation Gigabit ET Dual Port Server Adapter
>     Kernel driver in use: rt=5Figb
>     Kernel modules: igb, rt=5Figb   What I do is: ifconfig enp1s0f0 d=
own
> ifconfig enp1s0f1 down
> rmmod igbmodprobe rtnet
> modprobe rtpacket
> modprobe rt=5Figb
> modprobe rtipv4
> modprobe rtudp  set up the rtnet.conf file and start rtnet: /usr/xeno=
mai/sbin$ sudo ./rtnet start
> ioctl: Inappropriate ioctl for device
> ioctl: Inappropriate ioctl for device
> ioctl: Inappropriate ioctl for device
> Stage 1: searching for master...ioctl: Inappropriate ioctl for device=
Stage 2: waiting for other slaves...
> Stage 3: waiting for common setup completion...ioctl: Inappropriate i=
octl for deviceclickandmove@clickandmove-desktop:/usr/xenomai/sbin$ sud=
o /usr/xenomai/sbin/rtifconfig -a
> ioctl: Inappropriate ioctl for device   The kernel log:  [   50.36025=
3] igb 0000:01:00.1: removed PHC on enp1s0f1
> [   50.553797] igb 0000:01:00.0: removed PHC on enp1s0f0
> [   81.769798] RTnet: registered rteth0
> [   81.769802] rt=5Figb 0000:01:00.0: Intel(R) Gigabit Ethernet Netwo=
rk Connection
> [   81.769804] rt=5Figb 0000:01:00.0: rteth0: (PCIe:2.5Gb/s:Width x1)=
 6c:b3:11:56:2e:32
> [   81.769807] rt=5Figb 0000:01:00.0: rteth0: PBA No: Unknown
> [   81.769808] rt=5Figb 0000:01:00.0: Using MSI-X interrupts. 1 rx qu=
eue(s), 1 tx queue(s)
> [   81.777139] rt=5Floopback: initializing loopback interface...
> [   81.777315] RTnet: registered rtlo
> [   81.787311] RTcfg: init real-time configuration distribution proto=
col
> [   81.793326] RTmac: init realtime media access control
> [   81.800424] RTmac/TDMA: init time division multiple access control=
 mechanism   Even rtifconfig returns the same error  /usr/xenomai/sbin/=
rtifconfig -aioctl: Inappropriate ioctl for device   What am I doing wr=
ong? Thank you,Tamas
>  
 
 Hello,

what makes you think it does not work ? Using the rtnet script, you're =
trying to configure rtmac & rtcfg which you stated are not necessary fo=
r your setup.

Have you tried only rtifconfig rteth* up and checked the Tx/Rx counters=
 displayed there ?

Fran=C3=A7ois


