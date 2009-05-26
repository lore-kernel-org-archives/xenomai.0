MIME-Version: 1.0
In-Reply-To: <72cf3fb0905260655g3e6942c5va7bc032f1cb5f35@domain.hid>
References: <9c789a000905250446t78fd6b38x1a6f28e35b70d7d6@domain.hid>
	<878wkkzxba.fsf@domain.hid>
	<9c789a000905251435p6f851d21v617c7e26a971f143@domain.hid>
	<871vqczveh.fsf@domain.hid>
	<9c789a000905251516j5272ae7bpc60aea8fdc17d50c@domain.hid>
	<9c789a000905251532i4775d796x8f095503a203e5bb@domain.hid>
	<72cf3fb0905260655g3e6942c5va7bc032f1cb5f35@domain.hid>
Date: Tue, 26 May 2009 17:36:36 +0300
Message-ID: <9c789a000905260736t241467ax805c4823b0d58ff5@domain.hid>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=0016e68dbd976c108c046ad1a779
Subject: Re: [Xenomai-help] Driver testing procedure ?!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org

--0016e68dbd976c108c046ad1a779
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Tue, May 26, 2009 at 4:55 PM, Alexis Berlemont <berlemont.hauw@domain.hid>wrote:

> Hi,
>
> On Tue, May 26, 2009 at 12:32 AM, Cristian Axenie
> <cristian.axenie@domain.hid> wrote:
> >
> >
> > ---------- Forwarded message ----------
> > From: Cristian Axenie <cristian.axenie@domain.hid>
> > Date: Tue, May 26, 2009 at 1:16 AM
> > Subject: Re: [Xenomai-help] Driver testing procedure ?!
> > To: Alexis Berlemont <berlemont.hauw@domain.hid>
> >
> >
> >
> >
> > On Tue, May 26, 2009 at 1:10 AM, Alexis Berlemont <
> berlemont.hauw@domain.hid>
> > wrote:
> >>
> >> Cristian Axenie <cristian.axenie@domain.hid> writes:
> >>
> >> > Hi,
> >> >
> >> > I finally figured out this aspect but I still have one problem,
> residing
> >> > in the fact that I have no comedi devices in my dev list
> >> > and so I cannot ./comedi_config /dev/comedi0 nipcimio !
> >> >
> >> > As I see it there are no comedi devices
> >> >
> >> > /usr/xenomai/sbin # cat /proc/devices
> >>
> >> You should not look at there. This proc file lists everything but RTDM
> >> devices.
> >>
> >> >
> >> > and the list
> >> >
> >> > /usr/xenomai/sbin # cat /proc/comedi/devices
> >> > --  Comedi devices --
> >> >
> >> > | idx | status | driver
> >> > |  00 | Unused | No driver
> >> > |  01 | Unused | No driver
> >> > |  02 | Unused | No driver
> >> > |  03 | Unused | No driver
> >> > |  04 | Unused | No driver
> >> > |  05 | Unused | No driver
> >> > |  06 | Unused | No driver
> >> > |  07 | Unused | No driver
> >> > |  08 | Unused | No driver
> >> > |  09 | Unused | No driver
> >> > /usr/xenomai/sbin # cat /proc/comedi/drivers
> >> > comedi_config   rtcanconfig     rtps
> >> > /usr/xenomai/sbin # cat /proc/comedi/drivers
> >> > --  Comedi drivers --
> >> >
> >> > | idx | driver name
> >> > |  00 | pcimio
> >> > |  01 | comedi_8255
> >> > |  02 | comedi_loop
> >> > |  03 | comedi_fake
> >> >
> >> > Shouldn't the specific comedi devices be generated when installing
> >> > Xenomai ?
> >>
> >> That is common comedi behaviour. So far, the comedi drivers are listed,
> >> they are available in the kernel. However, you have to attach them so as
> >> to make them reachable (thanks to comedi_config).
> >>
> >> Once the attach will be done, you will see your driver appear in
> >> /proc/comedi/devices.
> >>
> >> If the comedi_config did not work, the problem is here. In such case,
> >> could you send the traces?
> >
> > The problem is that the comedi devs are not present in /dev and so when I
> > run comedi config
> >
> > /usr/xenomai/sbin # ./comedi_config /dev/comedi0 pcimio
> > comedi_config: comedi_open failed ret=-19
> >
> > Shouldn't the comedi0, comedi1... devices be created when installing
> Xenomai
> > ?
>
> Here, we are talking about RTDM devices not common Linux /dev files.
> Have a look at /proc/xenomai/rtdm/comediXX.


  Thanks for making it clear to me. I've tested with the comedi0 RTDM device
