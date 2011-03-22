Message-ID: <COL122-W1673FD60DDA60D713554EBDB40@domain.hid>
Content-Type: multipart/alternative;
	boundary="_eaeabbaa-6d1c-4ee3-8558-17a0e5fc3ad5_"
From: krishna m <krishnamurthyjs@domain.hid>
Date: Tue, 22 Mar 2011 21:25:45 +0530
In-Reply-To: <4D88925C.3040609@domain.hid>
References: <COL122-W1001B88CC08016B1C1774EBDCE0@domain.hid>
	<4D80BA8B.7050803@domain.hid>,<4D81C6AD.8050803@domain.hid>
	<COL122-W637BE46C7D8B2CB7F79760BDB50@domain.hid>,
	<4D88925C.3040609@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] MSI support in Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

--_eaeabbaa-6d1c-4ee3-8558-17a0e5fc3ad5_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> Date: Tue=2C 22 Mar 2011 13:13:16 +0100
> From: jan.kiszka@domain.hid
> To: krishnamurthyjs@domain.hid
> CC: gilles.chanteperdrix@xenomai.org xenomai@xenomai.org
> Subject: Re: MSI support in Xenomai
>=20
> On 2011-03-21 13:48=2C krishna m wrote:
> > > Date: Thu=2C 17 Mar 2011 09:30:37 +0100
> > > From: jan.kiszka@domain.hid
> > > To: gilles.chanteperdrix@xenomai.org krishnamurthyjs@domain.hid
> > > CC: xenomai@xenomai.org
> > > Subject: Re: MSI support in Xenomai
> > >
> > > On 2011-03-16 14:26=2C Gilles Chanteperdrix wrote:
> > > > krishna m wrote:
> > > >> Hi All=2C I wanted to know if the latest Xenomai [Version
> > > >> xenomai-2.5.6] supports MSI interrupts. I am using the adeos Patch
> > > >> [version adeos-ipipe-2.6.37-x86-2.9-00] and corresponding Linux
> > > >> kernel [version: linux-2.6.37]. I have read in the Xenomai FAQ tha=
t
> > > >> MSI is not supported by the ipipe patch just wanted to know if the
> > > >> latest Xenomai and Ipipe supports MSI.
> > > >
> > > > No.
> > >
> > > Strictly spoken=2C but it works in practice. See
> > >
> > > http://thread.gmane.org/gmane.linux.real-time.xenomai.users/12135
> > >
> > > Jan
> > >
> > > --
> > > Siemens AG=2C Corporate Technology=2C CT T DE IT 1
> > > Corporate Competence Center Embedded Linux
> >=20
> > Hi Jan=2C
> >=20
> > Thanks for the reply. I got the following info from you post and i had =
few=20
> > questions related to this post:
> >=20
> >=20
> >=20
> > >> - MSI[-X] usage for RTDM (ie. RT) drivers is basically fine as long =
as you=20
> > avoid enabling/disabling from RT context (also used for quite a while h=
ere=2C no=20
> > known issues under this restriction)
> >=20
> > my question is are you mentioninig here that i must not be doing=20
> > pci_enable_msi() and pci_disable_msi() inside the RTDM driver ? if not =
then=20
> > where should these calls be done ?
>=20
> pci_enable/disable_msi are initialization services that only need to be
> executed over Linux context - also in RTDM drivers.
>=20
> >=20
> > Right now i have ported my standerd linux driver for the PCIe card to R=
TDM=20
> > drvier. This driver uses MSI. I am not enabeling or disabling MSI or IR=
Q any=20
> > where in the driver while processing [i.e. in ISR or read/write]. I am =
enabeling=20
> > MSI in the PCI Probe and disabeling it in the PCI remove functions. The=
 problem=20
> > i am facing is as soon as i get the First MSI interrupt the kernel oops=
 and i=20
