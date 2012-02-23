MIME-Version: 1.0
In-Reply-To: <4F3AAA52.6060802@domain.hid>
References: <CAHOEnGfih5tin7NAnf-qU6tKxVtnb=LjuBFE5QxFQpxfA=EBkg@domain.hid>
	<CAHOEnGdKstVsBUKnQcCm3NK4BfngnGOAKfimXA5VL=ujUzR2ig@domain.hid>
	<4F3AAA52.6060802@domain.hid>
From: =?ISO-8859-1?Q?Oscar_D=E1vila?= <odavilar@domain.hid>
Date: Thu, 23 Feb 2012 16:43:34 -0600
Message-ID: <CAHOEnGdzwe3gj5c_PAkqBHsYCz=-+McZkDTz7kSOLUQyVDVDyg@domain.hid>
Content-Type: multipart/alternative; boundary=e89a8ff25008f557fc04b9a96053
Subject: Re: [Xenomai-help] Freeze while running examples
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--e89a8ff25008f557fc04b9a96053
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2012/2/14 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 02/14/2012 06:54 PM, Oscar D=E1vila wrote:
> > I compiled Xenomai succesfully, but when i try to run an example it
> freezes
> > / machine look up, any help will be apreciated, thanks.
> >
> > Here is some info about the system, its a Debian 6.0 with a
> > kernel 2.6.35.9, xenomai-2.6.0, the adeos
> > patch adeos-ipipe-2.6.35.9-x86-2.8-04.patch and Im also using the
> > nmi_watchdog=3D2 in the boot kernel options.
>
> Please reproduce the bug:
> - in text mode, so as to have the full bug trace;
> - with frame pointers enabled;
> - with highest kernel verbosity for BUGs and backtraces.
>

How do i do this last point? i mean, i already compile kernel with frame
pointers enabled, also i already ran it in text mode, and i active all the
xenomai debug kernel options. i saw some other debug options in kernel
hacking, do i have to active those ones too?


> And post the full bug text here.
>
>
This is what i have about the bug until now

Feb 23 16:37:31 Micromaquina kernel: [   74.218448] BUG: NMI Watchdog
detected LOCKUP on CPU0, ip c106d5e1, registers:
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] Modules linked in:
sco ppdev bridge stp lp bnep l2cap crc16 bluetooth rfkill binfmt_misc
fuse loop snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm_oss
snd_mixer_oss snd_pcm snd_seq_midi snd_rawmidi snd_seq_midi_event
snd_seq snd_timer snd_seq_device snd soundcore snd_page_alloc
parport_pc parport rng_core i2c_i801 i2c_core evdev tpm_tis tpm
psmouse serio_raw ext3 jbd mbcache usbhid hid sg sr_mod sd_mod
crc_t10dif cdrom ata_generic uhci_hcd ehci_hcd ata_piix libata tg3
usbcore scsi_mod floppy libphy nls_base [last unloaded:
scsi_wait_scan]
Feb 23 16:37:31 Micromaquina kernel: [   74.218448]
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] Pid: 1624, comm:
ex01 Not tainted 2.6.35.9-xenomai-2.6.0-1 #2 IBM/8143PSR
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] EIP:
0060:[<c106d5e1>] EFLAGS: 00000002 CPU: 0
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] EIP is at
__ipipe_sync_stage+0x12b/0x181
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] EAX: ddf22000 EBX:
00000521 ECX: ddf38c90 EDX: c1467600
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] ESI: c14ef680 EDI:
00000523 EBP: ddf23f98 ESP: ddf23f64
Feb 23 16:37:31 Micromaquina kernel: [   74.218448]  DS: 007b ES: 007b
FS: 00d8 GS: 0033 SS: 0068
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] Process ex01 (pid:
1624, ti=3Dddf22000 task=3Dddf38c90 task.ti=3Dddf22000)
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] I-pipe domain Linux
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] Stack:
Feb 23 16:37:31 Micromaquina kernel: [   74.218448]  ffffffff c14ef680
c10983b4 c145dcf4 00000520 c14ef684 c1c03cf8 c1c03cfc
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] <0> c1c03d04
c145d02c ddf23fb4 00000282 00000001 ddf23fac c101944d 080499c4
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] <0> 00000000
00000000 ddf22000 c12821e9 080499c4 080486a4 00000000 00000000
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] Call Trace:
Feb 23 16:37:31 Micromaquina kernel: [   74.218448]  [<c10983b4>] ?
hisyscall_event+0x0/0x2b2
Feb 23 16:37:31 Micromaquina kernel: [   74.218448]  [<c101944d>] ?
__ipipe_syscall_root+0xd9/0xe8
Feb 23 16:37:31 Micromaquina kernel: [   74.218448]  [<c12821e9>] ?
system_call+0x2d/0x4f
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] Code: e8 e0 25 fc
ff 89 f9 c1 e1 07 8b 91 8c f6 4e c1 89 d8 ff 91 88 f6 4e c1 e8 9f 28
fc ff fa 89 e0 25 00 e0 ff ff 83 78 14 00 75 58 <f6> 40 08 08 74 52 eb
f8 c1 e7 07 8b 97 88 f6 4e c1 64 8b 3d 14
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] ---[ end trace
70702f8bd6889fa0 ]---


Alternatively, if you have another computer, you can redirect the
> console on a serial port (see Documentation/serial-console.txt in the
> kernel sources) or via network (see
> Documentation/networking/netconsole.txt in the kernel sources). This
> will allow handling traces which are larger than a screen.
>
> --
>                                            Gilles.
>
>
Thanks