and a (sad) SEGFAULT emerged
here the oops

/usr/xenomai/sbin # ./comedi_config comedi0 pcimio
pcimio_attach: found pci-6024e board
MITE: 0x90000000 mapped to c907a000 DAQ: 0x90001000 mapped to c907c000
MITE: version = 2, type = 1, mite mode = 1, interface mode = 3
MITE: num channels = 1, write post fifo depth = 1, wins = 0, iowins = 2
pcimio_attach: found irq 48
Unable to handle kernel paging request for data at address 0x0000001c
Faulting instruction address: 0xc023923c
Oops: Kernel access of bad area, sig: 11 [#1]
MPC831x RDB
Modules linked in:
NIP: c023923c LR: c0249c2c CTR: c01bd8b4
REGS: c7a37cd0 TRAP: 0300   Not tainted  (2.6.24.2)
MSR: 00009032 <EE,ME,IR,DR>  CR: 24008422  XER: 00000000
DAR: 0000001c, DSISR: 20000000
TASK = c78957f0[890] 'comedi_config' THREAD: c7a36000
GPR00: 0000ffff c7a37d80 c78957f0 c03ee0c0 00000030 c0246df4 00000001
c03ee0c0
GPR08: 00000001 00000000 00000000 00000000 24008422 1004a5b8 c031bf40
c03b0000
GPR16: c03b62ac c03cda00 fffffff0 c7a37f50 c03cda00 00000040 c7a37e48
c03ee0c0
GPR24: c03b0f98 c03b0bd8 00000000 c03d6608 c7900810 c7900c10 fffffff0
c03ee0c0
Call Trace:
[c7a37d80] [00000001]  (unreliable)
[c7a37da0] [c0249c2c]
[c7a37dd0] [c0236c94]
[c7a37df0] [c0236dcc]
[c7a37e30] [c02371dc]
[c7a37e40] [c0239c78]
[c7a37e70] [c0089588]
[c7a37eb0] [c008b7b8]
[c7a37ec0] [c0057db0]
[c7a37ee0] [c0049158]
[c7a37f30] [c0009644]
[c7a37f40] [c0010ca4]
--- Exception: c01Instruction dump:
38210010 7c0803a6 4e800020 9421ffe0 7c0802a6 bf61000c 7c7f1b78 3bc0fff0
90010024 38000000 6000ffff 81230008 <8169001c> 7f8b0000 419e001c 80010024
---[ end trace 31c77e297a2e6a3e ]---

Any ideas ?



>
>
> Consequently, your comedi_config command line should be "comedi_config
> comedi0 pcimio".
>
> Alexis.
>

--0016e68dbd976c108c046ad1a779
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, May 26, 2009 at 4:55 PM, Alexis =
Berlemont <span dir=3D"ltr">&lt;<a href=3D"mailto:berlemont.hauw@domain.hid">b=
erlemont.hauw@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0=
pt 0.8ex; padding-left: 1ex;">
Hi,<br>
<div><div></div><div class=3D"h5"><br>
On Tue, May 26, 2009 at 12:32 AM, Cristian Axenie<br>
&lt;<a href=3D"mailto:cristian.axenie@domain.hid">cristian.axenie@domain.hid<=
/a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; ---------- Forwarded message ----------<br>
&gt; From: Cristian Axenie &lt;<a href=3D"mailto:cristian.axenie@domain.hid"=
>cristian.axenie@domain.hid</a>&gt;<br>
&gt; Date: Tue, May 26, 2009 at 1:16 AM<br>
&gt; Subject: Re: [Xenomai-help] Driver testing procedure ?!<br>
&gt; To: Alexis Berlemont &lt;<a href=3D"mailto:berlemont.hauw@domain.hid">ber=
lemont.hauw@domain.hid</a>&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, May 26, 2009 at 1:10 AM, Alexis Berlemont &lt;<a href=3D"mailt=
o:berlemont.hauw@domain.hid">berlemont.hauw@domain.hid</a>&gt;<br>
&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Cristian Axenie &lt;<a href=3D"mailto:cristian.axenie@domain.hid">c=
ristian.axenie@domain.hid</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Hi,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I finally figured out this aspect but I still have one proble=
m, residing<br>
&gt;&gt; &gt; in the fact that I have no comedi devices in my dev list<br>
&gt;&gt; &gt; and so I cannot ./comedi_config /dev/comedi0 nipcimio !<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; As I see it there are no comedi devices<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; /usr/xenomai/sbin # cat /proc/devices<br>
&gt;&gt;<br>
&gt;&gt; You should not look at there. This proc file lists everything but =
RTDM<br>
&gt;&gt; devices.<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; and the list<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; /usr/xenomai/sbin # cat /proc/comedi/devices<br>
&gt;&gt; &gt; --=A0 Comedi devices --<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; | idx | status | driver<br>
&gt;&gt; &gt; |=A0 00 | Unused | No driver<br>
&gt;&gt; &gt; |=A0 01 | Unused | No driver<br>
&gt;&gt; &gt; |=A0 02 | Unused | No driver<br>
&gt;&gt; &gt; |=A0 03 | Unused | No driver<br>
&gt;&gt; &gt; |=A0 04 | Unused | No driver<br>
&gt;&gt; &gt; |=A0 05 | Unused | No driver<br>
&gt;&gt; &gt; |=A0 06 | Unused | No driver<br>
&gt;&gt; &gt; |=A0 07 | Unused | No driver<br>
&gt;&gt; &gt; |=A0 08 | Unused | No driver<br>
&gt;&gt; &gt; |=A0 09 | Unused | No driver<br>
&gt;&gt; &gt; /usr/xenomai/sbin # cat /proc/comedi/drivers<br>
&gt;&gt; &gt; comedi_config=A0=A0 rtcanconfig=A0=A0=A0=A0 rtps<br>
&gt;&gt; &gt; /usr/xenomai/sbin # cat /proc/comedi/drivers<br>
&gt;&gt; &gt; --=A0 Comedi drivers --<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; | idx | driver name<br>
&gt;&gt; &gt; |=A0 00 | pcimio<br>
&gt;&gt; &gt; |=A0 01 | comedi_8255<br>
&gt;&gt; &gt; |=A0 02 | comedi_loop<br>
&gt;&gt; &gt; |=A0 03 | comedi_fake<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Shouldn&#39;t the specific comedi devices be generated when i=
nstalling<br>
&gt;&gt; &gt; Xenomai ?<br>
&gt;&gt;<br>
&gt;&gt; That is common comedi behaviour. So far, the comedi drivers are li=
sted,<br>
&gt;&gt; they are available in the kernel. However, you have to attach them=
 so as<br>
&gt;&gt; to make them reachable (thanks to comedi_config).<br>
&gt;&gt;<br>
&gt;&gt; Once the attach will be done, you will see your driver appear in<b=
r>
&gt;&gt; /proc/comedi/devices.<br>
&gt;&gt;<br>
&gt;&gt; If the comedi_config did not work, the problem is here. In such ca=
se,<br>
&gt;&gt; could you send the traces?<br>
&gt;<br>
&gt; The problem is that the comedi devs are not present in /dev and so whe=
n I<br>
&gt; run comedi config<br>
&gt;<br>
&gt; /usr/xenomai/sbin # ./comedi_config /dev/comedi0 pcimio<br>
&gt; comedi_config: comedi_open failed ret=3D-19<br>
&gt;<br>
&gt; Shouldn&#39;t the comedi0, comedi1... devices be created when installi=
ng Xenomai<br>
&gt; ?<br>
<br>
</div></div>Here, we are talking about RTDM devices not common Linux /dev f=
iles.<br>
Have a look at /proc/xenomai/rtdm/comediXX.</blockquote><div><br>=A0 Thanks=
 for making it clear to me. I&#39;ve tested with the comedi0 RTDM device an=
d a (sad) SEGFAULT emerged<br>here the oops<br><br>/usr/xenomai/sbin # ./co=
medi_config comedi0 pcimio<br>
pcimio_attach: found pci-6024e board<br>MITE: 0x90000000 mapped to c907a000=
 DAQ: 0x90001000 mapped to c907c000<br>MITE: version =3D 2, type =3D 1, mit=
e mode =3D 1, interface mode =3D 3<br>MITE: num channels =3D 1, write post =
fifo depth =3D 1, wins =3D 0, iowins =3D 2<br>
pcimio_attach: found irq 48<br>Unable to handle kernel paging request for d=
ata at address 0x0000001c<br>Faulting instruction address: 0xc023923c<br>Oo=
ps: Kernel access of bad area, sig: 11 [#1]<br>MPC831x RDB<br>Modules linke=
d in:<br>
NIP: c023923c LR: c0249c2c CTR: c01bd8b4<br>REGS: c7a37cd0 TRAP: 0300=A0=A0=
 Not tainted=A0 (2.6.24.2)<br>MSR: 00009032 &lt;EE,ME,IR,DR&gt;=A0 CR: 2400=
8422=A0 XER: 00000000<br>DAR: 0000001c, DSISR: 20000000<br>TASK =3D c78957f=
0[890] &#39;comedi_config&#39; THREAD: c7a36000<br>
GPR00: 0000ffff c7a37d80 c78957f0 c03ee0c0 00000030 c0246df4 00000001 c03ee=
0c0 <br>GPR08: 00000001 00000000 00000000 00000000 24008422 1004a5b8 c031bf=
40 c03b0000 <br>GPR16: c03b62ac c03cda00 fffffff0 c7a37f50 c03cda00 0000004=
0 c7a37e48 c03ee0c0 <br>
GPR24: c03b0f98 c03b0bd8 00000000 c03d6608 c7900810 c7900c10 fffffff0 c03ee=
0c0 <br>Call Trace:<br>[c7a37d80] [00000001]=A0 (unreliable)<br>[c7a37da0] =
[c0249c2c] <br>[c7a37dd0] [c0236c94] <br>[c7a37df0] [c0236dcc] <br>[c7a37e3=
0] [c02371dc] <br>
[c7a37e40] [c0239c78] <br>[c7a37e70] [c0089588] <br>[c7a37eb0] [c008b7b8] <=
br>[c7a37ec0] [c0057db0] <br>[c7a37ee0] [c0049158] <br>[c7a37f30] [c0009644=
] <br>[c7a37f40] [c0010ca4] <br>--- Exception: c01Instruction dump:<br>
38210010 7c0803a6 4e800020 9421ffe0 7c0802a6 bf61000c 7c7f1b78 3bc0fff0 <br=
>90010024 38000000 6000ffff 81230008 &lt;8169001c&gt; 7f8b0000 419e001c 800=
10024 <br>---[ end trace 31c77e297a2e6a3e ]---<br><br>Any ideas ?<br><br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
Consequently, your comedi_config command line should be &quot;comedi_config=
<br>
comedi0 pcimio&quot;.<br>
<font color=3D"#888888"><br>
Alexis.<br>
</font></blockquote></div><br>

--0016e68dbd976c108c046ad1a779--

