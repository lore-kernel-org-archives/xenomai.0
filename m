MIME-Version: 1.0
Date: Mon, 27 Jun 2011 08:31:54 +0200
Message-ID: <BANLkTi=2WnfLFC9DVQY81obGPO6_CG_PCA@mail.gmail.com>
From: Adrien LEMAITRE <adrien.lemaitre@domain.hid>
Content-Type: multipart/mixed; boundary=20cf307f30801c790404a6abb5d1
Subject: [Xenomai-help] Program hangs using "rt_task_sleep" in a particular
	way
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--20cf307f30801c790404a6abb5d1
Content-Type: multipart/alternative; boundary=20cf307f30801c78fe04a6abb5cf

--20cf307f30801c78fe04a6abb5cf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I raise a problem encountered and always present. Before on this configurat=
ion
:

- linux kernel : 2.6.29.6
- adeos patch : adeos-ipipe-2.6.29-arm-1.13-00.patch
- xenomai : 2.4.8
- host linux distribution : ubuntu 10.04 (64 bits)
- compiler : gcc 4.2.1 (buildroot's generated toolchain)

And it is always present with this configuration :

- Linux kernel : 2.6.37
- Adeos patch : adeos-ipipe-2.6.37-x86-2.9-00.patch
- Xenomai : 2.5.6
- Host Linux distribution : Ubuntu 10.04
- Compiler : gcc-4.4.3

Configuration of kernel:

I used the default configuration of Ubunut 10.04 and i change this:
In "Power management and ACPI options" :
- deactivate APM
- deactivate CPU frequency scaling
- deactivate ACPI
- deactivate CPU idle PM support
In "Device drivers/Input device support/Miscelaneous devices":
- deactivate PC Speaker support
In "Processor type and features":
- deactivate HPET_TIMER
- deactivate Enable -fstack-protector buffer overflow detection
(EXPERIMENTAL)


We encounter a problem in a particular situation. In the attached
source, when we change the value passed to rt_task_sleep (line 36), the
program never returns.

This appears only with values greater or equal to 100000 (and maybe some
other values between 10000 and 100000) and only when we use
rt_task_sleep between the two rt_task_spawn calls.

Is there something we've done wrong ? A problem with the kernel
configuration? Or a bug of Xenomai ?


Adrien Lema=EEtre.

--20cf307f30801c78fe04a6abb5cf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br><span id=3D"result_box" class=3D"" lang=3D"en"><span title=3D=
"Cliquer ici pour voir d&#39;autres traductions" class=3D"hps">I raise</spa=
n> <span title=3D"Cliquer ici pour voir d&#39;autres traductions" class=3D"=
hps">a</span> <span title=3D"Cliquer ici pour voir d&#39;autres traductions=
" class=3D"hps">problem</span> <span title=3D"Cliquer ici pour voir d&#39;a=
utres traductions" class=3D"hps">encountered</span> <span title=3D"Cliquer =
ici pour voir d&#39;autres traductions" class=3D"hps">and always present</s=
pan></span><span id=3D"result_box" class=3D"" lang=3D"en"><span title=3D"Cl=
iquer ici pour voir d&#39;autres traductions" class=3D"hps">. </span></span=
><span id=3D"result_box" class=3D"" lang=3D"en"><span title=3D"Cliquer ici =
pour voir d&#39;autres traductions" class=3D"hps">Before</span> on <span ti=
tle=3D"Cliquer ici pour voir d&#39;autres traductions" class=3D"hps">this</=
span> <span title=3D"Cliquer ici pour voir d&#39;autres traductions" class=
=3D"hps">configuration </span></span>:<br>
<br><div style=3D"margin-left: 40px;">- linux kernel : 2.6.29.6<br>
- adeos patch : adeos-ipipe-2.6.29-arm-1.13-00.patch<br>
- xenomai : 2.4.8<br>
- host linux distribution : ubuntu 10.04 (64 bits)<br>
- compiler : gcc 4.2.1 (buildroot&#39;s generated toolchain)<br></div><span=
 id=3D"result_box" class=3D"" lang=3D"en"><span class=3D"" title=3D"Cliquer=
 ici pour voir d&#39;autres traductions"></span><br><span title=3D"Cliquer =
ici pour voir d&#39;autres traductions" class=3D"hps">And it</span> <span t=
itle=3D"Cliquer ici pour voir d&#39;autres traductions" class=3D"hps">is al=
ways present</span> <span title=3D"Cliquer ici pour voir d&#39;autres tradu=
ctions" class=3D"hps">with this configuration</span></span> :<br>
<br><div style=3D"margin-left: 40px;">- Linux kernel : 2.6.37<br>- Adeos pa=
tch : adeos-ipipe-2.6.37-x86-2.9-00.patch<br>- Xenomai : 2.5.6<br>- Host Li=
nux distribution : Ubuntu 10.04<br>- Compiler : gcc-4.4.3<br></div><br>Conf=
iguration of kernel:<br>

<br>I used the default configuration of Ubunut 10.04 and i change this:<br>=
<div style=3D"margin-left: 40px;">In &quot;Power management and ACPI option=
s&quot; :<br><div style=3D"margin-left: 40px;">- <span id=3D"result_box" cl=
ass=3D"short_text" lang=3D"en"><span title=3D"Cliquer ici pour voir d&#39;a=
utres traductions" class=3D"hps">deactivate APM</span></span><br>
<span id=3D"result_box" class=3D"short_text" lang=3D"en"><span title=3D"Cli=
quer ici pour voir d&#39;autres traductions" class=3D"hps">- </span></span>=
<span id=3D"result_box" class=3D"short_text" lang=3D"en"><span title=3D"Cli=
quer ici pour voir d&#39;autres traductions" class=3D"hps">deactivate CPU f=
requency scaling</span></span><br>
<span id=3D"result_box" class=3D"short_text" lang=3D"en"><span title=3D"Cli=
quer ici pour voir d&#39;autres traductions" class=3D"hps">- </span></span>=
<span id=3D"result_box" class=3D"short_text" lang=3D"en"><span title=3D"Cli=
quer ici pour voir d&#39;autres traductions" class=3D"hps">deactivate ACPI<=
/span></span><br>
<span id=3D"result_box" class=3D"short_text" lang=3D"en"><span title=3D"Cli=
quer ici pour voir d&#39;autres traductions" class=3D"hps">- </span></span>=
<span id=3D"result_box" class=3D"short_text" lang=3D"en"><span title=3D"Cli=
quer ici pour voir d&#39;autres traductions" class=3D"hps">deactivate CPU i=
dle PM support</span></span><br>
</div><span id=3D"result_box" class=3D"short_text" lang=3D"en"><span title=
=3D"Cliquer ici pour voir d&#39;autres traductions" class=3D"hps">In &quot;=
Device drivers/Input device support/Miscelaneous devices&quot;:</span></spa=
n><br><div style=3D"margin-left: 40px;">
<span id=3D"result_box" class=3D"short_text" lang=3D"en"><span title=3D"Cli=
quer ici pour voir d&#39;autres traductions" class=3D"hps">- </span></span>=
<span id=3D"result_box" class=3D"short_text" lang=3D"en"><span title=3D"Cli=
quer ici pour voir d&#39;autres traductions" class=3D"hps">deactivate PC Sp=
eaker support</span></span><br>
</div><span id=3D"result_box" class=3D"short_text" lang=3D"en"><span title=
=3D"Cliquer ici pour voir d&#39;autres traductions" class=3D"hps">In &quot;=
Processor type and features&quot;:</span></span><br><div style=3D"margin-le=
ft: 40px;">
<span id=3D"result_box" class=3D"short_text" lang=3D"en"><span title=3D"Cli=
quer ici pour voir d&#39;autres traductions" class=3D"hps">- </span></span>=
<span id=3D"result_box" class=3D"short_text" lang=3D"en"><span title=3D"Cli=
quer ici pour voir d&#39;autres traductions" class=3D"hps">deactivate HPET_=
TIMER</span></span><br>
<span id=3D"result_box" class=3D"short_text" lang=3D"en"><span title=3D"Cli=
quer ici pour voir d&#39;autres traductions" class=3D"hps">- </span></span>=
<span id=3D"result_box" class=3D"short_text" lang=3D"en"><span title=3D"Cli=
quer ici pour voir d&#39;autres traductions" class=3D"hps">deactivate Enabl=
e -fstack-protector buffer overflow detection (EXPERIMENTAL)</span></span><=
br>
</div></div><span id=3D"result_box" class=3D"short_text" lang=3D"en"><span =
title=3D"Cliquer ici pour voir d&#39;autres traductions" class=3D"hps"><br>=
<br></span></span>We encounter a problem in a particular situation. In the =
attached<br>


source, when we change the value passed to rt_task_sleep (line 36), the<br>

program never returns.<br>

<br>

This appears only with values greater or equal to 100000 (and maybe some<br=
>

other values between 10000 and 100000) and only when we use<br>

rt_task_sleep between the two rt_task_spawn calls.<br><br>Is there somethin=
g we&#39;ve done wrong ? <span id=3D"result_box" class=3D"short_text" lang=
=3D"en"><span title=3D"Cliquer ici pour voir d&#39;autres traductions" clas=
s=3D"hps">A</span> <span title=3D"Cliquer ici pour voir d&#39;autres traduc=
tions" class=3D"hps">problem</span> <span title=3D"Cliquer ici pour voir d&=
#39;autres traductions" class=3D"hps">with</span> <span title=3D"Cliquer ic=
i pour voir d&#39;autres traductions" class=3D"hps">the kernel configuratio=
n</span><span class=3D"" title=3D"Cliquer ici pour voir d&#39;autres traduc=
tions">? Or a bug of Xenomai ?<br>
<br><br>Adrien Lema=EEtre.<br></span></span>

--20cf307f30801c78fe04a6abb5cf--

--20cf307f30801c790404a6abb5d1
Content-Type: text/x-csrc; charset=US-ASCII; name="projet_vierge.c"
Content-Disposition: attachment; filename="projet_vierge.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gpf1qg6x0

I2luY2x1ZGUgInV0aWxzLmgiCiNpbmNsdWRlIDxhc3NlcnQuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+
CiNpbmNsdWRlIDxuYXRpdmUvdGFzay5oPgojaW5jbHVkZSA8bmF0aXZlL3F1ZXVlLmg+CiNpbmNs
dWRlIDxzeXMvbW1hbi5oPgoKaW50IENvdW50ZXIxPTA7CmludCBDb3VudGVyMj0wOwp2b2xhdGls
ZSBpbnQgdGVzdDE9MDsKdm9sYXRpbGUgaW50IHRlc3QyPTA7Cgp2b2lkIFdvcmtpbmdUYXNrMSgp
CnsKCXdoaWxlKHRlc3QxPT0wKQoJewoJCUNvdW50ZXIxKys7Cgl9Cn0KCnZvaWQgV29ya2luZ1Rh
c2syKCkKeyAKCXdoaWxlKHRlc3QyPT0wKQoJewoJCUNvdW50ZXIyKys7Cgl9Cn0KCnZvaWQgZ28g
KCkKewoJUlRfVEFTSyBSdF9Xb3JraW5nX3Rhc2sxOwoJUlRfVEFTSyBSdF9Xb3JraW5nX3Rhc2sy
OwoKCXJ0X3Rhc2tfc3Bhd24gKCZSdF9Xb3JraW5nX3Rhc2sxLCAiV29ya2luZ1Rhc2sxIiwgREVG
QVVMVF9TVEFDS19TSVpFLDEwLCBUX0ZQVXxUX0pPSU5BQkxFLCAmV29ya2luZ1Rhc2sxLCBOVUxM
KTsKICAKICBydF90YXNrX3NsZWVwKDEwMDAwMCk7IC8vIGRvZXMgbm90IHdvcmsKICAvL3J0X3Rh
c2tfc2xlZXAoMTAwMDApOyAgLy8gd29ya3MKCglydF90YXNrX3NwYXduICgmUnRfV29ya2luZ190
YXNrMiwgIldvcmtpbmdUYXNrMiIsIERFRkFVTFRfU1RBQ0tfU0laRSwgMjAsIFRfRlBVfFRfSk9J
TkFCTEUsICZXb3JraW5nVGFzazIsIE5VTEwpOwoKCXRlc3QxPTE7Cgl0ZXN0Mj0xOwp9CgppbnQg
bWFpbiAodm9pZCkKewogIFJUX1RBU0sgUnRfbWFpbl90YXNrOwogIGludCBlcnJvcjsKCiAgZXJy
b3IgPSBtbG9ja2FsbCggTUNMX0NVUlJFTlQgfCBNQ0xfRlVUVVJFICk7CiAgYXNzZXJ0IChlcnJv
ciA9PSAwKTsKCiAgZXJyb3IgPSBydF90YXNrX3NwYXduICgmUnRfbWFpbl90YXNrLCAiZ28iLCBE
RUZBVUxUX1NUQUNLX1NJWkUsIDUwLCBUX0ZQVSB8IFRfSk9JTkFCTEUsICZnbywgTlVMTCk7CiAg
YXNzZXJ0IChlcnJvciA9PSAwKTsKCiAgZXJyb3IgPSBydF90YXNrX2pvaW4oJlJ0X21haW5fdGFz
ayk7CiAgYXNzZXJ0IChlcnJvciA9PSAwKTsKICAKICBwcmludGYoIkVuZCBwcm9ncmFtXHJcbiIp
OwogIAogIHJldHVybiAwOwp9Cg==
--20cf307f30801c790404a6abb5d1--

