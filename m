Date: Mon, 12 Mar 2018 14:12:59 +0200 (EET)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <418219368.3538777.1520856779293.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <392996706.2572717.1520342577614.JavaMail.zimbra@triolcorp.com.ua>
References: <392996706.2572717.1520342577614.JavaMail.zimbra@triolcorp.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rtnet no eth 0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>

is there a way to debug my installation ?

i do
1)add rtnet in menuconfig  and add driver  8169
2)remove r8169

yeti@yeti-UDOO-x86:/usr/xenomai/sbin$ sudo ./rtnet  start
sh: echo: I/O error
ioctl: No such device
./rtnet: 193: ./rtnet: cannot open : No such file
vnic0: ERROR while getting interface flags: No such device
SIOCSIFADDR: No such device
vnic0: ERROR while getting interface flags: No such device
SIOCSIFNETMASK: No such device
Waiting for all slaves...ioctl: No such device
ioctl: No such device

yeti@yeti-UDOO-x86:/usr/xenomai/sbin$ lsmod|grep rt
rtmac                  20480  1 tdma
rtcfg                  45056  0
rtpacket               20480  0
rtudp                  24576  0
rt_r8169               24576  0
rtipv4                 32768  2 rtudp,rtcfg
rtnet                  65536  7 rtipv4,rtmac,rt_r8169,rtpacket,rtudp,rtcfg,=
tdma


yeti@yeti-UDOO-x86:/usr/xenomai/sbin$ lspci -knn |grep Ethernet

02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111=
/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 0c)
=09Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express=
 Gigabit Ethernet Controller [10ec:0123]
=09Kernel modules: r8169
yeti@yeti-UDOO-x86:/usr/xenomai/sbin$ sudo rmmod r8169
rmmod: ERROR: Module r8169 is not currently loaded

yeti@yeti-UDOO-x86:/usr/xenomai/sbin$ ./version=20
Xenomai/cobalt v3.0.6 -- #0246d22 (2018-03-10 10:52:53 +0100)

rtnet conf

RT_DRIVER=3D"rt_r8169"
RT_DRIVER_OPTIONS=3D""
REBIND_RT_NICS=3D"0000:02:00.0"

IPADDR=3D"192.168.161.45"
NETMASK=3D"255.255.255.128"
RT_LOOPBACK=3D"no"
RT_PROTOCOLS=3D"udp packet"
RTCAP=3D"no"


----- Original Message -----
From: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: "xenomai" <xenomai@xenomai.org>
Sent: Tuesday, March 6, 2018 3:22:57 PM
Subject: [Xenomai] rtnet no eth0

Good day!=20
I need help to run rtnet on my nic=20

i remove r8169 module and follow this https://xenomai.org/rtnet-installatio=
n/=20

looback test are working=20

some outputs below (could it be a problem by default there is not eth0 inte=
rface it s name enp2s0 ?)=20

what should i do ?=20

sudo ./rtnet -v start=20
[sudo] password for yeti:=20
Turning on verbose mode=20
sh: echo: I/O error=20
/usr/xenomai/sbin/rtifconfig rtlo up 127.0.0.1=20
/usr/xenomai/sbin/rtcfg rteth0 server=20
ioctl: No such device=20
/usr/xenomai/sbin/rtifconfig rteth0 up 192.168.161.45 netmask 255.255.255.0=
=20
ioctl: No such device=20
/usr/xenomai/sbin/tdmacfg rteth0 master 5000=20
ioctl: No such device=20
/usr/xenomai/sbin/tdmacfg rteth0 slot 0 0=20
ioctl: No such device=20
/usr/xenomai/sbin/rtcfg rteth0 add 192.168.161.22 -stage1 -=20
ioctl (add): No such device=20
vnic0: ERROR while getting interface flags: No such device=20
SIOCSIFADDR: No such device=20
vnic0: ERROR while getting interface flags: No such device=20
SIOCSIFNETMASK: No such device=20
Waiting for all slaves.../usr/xenomai/sbin/rtcfg rteth0 wait=20
ioctl: No such device=20
/usr/xenomai/sbin/rtcfg rteth0 ready=20
ioctl: No such device=20

//-------------------------------------------------=20
@yeti-UDOO-x86:/usr/xenomai/sbin$ sudo ./rtifconfig=20
rtlo Medium: Local Loopback=20
IP address: 127.0.0.1=20
UP LOOPBACK RUNNING MTU: 1500=20
//-------------------------------------------------=20
Some string from conf file=20

RT_DRIVER=3D"rt_r8169"=20
RT_DRIVER_OPTIONS=3D""=20
REBIND_RT_NICS=3D"0000:02:00.0"=20
IPADDR=3D"192.168.161.45"=20
NETMASK=3D"255.255.255.0"=20
TDMA_SLAVES=3D"192.168.161.22"=20
//-------------------------------------------------=20
yeti@yeti-UDOO-x86:~$ lspci=20
.....=20
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8=
411 PCI Express Gigabit Ethernet Controller (rev 0c)=20

//-------------------------------------------------=20

yeti@yeti-UDOO-x86:~$ lsmod=20
Module Size Used by=20
tdma 28672 0=20
rtmac 20480 1 tdma=20
rtcfg 45056 0=20
rt_loopback 16384 1=20
rtpacket 16384 0=20
rtudp 24576 0=20
rt_r8169 24576 0=20
rtipv4 32768 2 rtudp,rtcfg=20
rtnet 57344 8 rtipv4,rt_loopback,rtmac,rt_r8169,rtpacket,rtudp,rtcfg,tdma=
=20

//-------------------------------------------------=20


=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,=20
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.=20
_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

