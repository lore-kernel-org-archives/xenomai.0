Date: Mon, 23 Apr 2018 19:04:47 +0300 (EEST)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <1642298442.1503775.1524499487765.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <851775446.1465587.1524492953412.JavaMail.zimbra@triolcorp.com.ua>
References: <392996706.2572717.1520342577614.JavaMail.zimbra@triolcorp.com.ua>
 <418219368.3538777.1520856779293.JavaMail.zimbra@triolcorp.com.ua>
 <7d55cdd0-8406-9329-c785-d79f201a5f3f@siemens.com>
 <322085351.3653612.1520865874504.JavaMail.zimbra@triolcorp.com.ua>
 <b3a5f9fe-6e47-8c49-6d51-78f6cac76e56@siemens.com>
 <257460350.4129277.1520954576297.JavaMail.zimbra@triolcorp.com.ua>
 <851775446.1465587.1524492953412.JavaMail.zimbra@triolcorp.com.ua>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: Olej <o.tsiliuric@yandex.ru>, xenomai <xenomai@xenomai.org>

UPD
After all  I replace rt-r8169.ko in /usr/lib/modules ....  with my module
and now it

yeti@yeti-UDOO-x86:/usr/xenomai/sbin$ sudo ./rtnet -v start
Turning on verbose mode
/usr/xenomai/sbin/rtifconfig rtlo up 127.0.0.1
/usr/xenomai/sbin/rtcfg rteth0 server
/usr/xenomai/sbin/rtifconfig rteth0 up 192.168.161.45 netmask 255.255.255.1=
28
/usr/xenomai/sbin/tdmacfg rteth0 master 5000
/usr/xenomai/sbin/tdmacfg rteth0 slot 0 0
/usr/xenomai/sbin/rtcfg rteth0 add 192.168.161.22 -stage1 -
Waiting for all slaves.../usr/xenomai/sbin/rtcfg rteth0 wait
/usr/xenomai/sbin/rtcfg rteth0 ready

yeti@yeti-UDOO-x86:/usr/xenomai/sbin$ sudo ./rtifconfig=20
[sudo] password for yeti:=20
rteth0    Medium: Ethernet  Hardware address: 00:C0:08:92:44:62
          IP address: 192.168.161.45  Broadcast address: 192.168.161.127
          UP BROADCAST RUNNING  MTU: 1500
          RX packets:90 errors:0 dropped:0 overruns:0 frame:0
          TX packets:56696 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0=20
          RX bytes:8961 (8.7 Kb)  TX bytes:2395984 (2.2 Mb)

rtlo      Medium: Local Loopback
          IP address: 127.0.0.1 =20
          UP LOOPBACK RUNNING  MTU: 1500

is it all correct ?
there is errors in logs, chipset version not writing yet
I can share code with any who are interested in
Lets comlete it together !! ))

[11123.726792] RTL8168g/8111g at 0xffffb3c7814fd000, 00:c0:08:92:44:62, XID=
 0c000880 IRQ 18
[11123.726795] jumbo features [frames: 9200 bytes, tx checksumming: ko]
[11123.776142] initializing loopback...
[11123.776167] RTnet: registered rtlo
[11123.841079] RTcfg: init real-time configuration distribution protocol
[11123.887878] RTmac: init realtime media access control
[11123.928428] RTmac/TDMA: init time division multiple access control mecha=
nism
[11123.948347] rt_r8169: rteth0: unknown chipset (mac_version =3D 39).
[11123.948390] link down
[11123.948393] link down
[11123.999195] ModemManager[517]: segfault at 0 ip 0000000000431ab3 sp 0000=
7ffcc63525a0 error 4 in ModemManager[400000+103000]
[11126.462763] link up


----- Original Message -----
From: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
To: "Jan Kiszka" <jan.kiszka@siemens.com>, "Greg Gallagher" <greg@embeddedg=
reg.com>
Cc: "Olej" <o.tsiliuric@yandex.ru>, "xenomai" <xenomai@xenomai.org>
Sent: =CF=EE=ED=E5=E4=E5=EB=FC=ED=E8=EA, 23 =C0=EF=F0=E5=EB=FC 2018 =E3 17:=
15:53
Subject: Re: [Xenomai] rtnet no eth 0

Good day!

once more
I make some changes to rtnet r8169 driver  based on    https://xenomai.org/=
pipermail/xenomai/2015-June/034450.html
Now I can succsesfully compile it=20

but after .rtnet start to a system i get=20

yeti@yeti-UDOO-x86:/usr/xenomai/sbin$ sudo ./rtnet -v start
Turning on verbose mode
sh: echo: I/O error
/usr/xenomai/sbin/rtifconfig rtlo up 127.0.0.1
/usr/xenomai/sbin/rtcfg rteth0 server
ioctl: No such device
/usr/xenomai/sbin/rtifconfig rteth0 up 192.168.161.45 netmask 255.255.255.1=
28
ioctl: No such device
/usr/xenomai/sbin/tdmacfg rteth0 master 5000
ioctl: No such device
/usr/xenomai/sbin/tdmacfg rteth0 slot 0 0
ioctl: No such device
/usr/xenomai/sbin/rtcfg rteth0 add 192.168.161.22 -stage1 -
ioctl (add): No such device
vnic0: ERROR while getting interface flags: No such device
SIOCSIFADDR: No such device
vnic0: ERROR while getting interface flags: No such device
SIOCSIFNETMASK: No such device
Waiting for all slaves.../usr/xenomai/sbin/rtcfg rteth0 wait
ioctl: No such device
/usr/xenomai/sbin/rtcfg rteth0 ready
ioctl: No such device

