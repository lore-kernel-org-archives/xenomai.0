MIME-Version: 1.0
In-Reply-To: <CAMwkeZyvyhHPZTWz1LiaOhWA9TdrQaXMo833Ej5JRwJR3Da2xw@domain.hid>
References: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>
	<CAGc_wL172OGHZ-8SG8e77Fp5qwHqKvTY610aQsr3WA_bp+3HRg@domain.hid>
	<CAMwkeZyvyhHPZTWz1LiaOhWA9TdrQaXMo833Ej5JRwJR3Da2xw@domain.hid>
Date: Thu, 29 Sep 2011 16:57:45 -0300
Message-ID: <CAMwkeZxinGD8_yEYmo+ySHx9dzU6hEM4BFH4jejnTMd87f0M9Q@mail.gmail.com>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/mixed; boundary=bcaec53af23a15aef804ae19ec2c
Subject: Re: [Xenomai-help] Command code working with comedi not working
	with analogy
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

--bcaec53af23a15aef804ae19ec2c
Content-Type: multipart/alternative; boundary=bcaec53af23a15aef504ae19ec2a

--bcaec53af23a15aef504ae19ec2a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 28 de septiembre de 2011 12:19, Fernando Herrero Carr=C3=B3n <
elferdo@domain.hid> escribi=C3=B3:

> 2011/9/28 Julien Delange <julien.delange@domain.hid>
>
>> 2011/9/27 Fernando Herrero Carr=C3=B3n <elferdo@domain.hid>:
>> > [snip]
>>
>> Dear Fernando,
>>
>> Would it be possible to provide more information about your bug, in
>> particular, the configuration of the board (which is analogy0, ...)
>> and the code you are trying to use ?
>>
>> Also, as Gilles said, please also try the latest rc release, it might
>> solve your issues.
>>
>> Thanks,
>>
>
> Dear Gilles and Julien,
>
> Thanks for your replies. I will try the latest RC and let you know.
>
> These are the details of my setup:
>
> - Dmesg output:
>
>  Analogy: MITE: Available NI device IDs: 0x1870 0x70c0
>
> - lspci:
> 01:05.0 Class ff00: National Instruments Device 70c0 (this should be the =
NI
> 6143) <- used for AO
> 01:06.0 Class ff00: National Instruments PCI-6713 <- used for AI
>
> - analogy-config:
> /usr/xenomai/sbin/analogy_config  analogy0 analogy_ni_pcimio 1,5
> /usr/xenomai/sbin/analogy_config  analogy1 analogy_ni_pcimio 1,6
>
> - cat /proc/analogy/devices
> --  Analogy devices --
>
> | idx | status | driver
> |  00 | Linked | analogy_ni_pcimio
> |  01 | Linked | analogy_ni_pcimio
> |  02 | Unused | No driver
> [...]
>
> - cat /proc/analogy/00-analogy_ni_pcimio
> --  Subdevices --
>
> | idx | type
> |  00 | Analog input subdevice
> |  01 | Unused subdevice
> |  02 | Digital input/output subdevice
> |  03 | Unused subdevice
> |  04 | Unused subdevice
> |  05 | Calibration subdevice
> |  06 | Memory subdevice
> |  07 | Digital input/output subdevice
> |  08 | Unused subdevice
> |  09 | Serial subdevice
> |  10 | Unused subdevice
> |  11 | Counter subdevice
> |  12 | Counter subdevice
> |  13 | Counter subdevice
>
> - cat /proc/analogy/01-analogy_ni_pcimio
> --  Subdevices --
>
> | idx | type
> |  00 | Unused subdevice
> |  01 | Analog output subdevice
> |  02 | Digital input/output subdevice
> |  03 | Unused subdevice
> |  04 | Unused subdevice
> |  05 | Calibration subdevice
> |  06 | Memory subdevice
> |  07 | Digital input/output subdevice
> |  08 | Unused subdevice
> |  09 | Serial subdevice
> |  10 | Unused subdevice
> |  11 | Counter subdevice
> |  12 | Counter subdevice
> |  13 | Counter subdevice
>
> Thanks,
> Fernando
>

Dear all,

I have followed your advice and just tested with the following
kernel/xenomai versions:

Linux ******** 2.6.38.8-xenomai-2.6rc4 #1 SMP PREEMPT Thu Sep 29 16:17:41
BRT 2011 x86_64 GNU/Linux

