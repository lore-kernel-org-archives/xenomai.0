Date: Thu, 24 Mar 2022 16:27:11 +0100 (CET)
From: Paal Tamas <paal_to@freemail.hu>
Subject: Re: RTNET setup issue
In-Reply-To: <ebcd8b0a4e16f4a41728f96ce589452f1e021e7c.camel@siemens.com>
Message-ID: <freemail.20220324162711.86768.1@fmxmldata10.freemail.hu>
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
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=20
"Bezdeka, Florian" <florian.bezdeka@siemens.com> =C3=ADrta:
>On Wed, 2022-03-23 at 16:02 +0100, Paal Tamas via Xenomai wrote:
>> =20
>> Paal Tamas via Xenomai <xenomai@xenomai.org> =C3=ADrta:
>> >=20
>> > "Fran=C3=A7ois Legal" <devel@thom.fr.eu.org> =C3=ADrta:
>> > > Le Mercredi, Mars 23, 2022 14:07 CET, Paal Tamas <paal_to@freemail.h=
u> a =C3=A9crit:
>> > >=20
>> > > >=20
>> > > > "Fran=C3=A7ois Legal" <devel@thom.fr.eu.org> =C3=ADrta:
>> > > > > Le Mercredi, Mars 23, 2022 10:48 CET, Paal Tamas via Xenomai <xe=
nomai@xenomai.org> a =C3=A9crit:
>> > > > >=20
>> > > > > > Dear All,   I am trying to set up RTNET using the latest xenom=
ai_3.2.1 on an x86_64 system. I need only the raw packet (e.g rtpacket laye=
r). I tried a lot of things but I still got errors like:  ioctl: Inappropri=
ate ioctl for device    I try to use this PCI device:
>> > > > > > 01:00.0 Ethernet controller: Intel Corporation 82576 Gigabit N=
etwork Connection (rev 01)
>> > > > > >     Subsystem: Intel Corporation Gigabit ET Dual Port Server A=
dapter
>> > > > > >     Kernel driver in use: rt_igb
>> > > > > >     Kernel modules: igb, rt_igb   What I do is: ifconfig enp1s=
0f0 down
>> > > > > > ifconfig enp1s0f1 down
>> > > > > > rmmod igbmodprobe rtnet
>> > > > > > modprobe rtpacket
>> > > > > > modprobe rt_igb
>> > > > > > modprobe rtipv4
>> > > > > > modprobe rtudp  set up the rtnet.conf file and start rtnet: /u=
sr/xenomai/sbin$ sudo ./rtnet start
>> > > > > > ioctl: Inappropriate ioctl for device
>> > > > > > ioctl: Inappropriate ioctl for device
>> > > > > > ioctl: Inappropriate ioctl for device
>> > > > > > Stage 1: searching for master...ioctl: Inappropriate ioctl for=
 deviceStage 2: waiting for other slaves...
>> > > > > > Stage 3: waiting for common setup completion...ioctl: Inapprop=
riate ioctl for deviceclickandmove@clickandmove-desktop:/usr/xenomai/sbin$ =
sudo /usr/xenomai/sbin/rtifconfig -a
>> > > > > > ioctl: Inappropriate ioctl for device   The kernel log:  [   5=
0.360253] igb 0000:01:00.1: removed PHC on enp1s0f1
>> > > > > > [   50.553797] igb 0000:01:00.0: removed PHC on enp1s0f0
>> > > > > > [   81.769798] RTnet: registered rteth0
>> > > > > > [   81.769802] rt_igb 0000:01:00.0: Intel(R) Gigabit Ethernet =
Network Connection
>> > > > > > [   81.769804] rt_igb 0000:01:00.0: rteth0: (PCIe:2.5Gb/s:Widt=
h x1) 6c:b3:11:56:2e:32
>> > > > > > [   81.769807] rt_igb 0000:01:00.0: rteth0: PBA No: Unknown
>> > > > > > [   81.769808] rt_igb 0000:01:00.0: Using MSI-X interrupts. 1 =
rx queue(s), 1 tx queue(s)
>> > > > > > [   81.777139] rt_loopback: initializing loopback interface...
>> > > > > > [   81.777315] RTnet: registered rtlo
>> > > > > > [   81.787311] RTcfg: init real-time configuration distributio=
n protocol
>> > > > > > [   81.793326] RTmac: init realtime media access control
>> > > > > > [   81.800424] RTmac/TDMA: init time division multiple access =
control mechanism   Even rtifconfig returns the same error  /usr/xenomai/sb=
in/rtifconfig -aioctl: Inappropriate ioctl for device   What am I doing wro=
ng? Thank you,Tamas
>> > > > > >=20
>> > > > >=20
>> > > > > Hello,
>> > > > >=20
>> > > > > what makes you think it does not work ? Using the rtnet script, =
you&#39;re trying to configure rtmac & rtcfg which you stated are not neces=
sary for your setup.
>> > > > >=20
>> > > > > Have you tried only rtifconfig rteth* up and checked the Tx/Rx c=
ounters displayed there ?
>> > > > >=20
>> > > > > Fran=C3=A7ois
>> > > >=20
>> > > > > Hello,  The "rtifconfig rteth0 up" command returns the  "ioctl: =
Inappropriate ioctl for device" error too. That&#39;s why I think something=
 is wrong. Thank you,Tamas
