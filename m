MIME-Version: 1.0
In-Reply-To: <9c789a000905261525q45cbaa3ag25855befde1cb130@domain.hid>
References: <9c789a000905250446t78fd6b38x1a6f28e35b70d7d6@domain.hid>
	<878wkkzxba.fsf@domain.hid>
	<9c789a000905251435p6f851d21v617c7e26a971f143@domain.hid>
	<871vqczveh.fsf@domain.hid>
	<9c789a000905251516j5272ae7bpc60aea8fdc17d50c@domain.hid>
	<9c789a000905251532i4775d796x8f095503a203e5bb@domain.hid>
	<72cf3fb0905260655g3e6942c5va7bc032f1cb5f35@domain.hid>
	<9c789a000905260736t241467ax805c4823b0d58ff5@domain.hid>
	<1243374524.22014.74.camel@domain.hid>
	<9c789a000905261525q45cbaa3ag25855befde1cb130@domain.hid>
Date: Wed, 27 May 2009 01:31:16 +0300
Message-ID: <9c789a000905261531m67dee7dah9740d825cce04cbc@domain.hid>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=001636c599a6f38072046ad848cf
Subject: [Xenomai-help] Fwd:  Driver testing procedure ?!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, Alexis Berlemont <berlemont.hauw@domain.hid>

--001636c599a6f38072046ad848cf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

So I've managed to spot the location

c023923c <comedi_ioctl_chaninfo>:
comedi_ioctl_chaninfo():
/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-prepared/drivers/xenomai/comedi/subdevice.c:216
c023923c:    94 21 ff d0     stwu    r1,-48(r1)
c0239240:    7c 08 02 a6     mflr    r0
c0239244:    bf 81 00 20     stmw    r28,32(r1)
c0239248:    90 01 00 34     stw     r0,52(r1)
/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-prepared/drivers/xenomai/comedi/subdevice.c:218
c023924c:    83 e3 00 00     lwz     r31,0(r3)

And now ?


On Wed, May 27, 2009 at 12:48 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Tue, 2009-05-26 at 17:36 +0300, Cristian Axenie wrote:
>
> > Unable to handle kernel paging request for data at address 0x0000001c
> > Faulting instruction address: 0xc023923c
> > Oops: Kernel access of bad area, sig: 11 [#1]
> > MPC831x RDB
> > Modules linked in:
> > NIP: c023923c LR: c0249c2c CTR: c01bd8b4
>
> Please compile your kernel with CONFIG_DEBUG_INFO enabled. Then, from
> the root of your kernel tree, get a disassembly of the entire kernel:
>
> # ppc_6xx-objdump -dl vmlinux > foo.s
> (this may take a while)
>
> NIP is the code location your ppc kernel was attempting to execute from
> before jumping out of the window, so find the assembly line the NIP
> register value points at (leftmost field of the output), and post back
> the disassembly of the entire enclosing function. TIA,
>
> --
> Philippe.
>
>
>

--001636c599a6f38072046ad848cf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>So I&#39;ve managed to spot the location<br><div class=3D"gmail_quote">=
<br>c023923c &lt;comedi_ioctl_chaninfo&gt;:<br>comedi_ioctl_chaninfo():<br>=
/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-prepared/driver=
s/xenomai/comedi/subdevice.c:216<br>

c023923c:=A0=A0=A0 94 21 ff d0 =A0=A0=A0 stwu=A0=A0=A0 r1,-48(r1)<br>c02392=
40:=A0=A0=A0 7c 08 02 a6 =A0=A0=A0 mflr=A0=A0=A0 r0<br>c0239244:=A0=A0=A0 b=
f 81 00 20 =A0=A0=A0 stmw=A0=A0=A0 r28,32(r1)<br>c0239248:=A0=A0=A0 90 01 0=
0 34 =A0=A0=A0 stw=A0=A0=A0=A0 r0,52(r1)<br>/home/haustiq/development/eldk/=
ppc_6xx/usr/src/linux-2.6.24-prepared/drivers/xenomai/comedi/subdevice.c:21=
8<br>

c023924c:=A0=A0=A0 83 e3 00 00 =A0=A0=A0 lwz=A0=A0=A0=A0 r31,0(r3)<br><br>A=
nd now ?<div><div></div><div class=3D"h5"><br><br><div class=3D"gmail_quote=
">On Wed, May 27, 2009 at 12:48 AM, Philippe Gerum <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:rpm@xenomai.org" target=3D"_blank">rpm@xenomai.org</a>&gt;<=
/span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>On Tue, 2009=
-05-26 at 17:36 +0300, Cristian Axenie wrote:<br>
<br>
&gt; Unable to handle kernel paging request for data at address 0x0000001c<=
br>
&gt; Faulting instruction address: 0xc023923c<br>
&gt; Oops: Kernel access of bad area, sig: 11 [#1]<br>
&gt; MPC831x RDB<br>
&gt; Modules linked in:<br>
&gt; NIP: c023923c LR: c0249c2c CTR: c01bd8b4<br>
<br>
</div>Please compile your kernel with CONFIG_DEBUG_INFO enabled. Then, from=
<br>
the root of your kernel tree, get a disassembly of the entire kernel:<br>
<br>
# ppc_6xx-objdump -dl vmlinux &gt; foo.s<br>
(this may take a while)<br>
<br>
NIP is the code location your ppc kernel was attempting to execute from<br>
before jumping out of the window, so find the assembly line the NIP<br>
register value points at (leftmost field of the output), and post back<br>
the disassembly of the entire enclosing function. TIA,<br>
<br>
--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>
</div></div></div><br>

--001636c599a6f38072046ad848cf--

