MIME-Version: 1.0
In-Reply-To: <871vq0kftf.fsf@domain.hid>
References: <9c789a000905250446t78fd6b38x1a6f28e35b70d7d6@domain.hid>
	<72cf3fb0905260655g3e6942c5va7bc032f1cb5f35@domain.hid>
	<9c789a000905260736t241467ax805c4823b0d58ff5@domain.hid>
	<1243374524.22014.74.camel@domain.hid>
	<9c789a000905261525q45cbaa3ag25855befde1cb130@domain.hid>
	<9c789a000905261531m67dee7dah9740d825cce04cbc@domain.hid>
	<9c789a000905261535v56d5ac5i4fa1a41f4e678849@domain.hid>
	<9c789a000905271447i3998c3d3xf5ce93d1d8783031@domain.hid>
	<72cf3fb0905272338s6ef295fch9239989091ac85ca@domain.hid>
	<871vq0kftf.fsf@domain.hid>
Date: Thu, 4 Jun 2009 11:20:32 +0300
Message-ID: <9c789a000906040120t53d8a7ccm4e9384d4328634dd@domain.hid>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d376611c5740046b81731a
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

--0016e6d376611c5740046b81731a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hy I,ve tested the new git update and failed

/usr/xenomai/sbin # ./comedi_config comedi0 comedi_pcimio
Unable to handle kernel paging request for data at address 0x0000001c
Faulting instruction address: 0xc0239c5c
Oops: Kernel access of bad area, sig: 11 [#1]
MPC831x RDB
Modules linked in:
*NIP: c0239c5c* LR: c024aaf8 CTR: 00000000
REGS: c7affcd0 TRAP: 0300   Not tainted  (2.6.24.2)
MSR: 00009032 <EE,ME,IR,DR>  CR: 24008424  XER: 00000000
DAR: 0000001c, DSISR: 20000000
TASK = c7889430[1536] 'comedi_config' THREAD: c7afe000
GPR00: 0000ffff c7affd80 c7889430 c03f00e0 00000030 c0247d44 00000001
c03f00e0
GPR08: c907a000 00000000 00000001 c7810400 c7900a00 1004a5b8 c033c200
c03c0000
GPR16: c03b83c4 c03cfa00 fffffff0 c7afff50 c03cfa00 00000040 00000010
c03a0ca0
GPR24: c03f00e0 c03b2cf0 00000000 00000000 c7900800 c03d8628 fffffff0
c03f00e0
Call Trace:
[c7affd80] [c023c2d4]  (unreliable)
[c7affda0] [c024aaf8]
[c7affdd0] [c02376f8]
[c7affdf0] [c0237830]
[c7affe30] [c0237c50]
[c7affe40] [c023a5e8]
[c7affe70] [c0089820]
[c7affeb0] [c008ba50]
[c7affec0] [c00582d0]
[c7affee0] [c0049188]
[c7afff30] [c0009644]
[c7afff40] [c0010ca4]
--- Exception: c01Instruction dump:
38210010 7c0803a6 4e800020 9421ffe0 7c0802a6 bf61000c 7c7f1b78 3bc0fff0
90010024 38000000 6000ffff 81230010 <8169001c> 7f8b0000 419e001c 80010024
---[ end trace 78f6932e4d494a5a ]---

and I've managed to trace the fault

/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-integration/drivers/xenomai/comedi/transfer.c:295
c0239c50:    38 00 00 00     li      r0,0
c0239c54:    60 00 ff ff     ori     r0,r0,65535
c0239c58:    81 23 00 10     lwz     r9,16(r3)
*c0239c5c:    81 69 00 1c     lwz     r11,28(r9)*
c0239c60:    7f 8b 00 00     cmpw    cr7,r11,r0
c0239c64:    41 9e 00 1c     beq-    cr7,c0239c80 <comedi_request_irq+0x48>

What do you think ?



On Thu, Jun 4, 2009 at 3:23 AM, Alexis Berlemont <berlemont.hauw@domain.hid>wrote:

> Hi,
>
> Alexis Berlemont <berlemont.hauw@domain.hid> writes:
>
> > Hi,
> >
> > On Wed, May 27, 2009 at 11:47 PM, Cristian Axenie
> > <cristian.axenie@domain.hid> wrote:
> >> Hi!
> >>
> >> Without no modiffications (just some printks) I've got a new trace
> pointing
> >> that the problem is at another location :
> >>
> >> and the location from the kernel dissasembly points to :
> >>
> >>
> /home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-prepared/drivers/xenomai/comedi/transfer.c:317
> >> c02399d8:    38 00 00 00     li      r0,0
> >> c02399dc:    60 00 ff ff     ori     r0,r0,65535
> >> c02399e0:    81 23 00 08     lwz     r9,8(r3)
> >> c02399e4:    81 69 00 1c     lwz     r11,28(r9)
> >> c02399e8:    7f 8b 00 00     cmpw    cr7,r11,r0
> >> c02399ec:    41 9e 00 1c     beq-    cr7,c0239a08
> <comedi_request_irq+0x48>
> >>
> >>
> >> Do you have any idea what is the source for this random erroneous
> behaviour
> >> ?
> >
> > Ok. Thanks, I will have a look at that location. By the way, I think
> > there was another mistake (I made) in the attach procedure
> > (comedi_init_drv() called twice).
> >
> > But do not expect any git update today, I am unavailable until tonight.
>
> I updated my git repository (comedi branch). Could you test it?
>
> Alexis.
>

--0016e6d376611c5740046b81731a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hy I,ve tested the new git update and failed<br><br>/usr/xenomai/sbin # ./c=
omedi_config comedi0 comedi_pcimio <br>Unable to handle kernel paging reque=
st for data at address 0x0000001c<br>Faulting instruction address: 0xc0239c=
5c<br>
Oops: Kernel access of bad area, sig: 11 [#1]<br>MPC831x RDB<br>Modules lin=
ked in:<br><b>NIP: c0239c5c</b> LR: c024aaf8 CTR: 00000000<br>REGS: c7affcd=
0 TRAP: 0300=A0=A0 Not tainted=A0 (2.6.24.2)<br>MSR: 00009032 &lt;EE,ME,IR,=
DR&gt;=A0 CR: 24008424=A0 XER: 00000000<br>
DAR: 0000001c, DSISR: 20000000<br>TASK =3D c7889430[1536] &#39;comedi_confi=
g&#39; THREAD: c7afe000<br>GPR00: 0000ffff c7affd80 c7889430 c03f00e0 00000=
030 c0247d44 00000001 c03f00e0 <br>GPR08: c907a000 00000000 00000001 c78104=
00 c7900a00 1004a5b8 c033c200 c03c0000 <br>
GPR16: c03b83c4 c03cfa00 fffffff0 c7afff50 c03cfa00 00000040 00000010 c03a0=
ca0 <br>GPR24: c03f00e0 c03b2cf0 00000000 00000000 c7900800 c03d8628 ffffff=
f0 c03f00e0 <br>Call Trace:<br>[c7affd80] [c023c2d4]=A0 (unreliable)<br>[c7=
affda0] [c024aaf8] <br>
[c7affdd0] [c02376f8] <br>[c7affdf0] [c0237830] <br>[c7affe30] [c0237c50] <=
br>[c7affe40] [c023a5e8] <br>[c7affe70] [c0089820] <br>[c7affeb0] [c008ba50=
] <br>[c7affec0] [c00582d0] <br>[c7affee0] [c0049188] <br>[c7afff30] [c0009=
644] <br>
[c7afff40] [c0010ca4] <br>--- Exception: c01Instruction dump:<br>38210010 7=
c0803a6 4e800020 9421ffe0 7c0802a6 bf61000c 7c7f1b78 3bc0fff0 <br>90010024 =
38000000 6000ffff 81230010 &lt;8169001c&gt; 7f8b0000 419e001c 80010024 <br>
---[ end trace 78f6932e4d494a5a ]---<br><br>and I&#39;ve managed to trace t=
he fault<br><br>/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24=
-integration/drivers/xenomai/comedi/transfer.c:295<br>c0239c50:=A0=A0=A0 38=
 00 00 00 =A0=A0=A0 li=A0=A0=A0=A0=A0 r0,0<br>
c0239c54:=A0=A0=A0 60 00 ff ff =A0=A0=A0 ori=A0=A0=A0=A0 r0,r0,65535<br>c02=
39c58:=A0=A0=A0 81 23 00 10 =A0=A0=A0 lwz=A0=A0=A0=A0 r9,16(r3)<br><b>c0239=
c5c:=A0=A0=A0 81 69 00 1c =A0=A0=A0 lwz=A0=A0=A0=A0 r11,28(r9)</b><br>c0239=
c60:=A0=A0=A0 7f 8b 00 00 =A0=A0=A0 cmpw=A0=A0=A0 cr7,r11,r0<br>c0239c64:=
=A0=A0=A0 41 9e 00 1c =A0=A0=A0 beq-=A0=A0=A0 cr7,c0239c80 &lt;comedi_reque=
st_irq+0x48&gt;<br>
<br>What do you think ?<br><br><br><br><div class=3D"gmail_quote">On Thu, J=
un 4, 2009 at 3:23 AM, Alexis Berlemont <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:berlemont.hauw@domain.hid">berlemont.hauw@domain.hid</a>&gt;</span> wrote:<b=
r>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>
<div><div></div><div class=3D"h5"><br>
Alexis Berlemont &lt;<a href=3D"mailto:berlemont.hauw@domain.hid">berlemont.ha=
uw@domain.hid</a>&gt; writes:<br>
<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Wed, May 27, 2009 at 11:47 PM, Cristian Axenie<br>
&gt; &lt;<a href=3D"mailto:cristian.axenie@domain.hid">cristian.axenie@domain.hid=
.com</a>&gt; wrote:<br>
&gt;&gt; Hi!<br>
&gt;&gt;<br>
&gt;&gt; Without no modiffications (just some printks) I&#39;ve got a new t=
race pointing<br>
&gt;&gt; that the problem is at another location :<br>
&gt;&gt;<br>
&gt;&gt; and the location from the kernel dissasembly points to :<br>
&gt;&gt;<br>
&gt;&gt; /home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-prepar=
ed/drivers/xenomai/comedi/transfer.c:317<br>
&gt;&gt; c02399d8:=A0=A0=A0 38 00 00 00 =A0=A0=A0 li=A0=A0=A0=A0=A0 r0,0<br=
>
&gt;&gt; c02399dc:=A0=A0=A0 60 00 ff ff =A0=A0=A0 ori=A0=A0=A0=A0 r0,r0,655=
35<br>
&gt;&gt; c02399e0:=A0=A0=A0 81 23 00 08 =A0=A0=A0 lwz=A0=A0=A0=A0 r9,8(r3)<=
br>
&gt;&gt; c02399e4:=A0=A0=A0 81 69 00 1c =A0=A0=A0 lwz=A0=A0=A0=A0 r11,28(r9=
)<br>
&gt;&gt; c02399e8:=A0=A0=A0 7f 8b 00 00 =A0=A0=A0 cmpw=A0=A0=A0 cr7,r11,r0<=
br>
&gt;&gt; c02399ec:=A0=A0=A0 41 9e 00 1c =A0=A0=A0 beq-=A0=A0=A0 cr7,c0239a0=
8 &lt;comedi_request_irq+0x48&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Do you have any idea what is the source for this random erroneous =
behaviour<br>
&gt;&gt; ?<br>
&gt;<br>
&gt; Ok. Thanks, I will have a look at that location. By the way, I think<b=
r>
&gt; there was another mistake (I made) in the attach procedure<br>
&gt; (comedi_init_drv() called twice).<br>
&gt;<br>
&gt; But do not expect any git update today, I am unavailable until tonight=
.<br>
<br>
</div></div>I updated my git repository (comedi branch). Could you test it?=
<br>
<font color=3D"#888888"><br>
Alexis.<br>
</font></blockquote></div><br>

--0016e6d376611c5740046b81731a--