--=20
Atentamente:
Oscar D=E1vila Ram=EDrez

--e89a8ff25008f557fc04b9a96053
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2012/2/14 Gilles Chanteperdrix <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div class=3D"im">On 02/14/2012 06:54 PM, Oscar D=E1vila wrote:<br>
&gt; I compiled Xenomai succesfully, but when i try to run an example it fr=
eezes<br>
&gt; / machine look up, any help will be apreciated, thanks.<br>
&gt;<br>
&gt; Here is some info about the system, its a Debian 6.0 with a<br>
&gt; kernel 2.6.35.9, xenomai-2.6.0, the adeos<br>
&gt; patch adeos-ipipe-2.6.35.9-x86-2.8-04.patch and Im also using the<br>
&gt; nmi_watchdog=3D2 in the boot kernel options.<br>
<br>
</div>Please reproduce the bug:<br>
- in text mode, so as to have the full bug trace;<br>
- with frame pointers enabled;<br>
- with highest kernel verbosity for BUGs and backtraces.<br></blockquote><d=
iv><br></div><div>How do i do this last point? i mean, i already compile ke=
rnel with frame pointers enabled, also i already ran it in text mode, and i=
 active all the xenomai debug kernel options. i saw some other debug option=
s in kernel hacking, do i have to active those ones too?</div>

<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
<br>
And post the full bug text here.<br>
<br></blockquote><div>=A0</div><div>This is what i have about the bug until=
 now</div><pre style=3D"word-wrap:break-word;white-space:pre-wrap">Feb 23 1=
6:37:31 Micromaquina kernel: [   74.218448] BUG: NMI Watchdog detected LOCK=
UP on CPU0, ip c106d5e1, registers:
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] Modules linked in: sco =
ppdev bridge stp lp bnep l2cap crc16 bluetooth rfkill binfmt_misc fuse loop=
 snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd=
_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device s=
nd soundcore snd_page_alloc parport_pc parport rng_core i2c_i801 i2c_core e=
vdev tpm_tis tpm psmouse serio_raw ext3 jbd mbcache usbhid hid sg sr_mod sd=
_mod crc_t10dif cdrom ata_generic uhci_hcd ehci_hcd ata_piix libata tg3 usb=
core scsi_mod floppy libphy nls_base [last unloaded: scsi_wait_scan]
Feb 23 16:37:31 Micromaquina kernel: [   74.218448]=20
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] Pid: 1624, comm: ex01 N=
ot tainted 2.6.35.9-xenomai-2.6.0-1 #2 IBM/8143PSR
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] EIP: 0060:[&lt;c106d5e1=
&gt;] EFLAGS: 00000002 CPU: 0
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] EIP is at __ipipe_sync_=
stage+0x12b/0x181
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] EAX: ddf22000 EBX: 0000=
0521 ECX: ddf38c90 EDX: c1467600
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] ESI: c14ef680 EDI: 0000=
0523 EBP: ddf23f98 ESP: ddf23f64
Feb 23 16:37:31 Micromaquina kernel: [   74.218448]  DS: 007b ES: 007b FS: =
00d8 GS: 0033 SS: 0068
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] Process ex01 (pid: 1624=
, ti=3Dddf22000 task=3Dddf38c90 task.ti=3Dddf22000)
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] I-pipe domain Linux
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] Stack:
Feb 23 16:37:31 Micromaquina kernel: [   74.218448]  ffffffff c14ef680 c109=
83b4 c145dcf4 00000520 c14ef684 c1c03cf8 c1c03cfc
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] &lt;0&gt; c1c03d04 c145=
d02c ddf23fb4 00000282 00000001 ddf23fac c101944d 080499c4
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] &lt;0&gt; 00000000 0000=
0000 ddf22000 c12821e9 080499c4 080486a4 00000000 00000000
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] Call Trace:
Feb 23 16:37:31 Micromaquina kernel: [   74.218448]  [&lt;c10983b4&gt;] ? h=
isyscall_event+0x0/0x2b2
Feb 23 16:37:31 Micromaquina kernel: [   74.218448]  [&lt;c101944d&gt;] ? _=
_ipipe_syscall_root+0xd9/0xe8
Feb 23 16:37:31 Micromaquina kernel: [   74.218448]  [&lt;c12821e9&gt;] ? s=
ystem_call+0x2d/0x4f
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] Code: e8 e0 25 fc ff 89=
 f9 c1 e1 07 8b 91 8c f6 4e c1 89 d8 ff 91 88 f6 4e c1 e8 9f 28 fc ff fa 89=
 e0 25 00 e0 ff ff 83 78 14 00 75 58 &lt;f6&gt; 40 08 08 74 52 eb f8 c1 e7 =
07 8b 97 88 f6 4e c1 64 8b 3d 14=20
Feb 23 16:37:31 Micromaquina kernel: [   74.218448] ---[ end trace 70702f8b=
d6889fa0 ]---=A0=A0</pre><pre style=3D"word-wrap:break-word;white-space:pre=
-wrap"><br></pre><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">


Alternatively, if you have another computer, you can redirect the<br>
console on a serial port (see Documentation/serial-console.txt in the<br>
kernel sources) or via network (see<br>
Documentation/networking/netconsole.txt in the kernel sources). This<br>
will allow handling traces which are larger than a screen.<br>
<font color=3D"#888888"><br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.<br>
<br>
</font></blockquote></div><br>Thanks<br clear=3D"all"><div><br></div>-- <br=
><div>Atentamente:<br>Oscar D=E1vila Ram=EDrez<br></div><br>

--e89a8ff25008f557fc04b9a96053--