> > get the following dump:
> >=20
> > |Mar 21 21:08:34 barch kernel: BUG: unable to handle kernel paging requ=
est at 7f45402d
> > Mar 21 21:08:34 barch kernel: Oops: 0000 [#1] PREEMPT SMP
> > |
> >=20
>=20
> We would need the full backtrace to have at least a chance to help.
>=20
> >=20
> > [note: The normal linux driver works with out any problem].
> >=20
> > Please let me know your thoughts. Also is there an example PCIe RTDM dr=
iver=20
> > using MSI that i can refer to understand more about this topic ?
>=20
> Check RTnet's IGB driver. It works with MSI-X interrupts on x86.
>=20
> Jan
>=20
> --=20
> Siemens AG=2C Corporate Technology=2C CT T DE IT 1
> Corporate Competence Center Embedded Linux
=20
Hi Jan=2C
Thanks again for the reply. Here is the full backtrace:
=20
Mar 22 21:12:47 localhost kernel: test_dev: Probe for device function=3D0
Mar 22 21:12:47 localhost kernel: test_dev 0000:15:00.0: found PCI INT A ->=
 IRQ 10
Mar 22 21:12:47 localhost kernel: pci_bar =3D 0xfe000000=20
Mar 22 21:12:47 localhost kernel: Xenomai: RTDM: RT open handler is depreca=
ted=2C driver requires update.
Mar 22 21:12:47 localhost kernel: Xenomai: RTDM: RT close handler is deprec=
ated=2C driver requires update.
Mar 22 21:12:47 localhost kernel: test_dev: IRQ 16 successfully assigned to=
 the device.
Mar 22 21:12:47 localhost kernel: test_dev: Probe for device function=3D1
Mar 22 21:12:47 localhost kernel: test_dev: Successfully added test_dev Dev=
ice Driver.
Mar 22 21:13:58 localhost kernel: BUG: unable to handle kernel paging reque=
st at d84050c0
Mar 22 21:13:58 localhost kernel: IP: [<c0468f84>] __ipipe_set_irq_pending+=
0x36/0x49
Mar 22 21:13:58 localhost kernel: *pde =3D 00000000=20
Mar 22 21:13:58 localhost kernel: Oops: 0002 [#1] PREEMPT SMP=20
Mar 22 21:13:58 localhost kernel: last sysfs file: /sys/devices/pci0000:00/=
0000:00:1a.0/0000:1f:00.0/0000:20:05.0/0000:2d:00.0/class
Mar 22 21:13:58 localhost kernel: Modules linked in: test_dev autofs4 hidp =
l2cap crc16 bluetooth sunrpc ip6t_REJECT xt_tcpudp ip6table_filter ip6_tabl=
es x_tables ipv6 snd soundcore sata_sil24 libata sd_mod scsi_mod ext3 jbd u=
hci_hcd ohci_hcd ehci_hcd [last unloaded: snd_page_alloc]
Mar 22 21:13:58 localhost kernel:=20
Mar 22 21:13:58 localhost kernel: Pid: 2414=2C comm: ptg Not tainted 2.6.37=
_xenomai-2.5.6 #2 To be filled by O.E.M./To be filled by O.E.M.
Mar 22 21:13:58 localhost kernel: EIP: 0060:[<c0468f84>] EFLAGS: 00010207 C=
PU: 0
Mar 22 21:13:58 localhost kernel: EIP is at __ipipe_set_irq_pending+0x36/0x=
49
Mar 22 21:13:58 localhost kernel: EAX: 07ffffff EBX: ffffffff ECX: d74050c0=
 EDX: c08bc6c0
Mar 22 21:13:58 localhost kernel: ESI: c08bc640 EDI: ffffffc0 EBP: c08bc644=
 ESP: d69a9f8c
Mar 22 21:13:58 localhost kernel:  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: =
0068
Mar 22 21:13:58 localhost kernel: Process ptg (pid: 2414=2C ti=3Dd69a8000 t=
ask=3Dd6b2a920 task.ti=3Dd69a8000)
Mar 22 21:13:58 localhost kernel: I-pipe domain Linux
Mar 22 21:13:58 localhost kernel: Stack:
Mar 22 21:13:58 localhost kernel:  ffffffff c0416272 d69a9fb4 00000000 c088=
f180 00000000 00000001 00000001
Mar 22 21:13:58 localhost kernel:  bfa2e138 c0402c69 00000000 00000000 8800=
0000 00000001 00000001 bfa2e138
Mar 22 21:13:58 localhost kernel:  b781e000 0000007b 0000007b 00000000 0000=
0000 ffffffd7 0804b20a 00000073
Mar 22 21:13:58 localhost kernel: Call Trace:
Mar 22 21:13:58 localhost kernel:  [<c0416272>] ? __ipipe_handle_irq+0xf4/0=
x212
Mar 22 21:13:58 localhost kernel:  [<c0402c69>] ? common_interrupt+0x29/0x3=
8
Mar 22 21:13:58 localhost kernel: Code: e0 b3 82 c0 01 d1 69 10 a0 09 00 00=
 01 d1 9c 5a 89 da c1 e2 06 8d 94 02 c0 00 00 00 8b 02 a8 20 75 0f 0f ab 59=
 08 89 d8 c1 e8 05 <0f> ab 41 04 eb 04 0f ab 59 50 ff 84 99 98 00 00 00 5b =
c3 57 56=20
Mar 22 21:13:58 localhost kernel: EIP: [<c0468f84>] __ipipe_set_irq_pending=
+0x36/0x49 SS:ESP 0068:d69a9f8c
Mar 22 21:13:58 localhost kernel: CR2: 00000000d84050c0
Mar 22 21:13:58 localhost kernel: ---[ end trace 872caaf8551a0ced ]---
=20
Please let me know your inputs.
=20
thanks=2C
krishna=20

  		 	   		  =

--_eaeabbaa-6d1c-4ee3-8558-17a0e5fc3ad5_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'>
&gt=3B Date: Tue=2C 22 Mar 2011 13:13:16 +0100<BR>&gt=3B From: jan.kiszka@domain.hid=
iemens.com<BR>&gt=3B To: krishnamurthyjs@domain.hid<BR>&gt=3B CC: gilles.c=
hanteperdrix@domain.hid xenomai@xenomai.org<BR>&gt=3B Subject: Re: MSI=
 support in Xenomai<BR>&gt=3B <BR>&gt=3B On 2011-03-21 13:48=2C krishna m w=
rote:<BR>&gt=3B &gt=3B &gt=3B Date: Thu=2C 17 Mar 2011 09:30:37 +0100<BR>&g=
t=3B &gt=3B &gt=3B From: jan.kiszka@domain.hid<BR>&gt=3B &gt=3B &gt=3B To:=
 gilles.chanteperdrix@xenomai.org krishnamurthyjs@domain.hid<BR>&gt=3B =
&gt=3B &gt=3B CC: xenomai@xenomai.org<BR>&gt=3B &gt=3B &gt=3B Subject: Re:=
 MSI support in Xenomai<BR>&gt=3B &gt=3B &gt=3B<BR>&gt=3B &gt=3B &gt=3B On =
2011-03-16 14:26=2C Gilles Chanteperdrix wrote:<BR>&gt=3B &gt=3B &gt=3B &gt=
=3B krishna m wrote:<BR>&gt=3B &gt=3B &gt=3B &gt=3B&gt=3B Hi All=2C I wante=
d to know if the latest Xenomai [Version<BR>&gt=3B &gt=3B &gt=3B &gt=3B&gt=
=3B xenomai-2.5.6] supports MSI interrupts. I am using the adeos Patch<BR>&=
gt=3B &gt=3B &gt=3B &gt=3B&gt=3B [version adeos-ipipe-2.6.37-x86-2.9-00] an=
d corresponding Linux<BR>&gt=3B &gt=3B &gt=3B &gt=3B&gt=3B kernel [version:=
 linux-2.6.37]. I have read in the Xenomai FAQ that<BR>&gt=3B &gt=3B &gt=3B=
 &gt=3B&gt=3B MSI is not supported by the ipipe patch just wanted to know i=
f the<BR>&gt=3B &gt=3B &gt=3B &gt=3B&gt=3B latest Xenomai and Ipipe support=
s MSI.<BR>&gt=3B &gt=3B &gt=3B &gt=3B<BR>&gt=3B &gt=3B &gt=3B &gt=3B No.<BR=
>&gt=3B &gt=3B &gt=3B<BR>&gt=3B &gt=3B &gt=3B Strictly spoken=2C but it wor=
ks in practice. See<BR>&gt=3B &gt=3B &gt=3B<BR>&gt=3B &gt=3B &gt=3B http://=
thread.gmane.org/gmane.linux.real-time.xenomai.users/12135<BR>&gt=3B &gt=3B=
 &gt=3B<BR>&gt=3B &gt=3B &gt=3B Jan<BR>&gt=3B &gt=3B &gt=3B<BR>&gt=3B &gt=
=3B &gt=3B --<BR>&gt=3B &gt=3B &gt=3B Siemens AG=2C Corporate Technology=2C=
 CT T DE IT 1<BR>&gt=3B &gt=3B &gt=3B Corporate Competence Center Embedded =
Linux<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B Hi Jan=2C<BR>&gt=3B &gt=3B <BR>&gt=
=3B &gt=3B Thanks for the reply. I got the following info from you post and=
 i had few <BR>&gt=3B &gt=3B questions related to this post:<BR>&gt=3B &gt=
=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B &gt=3B&gt=3B - MS=
I[-X] usage for RTDM (ie. RT) drivers is basically fine as long as you <BR>=
&gt=3B &gt=3B avoid enabling/disabling from RT context (also used for quite=
 a while here=2C no <BR>&gt=3B &gt=3B known issues under this restriction)<=
BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B my question is are you mentioninig here =
that i must not be doing <BR>&gt=3B &gt=3B pci_enable_msi() and pci_disable=
_msi() inside the RTDM driver ? if not then <BR>&gt=3B &gt=3B where should =
these calls be done ?<BR>&gt=3B <BR>&gt=3B pci_enable/disable_msi are initi=
alization services that only need to be<BR>&gt=3B executed over Linux conte=
xt - also in RTDM drivers.<BR>&gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B Ri=
ght now i have ported my standerd linux driver for the PCIe card to RTDM <B=
R>&gt=3B &gt=3B drvier. This driver uses MSI. I am not enabeling or disabli=
ng MSI or IRQ any <BR>&gt=3B &gt=3B where in the driver while processing [i=
.e. in ISR or read/write]. I am enabeling <BR>&gt=3B &gt=3B MSI in the PCI =
Probe and disabeling it in the PCI remove functions. The problem <BR>&gt=3B=
 &gt=3B i am facing is as soon as i get the First MSI interrupt the kernel =
oops and i <BR>&gt=3B &gt=3B get the following dump:<BR>&gt=3B &gt=3B <BR>&=
gt=3B &gt=3B |Mar 21 21:08:34 barch kernel: BUG: unable to handle kernel pa=
ging request at 7f45402d<BR>&gt=3B &gt=3B Mar 21 21:08:34 barch kernel: Oop=
s: 0000 [#1] PREEMPT SMP<BR>&gt=3B &gt=3B |<BR>&gt=3B &gt=3B <BR>&gt=3B <BR=
>&gt=3B We would need the full backtrace to have at least a chance to help.=
<BR>&gt=3B <BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B [note: The normal linux driv=
er works with out any problem].<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B Please l=
et me know your thoughts. Also is there an example PCIe RTDM driver <BR>&gt=
=3B &gt=3B using MSI that i can refer to understand more about this topic ?=
<BR>&gt=3B <BR>&gt=3B Check RTnet's IGB driver. It works with MSI-X interru=
pts on x86.<BR>&gt=3B <BR>&gt=3B Jan<BR>&gt=3B <BR>&gt=3B -- <BR>&gt=3B Sie=
mens AG=2C Corporate Technology=2C CT T DE IT 1<BR>&gt=3B Corporate Compete=
nce Center Embedded Linux<BR>
&nbsp=3B<BR>
Hi Jan=2C<BR>
Thanks again for the reply. Here is the full backtrace:<BR>
&nbsp=3B<BR>
Mar 22 21:12:47 localhost kernel: test_dev: Probe for device function=3D0<B=
R>Mar 22 21:12:47 localhost kernel: test_dev 0000:15:00.0: found PCI INT A =
-&gt=3B IRQ 10<BR>Mar 22 21:12:47 localhost kernel: pci_bar =3D 0xfe000000 =
<BR>Mar 22 21:12:47 localhost kernel: Xenomai: RTDM: RT open handler is dep=
recated=2C driver requires update.<BR>Mar 22 21:12:47 localhost kernel: Xen=
omai: RTDM: RT close handler is deprecated=2C driver requires update.<BR>Ma=
r 22 21:12:47 localhost kernel: test_dev: IRQ 16 successfully assigned to t=
he device.<BR>Mar 22 21:12:47 localhost kernel: test_dev: Probe for device =
function=3D1<BR>Mar 22 21:12:47 localhost kernel: test_dev: Successfully ad=
ded test_dev Device Driver.<BR>Mar 22 21:13:58 localhost kernel: BUG: unabl=
e to handle kernel paging request at d84050c0<BR>Mar 22 21:13:58 localhost =
kernel: IP: [&lt=3Bc0468f84&gt=3B] __ipipe_set_irq_pending+0x36/0x49<BR>Mar=
 22 21:13:58 localhost kernel: *pde =3D 00000000 <BR>Mar 22 21:13:58 localh=
ost kernel: Oops: 0002 [#1] PREEMPT SMP <BR>Mar 22 21:13:58 localhost kerne=
l: last sysfs file: /sys/devices/pci0000:00/0000:00:1a.0/0000:1f:00.0/0000:=
20:05.0/0000:2d:00.0/class<BR>Mar 22 21:13:58 localhost kernel: Modules lin=
ked in: test_dev autofs4 hidp l2cap crc16 bluetooth sunrpc ip6t_REJECT xt_t=
cpudp ip6table_filter ip6_tables x_tables ipv6 snd soundcore sata_sil24 lib=
ata sd_mod scsi_mod ext3 jbd uhci_hcd ohci_hcd ehci_hcd [last unloaded: snd=
_page_alloc]<BR>Mar 22 21:13:58 localhost kernel: <BR>Mar 22 21:13:58 local=
host kernel: Pid: 2414=2C comm: ptg Not tainted 2.6.37_xenomai-2.5.6 #2 To =
be filled by O.E.M./To be filled by O.E.M.<BR>Mar 22 21:13:58 localhost ker=
nel: EIP: 0060:[&lt=3Bc0468f84&gt=3B] EFLAGS: 00010207 CPU: 0<BR>Mar 22 21:=
13:58 localhost kernel: EIP is at __ipipe_set_irq_pending+0x36/0x49<BR>Mar =
22 21:13:58 localhost kernel: EAX: 07ffffff EBX: ffffffff ECX: d74050c0 EDX=
: c08bc6c0<BR>Mar 22 21:13:58 localhost kernel: ESI: c08bc640 EDI: ffffffc0=
 EBP: c08bc644 ESP: d69a9f8c<BR>Mar 22 21:13:58 localhost kernel:&nbsp=3B D=
S: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068<BR>Mar 22 21:13:58 localhost ke=
rnel: Process ptg (pid: 2414=2C ti=3Dd69a8000 task=3Dd6b2a920 task.ti=3Dd69=
a8000)<BR>Mar 22 21:13:58 localhost kernel: I-pipe domain Linux<BR>Mar 22 2=
1:13:58 localhost kernel: Stack:<BR>Mar 22 21:13:58 localhost kernel:&nbsp=
=3B ffffffff c0416272 d69a9fb4 00000000 c088f180 00000000 00000001 00000001=
<BR>Mar 22 21:13:58 localhost kernel:&nbsp=3B bfa2e138 c0402c69 00000000 00=
000000 88000000 00000001 00000001 bfa2e138<BR>Mar 22 21:13:58 localhost ker=
nel:&nbsp=3B b781e000 0000007b 0000007b 00000000 00000000 ffffffd7 0804b20a=
 00000073<BR>Mar 22 21:13:58 localhost kernel: Call Trace:<BR>Mar 22 21:13:=
58 localhost kernel:&nbsp=3B [&lt=3Bc0416272&gt=3B] ? __ipipe_handle_irq+0x=
f4/0x212<BR>Mar 22 21:13:58 localhost kernel:&nbsp=3B [&lt=3Bc0402c69&gt=3B=
] ? common_interrupt+0x29/0x38<BR>Mar 22 21:13:58 localhost kernel: Code: e=
0 b3 82 c0 01 d1 69 10 a0 09 00 00 01 d1 9c 5a 89 da c1 e2 06 8d 94 02 c0 0=
0 00 00 8b 02 a8 20 75 0f 0f ab 59 08 89 d8 c1 e8 05 &lt=3B0f&gt=3B ab 41 0=
4 eb 04 0f ab 59 50 ff 84 99 98 00 00 00 5b c3 57 56 <BR>Mar 22 21:13:58 lo=
calhost kernel: EIP: [&lt=3Bc0468f84&gt=3B] __ipipe_set_irq_pending+0x36/0x=
49 SS:ESP 0068:d69a9f8c<BR>Mar 22 21:13:58 localhost kernel: CR2: 00000000d=
84050c0<BR>Mar 22 21:13:58 localhost kernel: ---[ end trace 872caaf8551a0ce=
d ]---<BR>
&nbsp=3B<BR>
Please let me know your inputs.<BR>
&nbsp=3B<BR>
thanks=2C<BR>
krishna <BR>
<BR>&nbsp=3B<BR> 		 	   		  </body>
</html>=

--_eaeabbaa-6d1c-4ee3-8558-17a0e5fc3ad5_--

