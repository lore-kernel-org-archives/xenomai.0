Date: Tue, 13 Mar 2018 17:22:56 +0200 (EET)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <257460350.4129277.1520954576297.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <b3a5f9fe-6e47-8c49-6d51-78f6cac76e56@siemens.com>
References: <392996706.2572717.1520342577614.JavaMail.zimbra@triolcorp.com.ua>
 <418219368.3538777.1520856779293.JavaMail.zimbra@triolcorp.com.ua>
 <7d55cdd0-8406-9329-c785-d79f201a5f3f@siemens.com>
 <322085351.3653612.1520865874504.JavaMail.zimbra@triolcorp.com.ua>
 <b3a5f9fe-6e47-8c49-6d51-78f6cac76e56@siemens.com>
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