Now both "cmd_read" and my own code are running, but "a4l_async_read" reads
either garbage or either value of 0 or 0x8000. In order to make cmd_read
work with my board I had to make the following changes to the code:

--- cmd_read.c.orig    2011-09-29 16:40:50.000000000 -0300
+++ cmd_read.c    2011-09-29 16:41:04.000000000 -0300
@@ -66,8 +66,8 @@
     .start_arg =3D 0,
     .scan_begin_src =3D TRIG_TIMER,
     .scan_begin_arg =3D 8000000,    /* in ns */
-    .convert_src =3D TRIG_TIMER,
-    .convert_arg =3D 500000,    /* in ns */
+    .convert_src =3D TRIG_NOW,
+    .convert_arg =3D 00000,    /* in ns */
     .scan_end_src =3D TRIG_COUNT,
     .scan_end_arg =3D 0,
     .stop_src =3D TRIG_COUNT,

otherwise the drive would complain about "the driver cmd_test failed" or
something like that, because my board has 8 parallel ADCs.

If I run my program (see attachment) and call dmesg I can see:

[  641.237710] Analogy: analogy_ni_pcimio: ni_ai_cmd: start
[  641.237718] Analogy: analogy_ni_pcimio: ni_ai_cmd:
Interrupt_A_Enable_Register =3D 0x0031
[  641.237723] Analogy: analogy_ni_pcimio: ni_ai_cmd: exit
[  641.238874] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt:
a_status=3D90b0 ai_mite_status=3D00200000
[  641.239872] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt:
a_status=3D9030 ai_mite_status=3D00200000
[...]
[  642.237879] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt:
a_status=3D9070 ai_mite_status=3D00200000
[  642.237881] Analogy: analogy_ni_pcimio: ni_mio_common: SC_TC interrupt

I just checked my setup with our RTAI/comedi code and it is properly
working. The input card is attached to a 3Hz sine wave generator with 1V
peek-to-peek. If I run the attached program, the output looks like this:

Analogy device analogy_ni_pcimio.
Channel 0 has 16 bits and 1 different ranges
32768
32768
32768
32768
32768
[...]
32768

Any help on debugging this would be greatly appreciated.

Sincerely,
Fernando

--bcaec53af23a15aef504ae19ec2a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">El 28 de septiembre de 2011 12:19, Fernando Herr=
ero Carr=C3=B3n <span dir=3D"ltr">&lt;<a href=3D"mailto:elferdo@domain.hid" =
target=3D"_blank">elferdo@domain.hid</a>&gt;</span> escribi=C3=B3:<br><block=
quote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left=
: 1px solid rgb(204, 204, 204); padding-left: 1ex;">


<div><div class=3D"gmail_quote">2011/9/28 Julien Delange <span dir=3D"ltr">=
&lt;<a href=3D"mailto:julien.delange@domain.hid" target=3D"_blank">julien.de=
lange@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=
=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); p=
adding-left: 1ex;">




2011/9/27 Fernando Herrero Carr=C3=B3n &lt;<a href=3D"mailto:elferdo@domain.hid.=
com" target=3D"_blank">elferdo@domain.hid</a>&gt;:<br>
&gt; [snip]<br>
<br>
Dear Fernando,<br>
<br>
Would it be possible to provide more information about your bug, in<br>
particular, the configuration of the board (which is analogy0, ...)<br>
and the code you are trying to use ?<br>
<br>
Also, as Gilles said, please also try the latest rc release, it might<br>
solve your issues.<br>
<br>
Thanks,<br></blockquote></div><br></div>Dear Gilles and Julien,<br><br>Than=
ks for your replies. I will try the latest RC and let you know.<br><br>Thes=
e are the details of my setup:<br><br>- Dmesg output:<br><br><div style=3D"=
margin-left: 40px;">




=C2=A0Analogy: MITE: Available NI device IDs: 0x1870 0x70c0<br></div><br>- =
lspci:<br><div style=3D"margin-left: 40px;">01:05.0 Class ff00: National In=
struments Device 70c0 (this should be the NI 6143) &lt;- used for AO<br></d=
iv>



