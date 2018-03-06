Date: Tue, 6 Mar 2018 15:22:57 +0200 (EET)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <392996706.2572717.1520342577614.JavaMail.zimbra@triolcorp.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] rtnet no eth0
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
