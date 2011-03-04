MIME-Version: 1.0
In-Reply-To: <4D7135B5.5050307@domain.hid>
References: <AANLkTinnqCe1aJzfsJMGApD2De7NAk1hhOYAWqKdJfAL@mail.gmail.com>
	<4D70FC9A.7040007@domain.hid>
	<AANLkTinNtpWXzaggXX_g9Z+U0TqWP6iLHW_m=FqJbtUk@domain.hid>
	<4D712706.2020202@domain.hid> <4D71282A.7060108@domain.hid>
	<AANLkTi=V1J0Z8wWZw92KABdAVczYoFEPZOZHBmE8zO-a@domain.hid>
	<AANLkTimAv5kTkQH2xeKBiCjZ0uywtBq-DaXZwrDgLK9v@domain.hid>
	<4D7135B5.5050307@domain.hid>
Date: Fri, 4 Mar 2011 14:39:54 -0500
Message-ID: <AANLkTino54anEm0oYjBnUScRtxg3Oa_E4-uQnZjF1crT@mail.gmail.com>
From: Jeff Hyams <jeff.hyams@domain.hid>
Content-Type: multipart/mixed; boundary=0015175771dc6b29eb049dad4fc1
Subject: Re: [Xenomai-help] xenomai patched kernel "laggy"
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

--0015175771dc6b29eb049dad4fc1
Content-Type: multipart/alternative; boundary=0015175771dc6b29e4049dad4fbf

--0015175771dc6b29e4049dad4fbf
Content-Type: text/plain; charset=ISO-8859-1

Ok, that makes sense.  For the SMI issue, would you recommend just going
through all of them one by one to see which one is not working, or should I
just not enable the SMI workaround?

For the second issue, do you have a recommendation for stopping it from
crashing out like that?

Also attached the correct irq and interupts files.

I really appreciate the help.

Thanks,

Jeff Hyams


On Fri, Mar 4, 2011 at 1:55 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Jeff Hyams wrote:
> > Here's the dmesg output with quiet disabled for just the boot.  I also
> > included a clean syslog from just this boot.
> >
> > Also re-attached the config file so they'd all be together.
> >
> > Sorry for not parsing everything out before.
>
> The dmesg you sent does not correspond to /proc/interrupts and /proc/irq.
>
> Anyway, you have:
> [    3.345790] Xenomai: SMI-enabled chipset found
> [    3.345851] Xenomai: SMI workaround failed!
>
> So, you may have an issue with SMIs.
>
> And you have this:
> [  129.882571] irq 16: nobody cared (try booting with the "irqpoll" option)
> [  129.882578] Pid: 0, comm: swapper Not tainted
> 2.6.32.20-xenomai-2.5.5.2 #1
> [  129.882581] Call Trace:
> [  129.882583]  <IRQ>  [<ffffffff810b084b>] __report_bad_irq+0x2b/0xa0
> [  129.882596]  [<ffffffff810b0a4c>] note_interrupt+0x18c/0x1d0
> [  129.882601]  [<ffffffff810b13cd>] handle_fasteoi_irq+0xbd/0xe0
> [  129.882606]  [<ffffffff8100f022>] handle_irq+0x22/0x30
> [  129.882613]  [<ffffffff81542559>] do_IRQ+0x79/0x110
> [  129.882621]  [<ffffffff810b6d76>] __ipipe_sync_stage+0x226/0x22c
> [  129.882623]  [<ffffffff815424e0>] ? do_IRQ+0x0/0x110
> [  129.882625]  [<ffffffff810b6d7c>] ? __xirq_end+0x0/0x9d
> [  129.882627]  [<ffffffff815424e0>] ? do_IRQ+0x0/0x110
> [  129.882629]  [<ffffffff810b7200>] __ipipe_walk_pipeline+0x100/0x110
> [  129.882634]  [<ffffffff81029cf4>] __ipipe_handle_irq+0x134/0x320
> [  129.882636]  [<ffffffff810b0c10>] ? __ipipe_ack_fasteoi_irq+0x0/0x20
> [  129.882640]  [<ffffffff8100cad3>] common_interrupt+0x13/0x2c
> [  129.882641]  <EOI>  [<ffffffff8102a2eb>] ? __ipipe_halt_root+0x2b/0x40
> [  129.882645]  [<ffffffff810143fd>] ? default_idle+0x3d/0x90
> [  129.882647]  [<ffffffff8100ae64>] ? cpu_idle+0x74/0xd0
> [  129.882650]  [<ffffffff81537647>] ? start_secondary+0x19f/0x1a4
> [  129.882652] handlers:
> [  129.882652] [<ffffffff813da670>] (usb_hcd_irq+0x0/0xb0)
> [  129.882656] [<ffffffffa0099cc0>] (mpt_interrupt+0x0/0xa00 [mptbase])
> [  129.882668] [<ffffffffa0179410>] (azx_interrupt+0x0/0x170
> [snd_hda_intel])
> [  129.882671] Disabling IRQ #16
> [  188.244706] hda-intel: IRQ timing workaround is activated for card
> #0. Suggest a bigger bdl_pos_adj.
>
> So, your system is running without an IRQ for three drivers. This may
> cause, say, the keyboard driver to be in "polling" mode, and so appear
> to be very slow.
>
>
> --
>                                                                 Gilles.
>