<div style=3D"margin-left: 40px;">01:06.0 Class ff00: National Instruments =
PCI-6713 &lt;- used for AI<br>
</div><br>- analogy-config:<br><div style=3D"margin-left: 40px;">/usr/xenom=
ai/sbin/analogy_config=C2=A0 analogy0 analogy_ni_pcimio 1,5<br>/usr/xenomai=
/sbin/analogy_config=C2=A0 analogy1 analogy_ni_pcimio 1,6<br><br></div>- ca=
t /proc/analogy/devices <br>



<div style=3D"margin-left: 40px;">--=C2=A0 Analogy devices --<br><br>| idx =
| status | driver<br>|=C2=A0 00 | Linked | analogy_ni_pcimio<br>|=C2=A0 01 =
| Linked | analogy_ni_pcimio<br>|=C2=A0 02 | Unused | No driver<br>[...]<br=
><br></div>- cat /proc/analogy/00-analogy_ni_pcimio <br>



<div style=3D"margin-left: 40px;">--=C2=A0 Subdevices --<br><br>| idx | typ=
e<br>|=C2=A0 00 | Analog input subdevice<br>|=C2=A0 01 | Unused subdevice<b=
r>|=C2=A0 02 | Digital input/output subdevice<br>|=C2=A0 03 | Unused subdev=
ice<br>|=C2=A0 04 | Unused subdevice<br>



|=C2=A0 05 | Calibration subdevice<br>|=C2=A0 06 | Memory subdevice<br>|=C2=
=A0 07 | Digital input/output subdevice<br>|=C2=A0 08 | Unused subdevice<br=
>|=C2=A0 09 | Serial subdevice<br>|=C2=A0 10 | Unused subdevice<br>|=C2=A0 =
11 | Counter subdevice<br>|=C2=A0 12 | Counter subdevice<br>



|=C2=A0 13 | Counter subdevice<br><br></div>- cat /proc/analogy/01-analogy_=
ni_pcimio <br><div style=3D"margin-left: 40px;">--=C2=A0 Subdevices --<br><=
br>| idx | type<br>|=C2=A0 00 | Unused subdevice<br>|=C2=A0 01 | Analog out=
put subdevice<br>


|=C2=A0 02 | Digital input/output subdevice<br>
|=C2=A0 03 | Unused subdevice<br>|=C2=A0 04 | Unused subdevice<br>|=C2=A0 0=
5 | Calibration subdevice<br>|=C2=A0 06 | Memory subdevice<br>|=C2=A0 07 | =
Digital input/output subdevice<br>|=C2=A0 08 | Unused subdevice<br>|=C2=A0 =
09 | Serial subdevice<br>|=C2=A0 10 | Unused subdevice<br>



|=C2=A0 11 | Counter subdevice<br>|=C2=A0 12 | Counter subdevice<br>|=C2=A0=
 13 | Counter subdevice<br></div><br>Thanks,<br><font color=3D"#888888">Fer=
nando<br>
</font></blockquote></div><br>Dear all,<br><br>I have followed your advice =
and just tested with the following kernel/xenomai versions:<br><br>Linux **=
****** 2.6.38.8-xenomai-2.6rc4 #1 SMP PREEMPT Thu Sep 29 16:17:41 BRT 2011 =
x86_64 GNU/Linux<br>
<br>Now both &quot;cmd_read&quot; and my own code are running, but &quot;a4=
l_async_read&quot; reads either garbage or either value of 0 or 0x8000. In =
order to make cmd_read work with my board I had to make the following chang=
es to the code:<br>
<br><div style=3D"margin-left: 40px;">--- cmd_read.c.orig=C2=A0=C2=A0=C2=A0=
 2011-09-29 16:40:50.000000000 -0300<br>+++ cmd_read.c=C2=A0=C2=A0=C2=A0 20=
11-09-29 16:41:04.000000000 -0300<br>@@ -66,8 +66,8 @@<br>=C2=A0=C2=A0=C2=
=A0=C2=A0 .start_arg =3D 0,<br>=C2=A0=C2=A0=C2=A0=C2=A0 .scan_begin_src =3D=
 TRIG_TIMER,<br>
