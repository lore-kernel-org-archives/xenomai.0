MIME-Version: 1.0
In-Reply-To: <9c789a000905261535v56d5ac5i4fa1a41f4e678849@domain.hid>
References: <9c789a000905250446t78fd6b38x1a6f28e35b70d7d6@domain.hid>
	<871vqczveh.fsf@domain.hid>
	<9c789a000905251516j5272ae7bpc60aea8fdc17d50c@domain.hid>
	<9c789a000905251532i4775d796x8f095503a203e5bb@domain.hid>
	<72cf3fb0905260655g3e6942c5va7bc032f1cb5f35@domain.hid>
	<9c789a000905260736t241467ax805c4823b0d58ff5@domain.hid>
	<1243374524.22014.74.camel@domain.hid>
	<9c789a000905261525q45cbaa3ag25855befde1cb130@domain.hid>
	<9c789a000905261531m67dee7dah9740d825cce04cbc@domain.hid>
	<9c789a000905261535v56d5ac5i4fa1a41f4e678849@domain.hid>
Date: Thu, 28 May 2009 00:47:35 +0300
Message-ID: <9c789a000905271447i3998c3d3xf5ce93d1d8783031@domain.hid>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5a72e9ef76c046aebca41
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
To: xenomai@xenomai.org, Alexis Berlemont <berlemont.hauw@domain.hid>

--001636c5a72e9ef76c046aebca41
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi!

Without no modiffications (just some printks) I've got a new trace pointing
that the problem is at another location :