>> > >=20
>> > > Alright,
>> > >=20
>> > > then you might want to take a look at the source code of the e1000 d=
river to verify that your device is supported by the xenomai release your u=
sing (you should find the PCI dev/prod id in some header file)
>> > >=20
>> > > Fran=C3=A7ois
>> > >=20
>> >=20
>> > > Yes. The first lines of the /igb/e1000hw.h file mentions the 82576 d=
evice:
>> >=20
>> > >=20
>> >=20
>> > > #define E1000_DEV_ID_82576            0x10C9
>> > > #define E1000_DEV_ID_82576_FIBER        0x10E6
>> > > #define E1000_DEV_ID_82576_SERDES        0x10E7
>> > > #define E1000_DEV_ID_82576_QUAD_COPPER        0x10E8
>> > > #define E1000_DEV_ID_82576_QUAD_COPPER_ET2    0x1526
>> > > #define E1000_DEV_ID_82576_NS            0x150A
>> > > #define E1000_DEV_ID_82576_NS_SERDES        0x1518
>> > > #define E1000_DEV_ID_82576_SERDES_QUAD        0x150D
>> > The kernel log above shows that the driver has been succesfully loaded=
 and binded.What I suspect to be the cause of the problem is my "setup". I =
have a 64bit kernel and compiled the userspace to be 32bit mode (using -m32=
 compiler switch), because I have 32bit application that need to work under=
 Xenomai. This is a legal case. Everything else is working fine. Only RTNET=
 has issues. It is not impossible that the 64bit RTNET kernel layer is not =
"compatible" with 32bit userland. I saw some issues like this on the mailin=
g list for the CAN interface too a few month ago.I try to create 64bit user=
space and give RTNET a try there. This is not a solution for me, because I =
need 32bit userspace, but can bring closer to the solution of this issue.
>>=20
>
>That might be a compat issue again. Maybe the rtnet ioctl syscall is
>not properly handled in compat mode (32 bit app on 64 bit kernel)
>
>You might want to check if all affected code paths deal with different
>type sizes (eg. sizeof(long) is different between kernel and
>application) accordingly.
>
>> >=20
>>=20
>> >=20
>>=20
>> > OK. I rebuilt the userspace to 64bit. Now RTNET works as expected.
>>=20
>> > The question is how to make RTNET to work, when the userspace is confi=
gured like this:
>>=20
>> > /configure --with-core=3Dcobalt --enable-smp --enable-pshared \
>> >  --host=3Di686-linux CFLAGS=3D"-m32 -D_FILE_OFFSET_BITS=3D64" \
>> >  LDFLAGS=3D-m32 host_alias=3Di686-linux
>>=20
>> >=20
>>=20
>> > Thank you,
>>=20
>> > Tamas
>=20

>I started the debug session using the rtifconfig.c file, since the rtifcon=
fig command "fails fine". I added some trace to the rtifconfig.c (into the =
do_display() function) and rtnet_chrdev.c (into the rtnet_core_ioctl() func=
tion) files. In "all 64bit mode", when RTNET works as expected I see the fo=
llowings in the user mode console and kernel trace:

>do_display enter
>do_display: IOC_RT_IFINFO=3D0xc0500082, sizeof(rtnet_core_cmd)=3D80 [   36=
.616917] rtnet_core_ioctl: request=3D0xc0500082,sizeof(rtnet_core_cmd)=3D80
>[   36.616919] rtnet_core_ioctl: IOC_RT_IFINFO decoded This means the ioct=
l() call hit the target succesfully. When I compile the userland to 32bit t=
he user mode trace is the following: do_display enter
>do_display: IOC_RT_IFINFO=3D0xc0500082, sizeof(rtnet_core_cmd)=3D80
>do_display: ret=3D-1
>ioctl: Inappropriate ioctl for device but nothing appears in the kernel tr=
ace. This means to me that the ioctl() call did not reach the rtnet_core_io=
ctl() funtion, rather failed somewhere in between the userspace and that ke=
rnel function call. I need some help here. I need to add more traces to the=
 system, to find the place where the ioctl() call hits the wall. When the d=
o_display() function of rtifconfig.c calls ioctl(), where can I find that c=
ertain ioctl() function? I am lost in the jungle of macros...=20