yeti@yeti-UDOO-x86:/usr/xenomai/sbin$ lsmod
Module                  Size  Used by
tdma                   18473  0
rtmac                   9847  1 tdma
rtcfg                  38110  0
rt_loopback             1467  1
rtpacket                8552  0
rtudp                  12886  0
rt_r8169               14344  0
rtipv4                 25411  2 rtudp,rtcfg
rtnet                  56300  8 rtipv4,rt_loopback,rtmac,rt_r8169,rtpacket,=
rtudp,rtcfg,tdma

logs
              *** RTnet for Xenomai v3.0.6 ***

[ 4842.022029] RTnet: initialising real-time networking
[ 5308.564289] Initializing rt_r8169 driver
[ 5308.615741] initializing loopback...
[ 5308.615765] RTnet: registered rtlo
[ 5308.681555] RTcfg: init real-time configuration distribution protocol
[ 5308.727633] RTmac: init realtime media access control
[ 5308.767365] RTmac/TDMA: init time division multiple access control mecha=
nism


if I insmod manually my module

[ 5505.043230] rt_r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[ 5505.044057] rt_r8169 0000:02:00.0: can't disable ASPM; OS doesn't have A=
SPM control
[ 5505.044433] RTnet: registered enp2s0
[ 5505.044444] RTL8168g/8111g at 0xffffb3c78153d000, 00:c0:08:92:44:62, XID=
 0c000880 IRQ 18
[ 5505.044446] jumbo features [frames: 9200 bytes, tx checksumming: ko]

it seems to me that need to change work with rteth0   -> enp2s0  in all rtn=
et files  How I can do that ?




----- Original Message -----
From: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: "xenomai" <xenomai@xenomai.org>
Sent: =C2=F2=EE=F0=ED=E8=EA, 13 =CC=E0=F0=F2 2018 =E3 17:22:56
Subject: Re: [Xenomai] rtnet no eth 0

part of https://github.com/G-Ray/xenomai-boneblack-rtnet-drivers/blob/maste=
r/r8169.c

static struct pci_device_id rtl8169_pci_tbl[] =3D {
=09{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,=090x8136), 0, 0, 2 },
=09{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,=090x8167), 0, 0, 1 },
=09{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,=090x8169), 0, 0, 1 },
=09{ PCI_DEVICE(PCI_VENDOR_ID_DLINK,=090x4300), 0, 0, 1 },=09/* <kk> D-Link=
 DGE-528T */
=09{0,},
};
 I think first changes should be there to support  product: RTL8111/8168/84=
11 PCI Express Gigabit Ethernet Controll

----- Original Message -----
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
Cc: "xenomai" <xenomai@xenomai.org>
Sent: Monday, March 12, 2018 4:49:29 PM
Subject: Re: [Xenomai] rtnet no eth 0

On 2018-03-12 07:44, =D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=
=EE=F0=FC=E5=E2=E8=F7 wrote:
> Ok,=20
> could you describe in few words  - how to do that ?

Diff the RTnet driver against the corresponding upstream driver, look
for deviating patterns that are not RTnet related.

Also, check in the upstream history how support for the device type 8168
came in, via which commits. Maybe porting them over is enough, maybe
it's just the ID that is missing.

Jan

>=20
> =D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=
=EE=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
> =D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.
>=20
> ----- Original Message -----
> From: "Jan Kiszka" <jan.kiszka@siemens.com>
> To: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
> Cc: "xenomai" <xenomai@xenomai.org>
> Sent: Monday, March 12, 2018 4:24:08 PM
> Subject: Re: [Xenomai] rtnet no eth 0
>=20
> On 2018-03-12 05:12, =D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=
=E3=EE=F0=FC=E5=E2=E8=F7 wrote:
>> is there a way to debug my installation ?
>>
>> i do
>> 1)add rtnet in menuconfig  and add driver  8169
>> 2)remove r8169
>>
>> yeti@yeti-UDOO-x86:/usr/xenomai/sbin$ sudo ./rtnet  start
>> sh: echo: I/O error
>> ioctl: No such device
>> ./rtnet: 193: ./rtnet: cannot open : No such file
>> vnic0: ERROR while getting interface flags: No such device
>> SIOCSIFADDR: No such device
>> vnic0: ERROR while getting interface flags: No such device
>> SIOCSIFNETMASK: No such device
>> Waiting for all slaves...ioctl: No such device
>> ioctl: No such device
>>
>> yeti@yeti-UDOO-x86:/usr/xenomai/sbin$ lsmod|grep rt
>> rtmac                  20480  1 tdma
>> rtcfg                  45056  0
>> rtpacket               20480  0
>> rtudp                  24576  0
>> rt_r8169               24576  0
>> rtipv4                 32768  2 rtudp,rtcfg
>> rtnet                  65536  7 rtipv4,rtmac,rt_r8169,rtpacket,rtudp,rtc=
fg,tdma
>>
>>
>> yeti@yeti-UDOO-x86:/usr/xenomai/sbin$ lspci -knn |grep Ethernet
>>
>> 02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8=
111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 0c)
>> =09Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Expr=
ess Gigabit Ethernet Controller [10ec:0123]
>> =09Kernel modules: r8169
>> yeti@yeti-UDOO-x86:/usr/xenomai/sbin$ sudo rmmod r8169
>> rmmod: ERROR: Module r8169 is not currently loaded
>=20
> Still, rt_r8169 didn't bind. Maybe our driver doesn't list this card ID
> (i.e. is too old)... and that is the case here (no 8168). You can try
> integrating the state of the current upstream driver /wrt to this new
> device ID into the RTnet variant, but that's not a simple task
>=20
> Jan
>

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