/usr/xenomai/sbin # gdb comedi_config
GNU gdb Red Hat Linux (6.7-1rh)
Copyright (C) 2007 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html
>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "ppc-linux"...
Using host libthread_db library "/lib/libthread_db.so.1".
(gdb) run comedi0 pcimio
Starting program: /usr/xenomai/sbin/comedi_config comedi0 pcimio
[Thread debugging using libthread_db enabled]
[New Thread 0x4801ea60 (LWP 907)]
pcimio_attach: found pci-6024e board
MITE: 0x90000000 mapped to c907a000 DAQ: 0x90001000 mapped to c907c000
MITE: version = 2, type = 1, mite mode = 1, interface mode = 3
MITE: num channels = 1, write post fifo depth = 1, wins = 0, iowins = 2
pcimio_attach: found irq 48
Unable to handle kernel paging request for data at address 0x0000001c
Faulting instruction address: 0xc02399e4
Oops: Kernel access of bad area, sig: 11 [#1]
MPC831x RDB
Modules linked in:
*NIP: c02399e4* LR: c024a4d8 CTR: c003218c
REGS: c7ad3cd0 TRAP: 0300   Not tainted  (2.6.24.2)
MSR: 00009032 <EE,ME,IR,DR>  CR: 24008422  XER: 00000000
DAR: 0000001c, DSISR: 20000000
TASK = c7889430[907] 'comedi_config' THREAD: c7ad2000
GPR00: 0000ffff c7ad3d80 c7889430 c03ee0e0 00000030 c024759c 00000001
c03ee0e0
GPR08: 0d293884 00000000 00000003 c039fd20 24008424 1004a5b8 00000000
c03b0000
GPR16: c03b72ac c03cda00 fffffff0 c7ad3f50 c03cda00 00000040 c7ad3e48
c03ee0e0
GPR24: c03b1f98 c03b1bd8 00000000 c03d6628 c7900810 c7900c10 fffffff0
c03ee0e0
Call Trace:
[c7ad3d80] [00000001]  (unreliable)
[c7ad3da0] [c024a4d8]
[c7ad3dd0] [c0237410]
[c7ad3df0] [c0237548]
[c7ad3e30] [c0237958]
[c7ad3e40] [c023a420]
[c7ad3e70] [c00895b8]
[c7ad3eb0] [c008b7e8]
[c7ad3ec0] [c0057de0]
[c7ad3ee0] [c0049188]
[c7ad3f30] [c0009644]
[c7ad3f40] [c0010ca4]
--- Exception: c01Instruction dump:
38210010 7c0803a6 4e800020 9421ffe0 7c0802a6 bf61000c 7c7f1b78 3bc0fff0
90010024 38000000 6000ffff 81230008 <8169001c> 7f8b0000 419e001c 80010024
---[ end trace fed837f399783f24 ]---


and the location from the kernel dissasembly points to :

/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-prepared/drivers/xenomai/comedi/transfer.c:317
c02399d8:    38 00 00 00     li      r0,0
c02399dc:    60 00 ff ff     ori     r0,r0,65535
c02399e0:    81 23 00 08     lwz     r9,8(r3)
*c02399e4:    81 69 00 1c     lwz     r11,28(r9)*
c02399e8:    7f 8b 00 00     cmpw    cr7,r11,r0
c02399ec:    41 9e 00 1c     beq-    cr7,c0239a08 <comedi_request_irq+0x48>


Do you have any idea what is the source for this random erroneous behaviour
?

Best !
On Wed, May 27, 2009 at 1:35 AM, Cristian Axenie
<cristian.axenie@domain.hid>wrote:

>
> So I've managed to spot the location
>
> c023923c <comedi_ioctl_chaninfo>:
> comedi_ioctl_chaninfo():
>
> /home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-prepared/drivers/xenomai/comedi/subdevice.c:216
> c023923c:    94 21 ff d0     stwu    r1,-48(r1)
> c0239240:    7c 08 02 a6     mflr    r0
> c0239244:    bf 81 00 20     stmw    r28,32(r1)
> c0239248:    90 01 00 34     stw     r0,52(r1)
>
> /home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-prepared/drivers/xenomai/comedi/subdevice.c:218
> c023924c:    83 e3 00 00     lwz     r31,0(r3)
>
> And now ?
>
>
> On Wed, May 27, 2009 at 12:48 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>
>> On Tue, 2009-05-26 at 17:36 +0300, Cristian Axenie wrote:
>>
>> > Unable to handle kernel paging request for data at address 0x0000001c
>> > Faulting instruction address: 0xc023923c
>> > Oops: Kernel access of bad area, sig: 11 [#1]
>> > MPC831x RDB
>> > Modules linked in:
>> > NIP: c023923c LR: c0249c2c CTR: c01bd8b4
>>
>> Please compile your kernel with CONFIG_DEBUG_INFO enabled. Then, from
>> the root of your kernel tree, get a disassembly of the entire kernel:
>>
>> # ppc_6xx-objdump -dl vmlinux > foo.s
>> (this may take a while)
>>
>> NIP is the code location your ppc kernel was attempting to execute from
>> before jumping out of the window, so find the assembly line the NIP
>> register value points at (leftmost field of the output), and post back
>> the disassembly of the entire enclosing function. TIA,
>>
>> --
>> Philippe.
>>
>>
>>
>
>
>

--001636c5a72e9ef76c046aebca41
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi!<br><br>Without no modiffications (just some printks) I&#39;ve got a new=
 trace pointing that the problem is at another location :<br><br>/usr/xenom=
ai/sbin # gdb comedi_config <br>GNU gdb Red Hat Linux (6.7-1rh)<br>Copyrigh=
t (C) 2007 Free Software Foundation, Inc.<br>
License GPLv3+: GNU GPL version 3 or later &lt;<a href=3D"http://gnu.org/li=
censes/gpl.html">http://gnu.org/licenses/gpl.html</a>&gt;<br>This is free s=
oftware: you are free to change and redistribute it.<br>There is NO WARRANT=
Y, to the extent permitted by law.=A0 Type &quot;show copying&quot;<br>
and &quot;show warranty&quot; for details.<br>This GDB was configured as &q=
uot;ppc-linux&quot;...<br>Using host libthread_db library &quot;/lib/libthr=
ead_db.so.1&quot;.<br>(gdb) run comedi0 pcimio<br>Starting program: /usr/xe=
nomai/sbin/comedi_config comedi0 pcimio<br>
[Thread debugging using libthread_db enabled]<br>[New Thread 0x4801ea60 (LW=
P 907)]<br>pcimio_attach: found pci-6024e board<br>MITE: 0x90000000 mapped =
to c907a000 DAQ: 0x90001000 mapped to c907c000<br>MITE: version =3D 2, type=
 =3D 1, mite mode =3D 1, interface mode =3D 3<br>
MITE: num channels =3D 1, write post fifo depth =3D 1, wins =3D 0, iowins =
=3D 2<br>pcimio_attach: found irq 48<br>Unable to handle kernel paging requ=
est for data at address 0x0000001c<br>Faulting instruction address: 0xc0239=
9e4<br>
Oops: Kernel access of bad area, sig: 11 [#1]<br>MPC831x RDB<br>Modules lin=
ked in:<br><b>NIP: c02399e4</b> LR: c024a4d8 CTR: c003218c<br>REGS: c7ad3cd=
0 TRAP: 0300=A0=A0 Not tainted=A0 (2.6.24.2)<br>MSR: 00009032 &lt;EE,ME,IR,=
DR&gt;=A0 CR: 24008422=A0 XER: 00000000<br>
DAR: 0000001c, DSISR: 20000000<br>TASK =3D c7889430[907] &#39;comedi_config=
&#39; THREAD: c7ad2000<br>GPR00: 0000ffff c7ad3d80 c7889430 c03ee0e0 000000=
30 c024759c 00000001 c03ee0e0 <br>GPR08: 0d293884 00000000 00000003 c039fd2=
0 24008424 1004a5b8 00000000 c03b0000 <br>
GPR16: c03b72ac c03cda00 fffffff0 c7ad3f50 c03cda00 00000040 c7ad3e48 c03ee=
0e0 <br>GPR24: c03b1f98 c03b1bd8 00000000 c03d6628 c7900810 c7900c10 ffffff=
f0 c03ee0e0 <br>Call Trace:<br>[c7ad3d80] [00000001]=A0 (unreliable)<br>[c7=
ad3da0] [c024a4d8] <br>
[c7ad3dd0] [c0237410] <br>[c7ad3df0] [c0237548] <br>[c7ad3e30] [c0237958] <=
br>[c7ad3e40] [c023a420] <br>[c7ad3e70] [c00895b8] <br>[c7ad3eb0] [c008b7e8=
] <br>[c7ad3ec0] [c0057de0] <br>[c7ad3ee0] [c0049188] <br>[c7ad3f30] [c0009=
644] <br>
[c7ad3f40] [c0010ca4] <br>--- Exception: c01Instruction dump:<br>38210010 7=
c0803a6 4e800020 9421ffe0 7c0802a6 bf61000c 7c7f1b78 3bc0fff0 <br>90010024 =
38000000 6000ffff 81230008 &lt;8169001c&gt; 7f8b0000 419e001c 80010024 <br>
---[ end trace fed837f399783f24 ]---<br><br><br>and the location from the k=
ernel dissasembly points to :<br><br>/home/haustiq/development/eldk/ppc_6xx=
/usr/src/linux-2.6.24-prepared/drivers/xenomai/comedi/transfer.c:317<br>
c02399d8:=A0=A0=A0 38 00 00 00 =A0=A0=A0 li=A0=A0=A0=A0=A0 r0,0<br>c02399dc=
:=A0=A0=A0 60 00 ff ff =A0=A0=A0 ori=A0=A0=A0=A0 r0,r0,65535<br>c02399e0:=
=A0=A0=A0 81 23 00 08 =A0=A0=A0 lwz=A0=A0=A0=A0 r9,8(r3)<br><b>c02399e4:=A0=
=A0=A0 81 69 00 1c =A0=A0=A0 lwz=A0=A0=A0=A0 r11,28(r9)</b><br>c02399e8:=A0=
=A0=A0 7f 8b 00 00 =A0=A0=A0 cmpw=A0=A0=A0 cr7,r11,r0<br>
c02399ec:=A0=A0=A0 41 9e 00 1c =A0=A0=A0 beq-=A0=A0=A0 cr7,c0239a08 &lt;com=
edi_request_irq+0x48&gt;<br><br><br>Do you have any idea what is the source=
 for this random erroneous behaviour ?<br><br>Best !<br><div class=3D"gmail=
_quote">On Wed, May 27, 2009 at 1:35 AM, Cristian Axenie <span dir=3D"ltr">=
&lt;<a href=3D"mailto:cristian.axenie@domain.hid">cristian.axenie@domain.hid<=
/a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"h5"><div class=3D"gmail_quote"><div><div></div><div><br>So I&#=
39;ve managed to spot the location<br>
<div class=3D"gmail_quote"><br>c023923c &lt;comedi_ioctl_chaninfo&gt;:<br>c=
omedi_ioctl_chaninfo():<br>/home/haustiq/development/eldk/ppc_6xx/usr/src/l=
inux-2.6.24-prepared/drivers/xenomai/comedi/subdevice.c:216<br>


c023923c:=A0=A0=A0 94 21 ff d0 =A0=A0=A0 stwu=A0=A0=A0 r1,-48(r1)<br>c02392=
40:=A0=A0=A0 7c 08 02 a6 =A0=A0=A0 mflr=A0=A0=A0 r0<br>c0239244:=A0=A0=A0 b=
f 81 00 20 =A0=A0=A0 stmw=A0=A0=A0 r28,32(r1)<br>c0239248:=A0=A0=A0 90 01 0=
0 34 =A0=A0=A0 stw=A0=A0=A0=A0 r0,52(r1)<br>/home/haustiq/development/eldk/=
ppc_6xx/usr/src/linux-2.6.24-prepared/drivers/xenomai/comedi/subdevice.c:21=
8<br>



c023924c:=A0=A0=A0 83 e3 00 00 =A0=A0=A0 lwz=A0=A0=A0=A0 r31,0(r3)<br><br>A=
nd now ?<div><div></div><div><br><br><div class=3D"gmail_quote">On Wed, May=
 27, 2009 at 12:48 AM, Philippe Gerum <span dir=3D"ltr">&lt;<a href=3D"mail=
to:rpm@xenomai.org" target=3D"_blank">rpm@xenomai.org</a>&gt;</span> wrote:=
<br>



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
</div></div></div><br>
</div></div></blockquote></div><br>

--001636c5a72e9ef76c046aebca41--