--0015175771dc6b29e4049dad4fbf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ok, that makes sense.=A0 For the SMI issue, would you recommend just going
 through all of them one by one to see which one is not working, or=20
should I just not enable the SMI workaround?<br>
<br>
For the second issue, do you have a recommendation for stopping it from cra=
shing out like that? <br>

<br>

Also attached the correct irq and interupts files.<br>

<br>

I really appreciate the help.<br>

<br>
Thanks,<br>
<br>
Jeff Hyams<br><br><br><div class=3D"gmail_quote">On Fri, Mar 4, 2011 at 1:5=
5 PM, Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.c=
hanteperdrix@domain.hid" target=3D"_blank">gilles.chanteperdrix@xenomai.org=
g</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div>Jeff Hyams w=
rote:<br>
&gt; Here&#39;s the dmesg output with quiet disabled for just the boot. =A0=
I also<br>
&gt; included a clean syslog from just this boot.<br>
&gt;<br>
&gt; Also re-attached the config file so they&#39;d all be together.<br>
&gt;<br>
&gt; Sorry for not parsing everything out before.<br>
<br>
</div>The dmesg you sent does not correspond to /proc/interrupts and /proc/=
irq.<br>
<br>
Anyway, you have:<br>
[ =A0 =A03.345790] Xenomai: SMI-enabled chipset found<br>
[ =A0 =A03.345851] Xenomai: SMI workaround failed!<br>
<br>
So, you may have an issue with SMIs.<br>
<br>
And you have this:<br>
[ =A0129.882571] irq 16: nobody cared (try booting with the &quot;irqpoll&q=
uot; option)<br>
[ =A0129.882578] Pid: 0, comm: swapper Not tainted<br>
2.6.32.20-xenomai-2.5.5.2 #1<br>
[ =A0129.882581] Call Trace:<br>
[ =A0129.882583] =A0&lt;IRQ&gt; =A0[&lt;ffffffff810b084b&gt;] __report_bad_=
irq+0x2b/0xa0<br>
[ =A0129.882596] =A0[&lt;ffffffff810b0a4c&gt;] note_interrupt+0x18c/0x1d0<b=
r>
[ =A0129.882601] =A0[&lt;ffffffff810b13cd&gt;] handle_fasteoi_irq+0xbd/0xe0=
<br>
[ =A0129.882606] =A0[&lt;ffffffff8100f022&gt;] handle_irq+0x22/0x30<br>
[ =A0129.882613] =A0[&lt;ffffffff81542559&gt;] do_IRQ+0x79/0x110<br>
[ =A0129.882621] =A0[&lt;ffffffff810b6d76&gt;] __ipipe_sync_stage+0x226/0x2=
2c<br>
[ =A0129.882623] =A0[&lt;ffffffff815424e0&gt;] ? do_IRQ+0x0/0x110<br>
[ =A0129.882625] =A0[&lt;ffffffff810b6d7c&gt;] ? __xirq_end+0x0/0x9d<br>
[ =A0129.882627] =A0[&lt;ffffffff815424e0&gt;] ? do_IRQ+0x0/0x110<br>
[ =A0129.882629] =A0[&lt;ffffffff810b7200&gt;] __ipipe_walk_pipeline+0x100/=
0x110<br>
[ =A0129.882634] =A0[&lt;ffffffff81029cf4&gt;] __ipipe_handle_irq+0x134/0x3=
20<br>
[ =A0129.882636] =A0[&lt;ffffffff810b0c10&gt;] ? __ipipe_ack_fasteoi_irq+0x=
0/0x20<br>
[ =A0129.882640] =A0[&lt;ffffffff8100cad3&gt;] common_interrupt+0x13/0x2c<b=
r>
[ =A0129.882641] =A0&lt;EOI&gt; =A0[&lt;ffffffff8102a2eb&gt;] ? __ipipe_hal=
t_root+0x2b/0x40<br>
[ =A0129.882645] =A0[&lt;ffffffff810143fd&gt;] ? default_idle+0x3d/0x90<br>
[ =A0129.882647] =A0[&lt;ffffffff8100ae64&gt;] ? cpu_idle+0x74/0xd0<br>
[ =A0129.882650] =A0[&lt;ffffffff81537647&gt;] ? start_secondary+0x19f/0x1a=
4<br>
[ =A0129.882652] handlers:<br>
[ =A0129.882652] [&lt;ffffffff813da670&gt;] (usb_hcd_irq+0x0/0xb0)<br>
[ =A0129.882656] [&lt;ffffffffa0099cc0&gt;] (mpt_interrupt+0x0/0xa00 [mptba=
se])<br>
[ =A0129.882668] [&lt;ffffffffa0179410&gt;] (azx_interrupt+0x0/0x170<br>
[snd_hda_intel])<br>
[ =A0129.882671] Disabling IRQ #16<br>
[ =A0188.244706] hda-intel: IRQ timing workaround is activated for card<br>
#0. Suggest a bigger bdl_pos_adj.<br>
<br>
So, your system is running without an IRQ for three drivers. This may<br>
cause, say, the keyboard driver to be in &quot;polling&quot; mode, and so a=
ppear<br>
to be very slow.<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>