=C2=A0=C2=A0=C2=A0=C2=A0 .scan_begin_arg =3D 8000000,=C2=A0=C2=A0=C2=A0 /* =
in ns */<br>-=C2=A0=C2=A0=C2=A0 .convert_src =3D TRIG_TIMER,<br>-=C2=A0=C2=
=A0=C2=A0 .convert_arg =3D 500000,=C2=A0=C2=A0=C2=A0 /* in ns */<br>+=C2=A0=
=C2=A0=C2=A0 .convert_src =3D TRIG_NOW,<br>+=C2=A0=C2=A0=C2=A0 .convert_arg=
 =3D 00000,=C2=A0=C2=A0=C2=A0 /* in ns */<br>=C2=A0=C2=A0=C2=A0=C2=A0 .scan=
_end_src =3D TRIG_COUNT,<br>
=C2=A0=C2=A0=C2=A0=C2=A0 .scan_end_arg =3D 0,<br>=C2=A0=C2=A0=C2=A0=C2=A0 .=
stop_src =3D TRIG_COUNT,<br></div><br>otherwise the drive would complain ab=
out &quot;the driver cmd_test failed&quot; or something like that, because =
my board has 8 parallel ADCs.<br><br>If I run my program (see attachment) a=
nd call dmesg I can see:<br>
<br><div style=3D"margin-left: 40px;">[=C2=A0 641.237710] Analogy: analogy_=
ni_pcimio: ni_ai_cmd: start<br>[=C2=A0 641.237718] Analogy: analogy_ni_pcim=
io: ni_ai_cmd: Interrupt_A_Enable_Register =3D 0x0031<br>[=C2=A0 641.237723=
] Analogy: analogy_ni_pcimio: ni_ai_cmd: exit<br>
[=C2=A0 641.238874] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt: a=
_status=3D90b0 ai_mite_status=3D00200000<br>[=C2=A0 641.239872] Analogy: an=
alogy_ni_pcimio: ni_mio_common: interrupt: a_status=3D9030 ai_mite_status=
=3D00200000<br>[...]<br>
[=C2=A0 642.237879] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt: a=
_status=3D9070 ai_mite_status=3D00200000<br>[=C2=A0 642.237881] Analogy: an=
alogy_ni_pcimio: ni_mio_common: SC_TC interrupt<br></div><br>I just checked=
 my setup with our RTAI/comedi code and it is properly working. The input c=
ard is attached to a 3Hz sine wave generator with 1V peek-to-peek. If I run=
 the attached program, the output looks like this:<br>
<br><div style=3D"margin-left: 40px;">Analogy device analogy_ni_pcimio.<br>=
Channel 0 has 16 bits and 1 different ranges<br>32768 <br>32768 <br>32768 <=
br>32768 <br>32768<br>[...]<br>32768 <br></div><br>Any help on debugging th=
is would be greatly appreciated.<br>
<br>Sincerely,<br>Fernando<br>

--bcaec53af23a15aef504ae19ec2a--

--bcaec53af23a15aef804ae19ec2c
Content-Type: text/x-c++src; charset=US-ASCII; name="analogy_cmd_read.cpp"
Content-Disposition: attachment; filename="analogy_cmd_read.cpp"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gt65wk1l1