--0015175771dc6b29e4049dad4fbf--

--0015175771dc6b29eb049dad4fc1
Content-Type: application/octet-stream; name=irq
Content-Disposition: attachment; filename=irq
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gkvi98wh0

SVJRICAgICAgICAgQ1BVMCAgICAgICAgQ1BVMSAgICAgICAgQ1BVMiAgICAgICAgQ1BVMyAgICAg
ICAgQ1BVNCAgICAgICAgQ1BVNSAgICAgICAgQ1BVNiAgICAgICAgQ1BVNwogMjg6ICAgICAxMDEw
MDgzICAgICAgICAgICAwICAgICAgICAgICAwICAgICAgICAgICAwICAgICAgICAgICAwICAgICAg
ICAgICAwICAgICAgICAgICAwICAgICAgICAgICAwICAgICAgICAgU0pBMTAwMCBTSkExMDAwCjIz
MTM6ICAgICAgICAgICAwICAgICAgICAgICAwICAgICAgICAgICAwICAgICAgICAgICAwICAgICAg
ICAgICAwICAgICAgICAgICAxICAgICAgICAgICAxICAgICAgICAgICAxICAgICAgICAgW0lQSV0K
MjMxNjogICAgIDMyMDA0ODcgICAgICAyMDA2MzggICAgICAgNjgzMzUgICAgICAgNTk4MDggICAg
IDE0ODkyMDEgICAgICAxMTQ1MzcgICAgICAgMzY4OTggICAgICAgMTQwNjEgICAgICAgICBbdGlt
ZXJdCjIzMTc6ICAgICAgICAgICAwICAgICAgICAgICAwICAgICAgICAgICAwICAgICAgICAgICAw
ICAgICAgICAgICAwICAgICAgICAgICAwICAgICAgICAgICAwICAgICAgICAgICAwICAgICAgICAg
W2NyaXRpY2FsIHN5bmNdCjIzNzA6ICAgICAyNDY5OTMyICAgICAgICAgICAwICAgICAgICAgICAw
ICAgICAgICAgICAwICAgICAgICAgICAwICAgICAgICAgICAwICAgICAgICAgICAwICAgICAgICAg
ICAwICAgICAgICAgW3ZpcnR1YWxdCg==
--0015175771dc6b29eb049dad4fc1
Content-Type: application/octet-stream; name=interrupts
Content-Disposition: attachment; filename=interrupts
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gkvi99mx1

ICAgICAgICAgICAgQ1BVMCAgICAgICBDUFUxICAgICAgIENQVTIgICAgICAgQ1BVMyAgICAgICBD
UFU0ICAgICAgIENQVTUgICAgICAgQ1BVNiAgICAgICBDUFU3ICAgICAgIAogICAwOiAgICAgICAg
IDY3ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAg
MCAgICAgICAgICAwICAgICAgICAgIDAgICBJTy1BUElDLWVkZ2UgICAgICB0aW1lcgogICAxOiAg
ICAgICAgICAzICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAg
ICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICBJTy1BUElDLWVkZ2UgICAgICBpODA0Mgog
ICA4OiAgICAgICAgICAxICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAg
IDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICBJTy1BUElDLWVkZ2UgICAgICBy
dGMwCiAgIDk6ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAg
ICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgIElPLUFQSUMtZmFzdGVv
aSAgIGFjcGkKICAxMjogICAgICAgICAgNCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAg
MCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgSU8tQVBJQy1l
ZGdlICAgICAgaTgwNDIKICAxNjogICAgICAgNDMwMyAgICAgICAgICAwICAgICAgICAgIDAgICAg
ICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAzOTk1MyAgICAgMjU3MDI0ICAgSU8t
QVBJQy1mYXN0ZW9pICAgdWhjaV9oY2Q6dXNiMywgaW9jMCwgSERBIEludGVsCiAgMTc6ICAgICAg
NzY3NzIgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAg
ICAwICAgICAgICAgIDAgICAgICAgICAgMCAgIElPLUFQSUMtZmFzdGVvaSAgIHVoY2lfaGNkOnVz
YjQsIHVoY2lfaGNkOnVzYjcsIGV0aDAKICAxODogICAgICAgICA1NCAgICAgICAgICAwICAgICAg
ICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAg
ICAzICAgSU8tQVBJQy1mYXN0ZW9pICAgdWhjaV9oY2Q6dXNiOAogIDIwOiAgICAgICAgMTUwICAg
ICAgICAgIDAgICAgICAgNTk2NCAgICAgICAgICAwICAgICAgMzg1NTUgICAgICAgICAgMCAgICAg
ICAgICAwICAgICAgICAgIDAgICBJTy1BUElDLWZhc3Rlb2kgICBhaGNpCiAgMjI6ICAgICAgMTU3
NTMgICAgMTk3MDAxNSAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAw
ICAgICAgICAgIDAgICAgNjkyODE3OCAgIElPLUFQSUMtZmFzdGVvaSAgIGVoY2lfaGNkOnVzYjEs
IHVoY2lfaGNkOnVzYjUKICAyMzogICAgICAgIDgyMCAgICAgICAgICAwICAgICAgICAgIDAgICAg
ICA1NTExMyAgICAgICAgICAwICAgICAyODYyMTEgICAgICAgICAgMCAgICAgICAgICAwICAgSU8t
QVBJQy1mYXN0ZW9pICAgZWhjaV9oY2Q6dXNiMiwgdWhjaV9oY2Q6dXNiNgogIDMwOiAgICAgICAg
IDIxICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgMjEx
MSAgICAgICAgICAwICAgICAgICAgIDAgICBJTy1BUElDLWZhc3Rlb2kgICBldGgxCiAgMzc6ICAg
ICAgICAgMjIgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAg
ICAgIDE0ICAgICAgNDc5NDcgICAgICAgICAgMCAgIElPLUFQSUMtZmFzdGVvaSAgIGV0aDIKICA0
ODogICAgICAgICAyMSAgICAgICAgICAwICAgICAgICAyNTYgICAgICAgICAgMCAgICAgICAxODU3
ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgSU8tQVBJQy1mYXN0ZW9pICAgZXRo
MwogIDU2OiAgICAgICAgIDgxICAgICA5NjIxNTggICAgICAgICAgMCAgICAgICAgICAwICAgICAg
ICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICBJTy1BUElDLWZhc3Rlb2kg
ICBvaGNpMTM5NAogIDU4OiAgICAgICAgIDQ0ICAgICAgIDIzNzggICAgICAgICAgMCAgICAgICAg
ICAwICAgICAgICAgMTEgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICBJTy1BUElD
LWZhc3Rlb2kgICBldGg0CiBOTUk6ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAg
ICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgIE5v
bi1tYXNrYWJsZSBpbnRlcnJ1cHRzCiBMT0M6ICAgIDMwOTA1MDQgICAgIDIwMDQzNSAgICAgIDY2
MzAzICAgICAgNTgxNzMgICAgMTQ4ODkxMSAgICAgMTE0Mjk2ICAgICAgMzY4MTMgICAgICAxMTQy
NyAgIExvY2FsIHRpbWVyIGludGVycnVwdHMKIFNQVTogICAgICAgICAgMCAgICAgICAgICAwICAg
ICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAg
ICAgICAwICAgU3B1cmlvdXMgaW50ZXJydXB0cwogUE1JOiAgICAgICAgICAwICAgICAgICAgIDAg
ICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAg
ICAgICAgIDAgICBQZXJmb3JtYW5jZSBtb25pdG9yaW5nIGludGVycnVwdHMKIFBORDogICAgICAg
ICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAg
IDAgICAgICAgICAgMCAgICAgICAgICAwICAgUGVyZm9ybWFuY2UgcGVuZGluZyB3b3JrCiBSRVM6
ICAgICA4NjA4NDcgICAgIDY0Njk4OCAgICAgNjY2NzEyICAgICA1MjQ2OTcgICAgIDY3OTA2OSAg
ICAgNDMwNTA5ICAgICAyMDE0NTEgICAgICA1NzQxNiAgIFJlc2NoZWR1bGluZyBpbnRlcnJ1cHRz
CiBDQUw6ICAgICAgIDIzNjAgICAgICAgICA4NyAgICAgICAgMTEzICAgICAgICAxMTIgICAgICAg
MjA5NiAgICAgICAgMTE0ICAgICAgICAxMDkgICAgICAgIDExNSAgIEZ1bmN0aW9uIGNhbGwgaW50
ZXJydXB0cwogVExCOiAgICAgICA0MDY3ICAgICAgIDkwNDcgICAgICAgOTEzNSAgICAgICA3NjE0
ICAgICAgIDQ3MjAgICAgICAgNTQ1NiAgICAgICAyNzcyICAgICAgIDEzODcgICBUTEIgc2hvb3Rk
b3ducwogVFJNOiAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAg
ICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICBUaGVybWFsIGV2ZW50
IGludGVycnVwdHMKIFRIUjogICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAg
ICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgVGhyZXNo
b2xkIEFQSUMgaW50ZXJydXB0cwogTUNFOiAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAg
MCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAg
ICBNYWNoaW5lIGNoZWNrIGV4Y2VwdGlvbnMKIE1DUDogICAgICAgICAxNiAgICAgICAgIDE2ICAg
ICAgICAgMTYgICAgICAgICAxNiAgICAgICAgIDE2ICAgICAgICAgMTYgICAgICAgICAxNiAgICAg
ICAgIDE2ICAgTWFjaGluZSBjaGVjayBwb2xscwogRVJSOiAgICAgICAgICA3CiBNSVM6ICAgICAg
ICAgIDAK
--0015175771dc6b29eb049dad4fc1--