LyoqCiAqIFVzZSBhbmFsb2d5IGNvbW1hbmRzIHRvIHJlYWQgYW4gYW5hbG9nIGRldmljZS4KICov
CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDx1bmlzdGQu
aD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c2lnbmFsLmg+CiNpbmNsdWRlIDxzeXMv
bW1hbi5oPgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiNpbmNsdWRlIDxzeXMvdGltZS5oPgojaW5j
bHVkZSA8c2lnbmFsLmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CiNpbmNsdWRlIDxtYXRoLmg+Cgoj
aW5jbHVkZSA8YW5hbG9neS9hbmFsb2d5Lmg+CiNpbmNsdWRlIDxhbmFsb2d5L2NvbW1hbmQuaD4K
CiNpbmNsdWRlIDxuYXRpdmUvdGFzay5oPgoKI2RlZmluZSBOSUNIQU4gICAxCiNkZWZpbmUgSU5Q
VVRfRlJFUSAxMDAwCgphNGxfZGVzY190IGRldl9pbnB1dDsKCmE0bF9jaGluZm9fdCAqY2hhbmlu
Zm9zW05JQ0hBTl0gPSB7MH07CgpzdGF0aWMgbHNhbXBsX3QgbWF4ZGF0YWk7CgppbnQgcmV0ID0g
MDsKCiNkZWZpbmUgU0FNUExFX0hJU1RPUlkgMTAwMApsb25nIHVuc2lnbmVkIGludCBjaGFubmVs
X2hpc3RvcnlbU0FNUExFX0hJU1RPUlldW05JQ0hBTl0gPSB7MH07CgpSVF9UQVNLIHJ0X3Rhc2tf
ZGVzYzsKCmludCBpbml0X2JvYXJkKHZvaWQpCnsKCWludCByZXN1bHQgPSAwOwoKCXJlc3VsdCA9
IGE0bF9vcGVuKCZkZXZfaW5wdXQsICJhbmFsb2d5MCIpOwoJcHJpbnRmKCJBbmFsb2d5IGRldmlj
ZSAlcy5cbiIsIGRldl9pbnB1dC5ib2FyZF9uYW1lKTsKCglpZiAocmVzdWx0KXsKCQlwcmludGYo
IlVuYWJsZSB0byBvcGVuICVzLlxuIiwgZGV2X2lucHV0LmJvYXJkX25hbWUpOwoJCXJldHVybiAx
OwoJfQoKCWRldl9pbnB1dC5zYmRhdGEgPSBtYWxsb2MoZGV2X2lucHV0LnNic2l6ZSk7CgoJaWYg
KGRldl9pbnB1dC5zYmRhdGEgPT0gTlVMTCkKCXsKCQlmcHJpbnRmIChzdGRlcnIsICJNYWxsb2Mg
ZXJyb3IgYXQgJXMsIGxpbmUgJWQuXG4iLCBfX0ZJTEVfXywgX19MSU5FX18pOwoKCQlleGl0KC0x
KTsKCX0KCglyZXQgPSBhNGxfZmlsbF9kZXNjKCZkZXZfaW5wdXQpOwoKCWlmKHJldCA8IDApCgl7
CgkJZnByaW50ZiAoc3RkZXJyLCAiJWQgYXQgJXMsIGxpbmUgJWQuXG4iLCByZXQsIF9fRklMRV9f
LCBfX0xJTkVfXyk7CgoJCWV4aXQoLTEpOwoJfQoKCXJldHVybiAwOwp9Cgp2b2lkIHNldHVwX2lu
cHV0X2NhcmQoYTRsX2Rlc2NfdCAqZGV2KQp7Cgl1bnNpZ25lZCBpbnQgY2hhbmxpc3RbTklDSEFO
XSA9IHswfTsKCWE0bF9jbWRfdCBjbWQ7CgoJLy8gU2V0IHVwIGNvbW1hbmQKCW1lbXNldCgmY21k
LCAwLCBzaXplb2YoY21kKSk7CgoJLy8gU2V0dXAgY2hhbiBsaXN0Cglmb3IoaW50IGkgPSAwOyBp
IDwgTklDSEFOOyBpKyspewoJCWNoYW5saXN0W2ldID0gUEFDSyhpLCAwLCBBUkVGX0NPTU1PTik7
Cgl9CgoJY21kLmlkeF9zdWJkID0gMDsKCWNtZC5zdGFydF9zcmMgPSBUUklHX05PVzsKCWNtZC5z
dGFydF9hcmcgPSAwOwoJY21kLmZsYWdzID0gVFJJR19XQUtFX0VPUzsKCWNtZC5zY2FuX2JlZ2lu
X3NyYyA9IFRSSUdfVElNRVI7CgljbWQuc2Nhbl9iZWdpbl9hcmcgPSAxZTkgLyBJTlBVVF9GUkVR
OwoJY21kLmNvbnZlcnRfc3JjID0gVFJJR19OT1c7CgljbWQuY29udmVydF9hcmcgPSAwOwoJY21k
LmNoYW5fZGVzY3MgPSBjaGFubGlzdDsKCWNtZC5uYl9jaGFuID0gTklDSEFOOwoJY21kLnNjYW5f
ZW5kX3NyYyA9IFRSSUdfQ09VTlQ7CgljbWQuc2Nhbl9lbmRfYXJnCT0gTklDSEFOOwoKCWNtZC5z
dG9wX3NyYyA9IFRSSUdfQ09VTlQ7CgljbWQuc3RvcF9hcmcgPSBTQU1QTEVfSElTVE9SWTsKCglm
b3IoaW50IGkgPSAwOyBpIDwgTklDSEFOOyBpKyspCgl7CgkJaW50IHJldCA9IGE0bF9nZXRfY2hp
bmZvKGRldiwgMCwgaSwgJmNoYW5pbmZvc1tpXSk7CgoJCXByaW50ZigiQ2hhbm5lbCAlZCBoYXMg
JWQgYml0cyBhbmQgJWQgZGlmZmVyZW50IHJhbmdlc1xuIiwgaSwgY2hhbmluZm9zW2ldLT5uYl9i
aXRzLCBjaGFuaW5mb3NbaV0tPm5iX3JuZyk7CgoJCWlmKHJldCA8IDApCgkJewoJCQlmcHJpbnRm
IChzdGRlcnIsICIlZCBhdCAlcywgbGluZSAlZC5cbiIsIHJldCwgX19GSUxFX18sIF9fTElORV9f
KTsKCgkJCWJyZWFrOwoJCX0KCX0KCglhNGxfc25kX2NhbmNlbChkZXYsIDApOwoKCS8qIFN0YXJ0
IHRoZSBjb21tYW5kICovCglyZXQgPSBhNGxfc25kX2NvbW1hbmQoZGV2LCAmY21kKTsKCglpZihy
ZXQgPCAwKXsKCQlmcHJpbnRmIChzdGRlcnIsICIlZCBhdCAlcywgbGluZSAlZC5cbiIsIHJldCwg
X19GSUxFX18sIF9fTElORV9fKTsKCgkJZXhpdCgxKTsKCX0KfQoKaW50IG1haW4odm9pZCkKewoJ
dW5zaWduZWQgY2hhciBpbnB1dF9idWZmZXJbTklDSEFOICogMTBdOwoKCW1sb2NrYWxsKE1DTF9D
VVJSRU5UIHwgTUNMX0ZVVFVSRSk7CgoJaW50IHJldCA9IHJ0X3Rhc2tfc2hhZG93KCZydF90YXNr
X2Rlc2MsIE5VTEwsIDEsIDApOwoKCWlmIChyZXQgPCAwKSB7CgkJZnByaW50ZihzdGRlcnIsCSJy
dF90YXNrX3NoYWRvdyBmYWlsZWQgKHJldD0lZClcbiIsCXJldCk7CgoJCWV4aXQoLTEpOwoJfQoK
CWlmIChpbml0X2JvYXJkKCkpIHs7CgkJcHJpbnRmKCJCb2FyZCBpbml0aWFsaXphdGlvbiBmYWls
ZWQuXG4iKTsKCQlyZXR1cm4gMTsKCX0KCglzZXR1cF9pbnB1dF9jYXJkKCZkZXZfaW5wdXQpOwoK
CWZvcihpbnQgc2NhbiA9IDA7IHNjYW4gPCBTQU1QTEVfSElTVE9SWTsgc2NhbisrKQoJewoJCWlu
dCBtID0gYTRsX2FzeW5jX3JlYWQoJmRldl9pbnB1dCwgaW5wdXRfYnVmZmVyLCBOSUNIQU4gKiBh
NGxfc2l6ZW9mX2NoYW4oY2hhbmluZm9zWzBdKSwgQTRMX0lORklOSVRFKTsKCgkJYTRsX3Jhd3Rv
dWwoY2hhbmluZm9zWzBdLCBjaGFubmVsX2hpc3Rvcnlbc2Nhbl0sIGlucHV0X2J1ZmZlciwgTklD
SEFOKTsKCX0KCglhNGxfc25kX2NhbmNlbCgmZGV2X2lucHV0LCAwKTsKCWE0bF9jbG9zZSgmZGV2
X2lucHV0KTsKCglmb3IgKGludCBpID0gMDsgaSA8IFNBTVBMRV9ISVNUT1JZOyBpKyspIHsKCQlm
b3IoaW50IGogPSAwOyBqIDwgTklDSEFOOyBqKyspCgkJewoJCQlwcmludGYoIiVsdSAiLCBjaGFu
bmVsX2hpc3RvcnlbaV1bal0pOwoJCX0KCgkJcHJpbnRmKCJcbiIpOwoJfQoKCXJldHVybiAwOwp9
Cg==
--bcaec53af23a15aef804ae19ec2c--

