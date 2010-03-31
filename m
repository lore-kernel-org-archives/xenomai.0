Message-ID: <763864.6829.qm@domain.hid>
Date: Wed, 31 Mar 2010 03:55:06 -0700 (PDT)
From: Chtourou Sonda <chtourou_sonda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1977120465-1270032906=:6829"
Subject: Re: [Xenomai-help] Problem to cross-compile Xenomai user-space
	support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrice Kadionik <kadionik@domain.hid>
Cc: xenomai@xenomai.org

--0-1977120465-1270032906=:6829
Content-Type: multipart/alternative; boundary="0-293075141-1270032906=:6829"

--0-293075141-1270032906=:6829
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Patrice,
=0A  =0A    =0A      =0A        OK. Please, verify first that you can boot =
=C2=B5Clinux without Xenomai on your board with the 2 extra hrtimer and hrc=
lock peripherals.
There is no priority on IRQ with NIOS.
=0A        =0A      =0A    =0A  =0A=0ASo, If I have understood, I could put=
:
IRO =3D 7 for hrtimer=20
IRQ =3D 8 for hrclock
IRQ =3D 1 for sys_clk_timer=20
with=C2=A0 this configuration =C2=B5Clinux without Xenomai with the 2 extra=
 hrtimer and hrclock peripherals can boot=C2=A0 on the board .
But I'm wondering why with the first configuration (IRO =3D 1 for hrtimer,I=
RQ =3D 2 for hrclock and IRQ =3D 3 for sys_clk_timer), it didn't boot?=20
=0A  =0A    =0A      =0A        Please verify that you have correctly enabl=
ed all the right options under SOPC builder for hrtimer and hrclock.
=0ABecause we have flexibility in HW configuration with SoPC, we must be mo=
re careful.
=0A        =0A      =0A    =0A  =0A=0AConfiguration of hrtimer with the SoP=
C Builder:
=E2=80=A2 Timer: 32 bits.
=E2=80=A2 Timeout period: 1 =C2=B5s.
=E2=80=A2 Preset : custom. Writable period, readable snapshot, Start/Stop c=
ontrol bits.

Configuration of hrclock with the SoPC Builder:
in the snapshot mode. Its configuration with the SoPC Builder tool is:
=E2=80=A2 64-bit timer.
=E2=80=A2 Timeout period: 5 clocks. clock=3D20 ns (100 ns). The timer funct=
ionality is not used by Xenomai.
=E2=80=A2 Preset: custom. Writable period, readable snapshot, Start/Stop co=
ntrol bits.

Is it correct?
=0A  =0A    =0A      =0A        According to errno.h, code -19=C2=A0 is ENO=
DEV, please verify your timer configuration and respect naming convention
=0A        =0A      =0A    =0A  =0A=0AHere, you speek about "sys_clock_time=
r"?
Configuration of sys_clock_timer with the SoPC Builder:=20
=E2=80=A2 32-bit timer.
=E2=80=A2 Timeout period: 10 ms.
=E2=80=A2 Preset: custom. Writable period, readable snapshot, Start/Stop co=
ntrol bits.

Regards,

=0A=0A=0A      
--0-293075141-1270032906=:6829
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><div id=3D"yiv294836398">Hi Patrice,<br><bloc=
kquote type=3D"cite">=0A  <table style=3D"width: 527px; height: 49px;" bord=
er=3D"0" cellpadding=3D"0" cellspacing=3D"0">=0A    <tbody>=0A      <tr>=0A=
        <td style=3D"font-family: inherit; font-style: inherit; font-varian=
t: inherit; font-weight: inherit; font-size: inherit; line-height: inherit;=
 font-size-adjust: inherit; font-stretch: inherit;" valign=3D"top"><font si=
ze=3D"2">OK. Please, verify first that you can boot =C2=B5Clinux without Xe=
nomai on your board with the 2 extra hrtimer and hrclock peripherals.<br>Th=
ere is no priority on IRQ with NIOS.</font><br>=0A        </td>=0A      </t=
r>=0A    </tbody>=0A  </table>=0A</blockquote>=0ASo, If I have understood, =
I could put:<br>IRO =3D 7 for hrtimer <br>IRQ =3D 8 for hrclock<br>IRQ =3D =
1 for sys_clk_timer <br>with&nbsp; this configuration =C2=B5Clinux without =
Xenomai with the 2 extra hrtimer and hrclock peripherals can boot&nbsp; on =
the board .<br>But I'm wondering why with the first configuration (IRO =3D =
1 for hrtimer,IRQ =3D 2 for hrclock and IRQ =3D 3 for sys_clk_timer), it di=
dn't boot? <span style=3D"font-family: monospace;"></span><br><blockquote t=
ype=3D"cite">=0A  <table style=3D"width: 527px; height: 57px;" border=3D"0"=
 cellpadding=3D"0" cellspacing=3D"0">=0A    <tbody>=0A      <tr>=0A        =
<td style=3D"font-family: inherit; font-style: inherit; font-variant: inher=
it; font-weight: inherit; font-size: inherit; line-height: inherit; font-si=
ze-adjust: inherit; font-stretch: inherit;" valign=3D"top"><font size=3D"2"=
>Please verify that you have correctly enabled all the right options under =
SOPC builder for hrtimer and hrclock.<br>=0ABecause we have flexibility in =
HW configuration with SoPC, we must be more careful.</font><br>=0A        <=
/td>=0A      </tr>=0A    </tbody>=0A  </table>=0A</blockquote>=0AConfigurat=
ion of hrtimer with the SoPC Builder:<br>=E2=80=A2 Timer: 32 bits.<br>=E2=
=80=A2 Timeout period: 1 =C2=B5s.<br>=E2=80=A2 Preset : custom. Writable pe=
riod, readable snapshot, Start/Stop control bits.<br><br>Configuration of h=
rclock with the SoPC Builder:<br>in the snapshot mode. Its configuration wi=
th the SoPC Builder tool is:<br>=E2=80=A2 64-bit timer.<br>=E2=80=A2 Timeou=
t period: 5 clocks. clock=3D20 ns (100 ns). The timer functionality is not =
used by Xenomai.<br>=E2=80=A2 Preset: custom. Writable period, readable sna=
pshot, Start/Stop control bits.<br><br>Is it correct?<br><blockquote type=
=3D"cite">=0A  <table style=3D"width: 527px; height: 36px;" border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0">=0A    <tbody>=0A      <tr>=0A        <td=
 style=3D"font-family: inherit; font-style: inherit; font-variant: inherit;=
 font-weight: inherit; font-size: inherit; line-height: inherit; font-size-=
adjust: inherit; font-stretch: inherit;" valign=3D"top"><font size=3D"2">Ac=
cording to errno.h, code -19&nbsp; is ENODEV, please verify your timer conf=
iguration and respect naming convention</font><br>=0A        </td>=0A      =
</tr>=0A    </tbody>=0A  </table>=0A</blockquote>=0AHere, you speek about "=
sys_clock_timer"?<br>Configuration of sys_clock_timer with the SoPC Builder=
: <br>=E2=80=A2 32-bit timer.<br>=E2=80=A2 Timeout period: 10 ms.<br>=E2=80=
=A2 Preset: custom. Writable period, readable snapshot, Start/Stop control =
bits.<br><br>Regards,<br><br></div></td></tr></table><br>=0A=0A=0A=0A=0A   =
   
--0-293075141-1270032906=:6829--

--0-1977120465-1270032906=:6829
Content-Type: text/x-chdr; name="nios2.h"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nios2.h"

I2lmbmRlZiBfX05JT1MyX0hfXwojZGVmaW5lIF9fTklPUzJfSF9fCgovKgog
KiBUaGlzIGZpbGUgY29udGFpbnMgaGFyZHdhcmUgaW5mb3JtYXRpb24gYWJv
dXQgdGhlIHRhcmdldCBwbGF0Zm9ybS4KICoKICogVGhpcyBmaWxlIGlzIGF1
dG9tYXRpY2FsbHkgZ2VuZXJhdGVkLiAgRG8gbm90IG1vZGlmeS4KICovCiAg
IAovKiBJbnB1dCBTeXN0ZW06IHN0ZF8xczQwICovCi8qIFRhcmdldCBDUFU6
IGNwdSAqLwoKLyogTmlvcyBJSSBDb25zdGFudHMgKi8KI2RlZmluZSBOSU9T
Ml9TVEFUVVNfUElFX01TSyAgMHgxCiNkZWZpbmUgTklPUzJfU1RBVFVTX1BJ
RV9PRlNUIDAKI2RlZmluZSBOSU9TMl9TVEFUVVNfVV9NU0sgICAgMHgyCiNk
ZWZpbmUgTklPUzJfU1RBVFVTX1VfT0ZTVCAgIDEKCi8qCiAqIE91dHB1dHRp
bmcgYmFzaWMgdmFsdWVzIGZyb20gc3lzdGVtLnB0Zi4KICovCgojZGVmaW5l
IG5hX3BsbCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDB4MDA4MTA4YzAKI2RlZmluZSBuYV9wbGxfY2xvY2tfZnJl
cSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDUwMDAw
MDAwCiNkZWZpbmUgbmFfZXh0X3JhbV9idXNfY2xvY2tfZnJlcSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA1MDAwMDAwMAojZGVmaW5lIG5hX2V4
dF9mbGFzaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDAwMDAwMDAwMDAKI2RlZmluZSBuYV9leHRfZmxhc2hfc2l6ZSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwODAwMDAwCiNk
ZWZpbmUgbmFfZXh0X2ZsYXNoX2VuZCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMHgwMDgwMDAwMAojZGVmaW5lIG5hX2V4dF9mbGFz
aF9jbG9ja19mcmVxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
NTAwMDAwMDAKI2RlZmluZSBuYV9leHRfcmFtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAweDAyMDAwMDAwCiNkZWZpbmUg
bmFfZXh0X3JhbV9zaXplICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgMHgwMDEwMDAwMAojZGVmaW5lIG5hX2V4dF9yYW1fZW5kICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDIxMDAw
MDAKI2RlZmluZSBuYV9leHRfcmFtX2Nsb2NrX2ZyZXEgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDUwMDAwMDAwCiNkZWZpbmUgbmFfb25j
aGlwX3JhbV82NF9rYnl0ZXMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgMHgwMjEwMDAwMAojZGVmaW5lIG5hX29uY2hpcF9yYW1fNjRfa2J5dGVz
X3NpemUgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAwMTAwMDAKI2Rl
ZmluZSBuYV9vbmNoaXBfcmFtXzY0X2tieXRlc19lbmQgICAgICAgICAgICAg
ICAgICAgICAgICAgICAweDAyMTEwMDAwCiNkZWZpbmUgbmFfb25jaGlwX3Jh
bV82NF9rYnl0ZXNfY2xvY2tfZnJlcSAgICAgICAgICAgICAgICAgICAgICAg
NTAwMDAwMDAKI2RlZmluZSBuYV9vbmNoaXBfcmFtXzY0X2tieXRlc19zMSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAweDAyMTAwMDAwCiNkZWZpbmUg
bmFfbGFuOTFjMTExICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgMHgwMDgwMDAwMAojZGVmaW5lIG5hX2xhbjkxYzExMV9pcnEg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDcKI2RlZmluZSBuYV9sYW45MWMxMTFfY2xvY2tfZnJlcSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDUwMDAwMDAwCiNkZWZpbmUgbmFfc3lz
X2Nsa190aW1lciAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgMHgwMDgxMDgwMAojZGVmaW5lIG5hX3N5c19jbGtfdGltZXJfaXJxICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDMKI2Rl
ZmluZSBuYV9zeXNfY2xrX3RpbWVyX2Nsb2NrX2ZyZXEgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDUwMDAwMDAwCiNkZWZpbmUgbmFfanRhZ191YXJ0
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgw
MDgxMDgyMAojZGVmaW5lIG5hX2p0YWdfdWFydF9pcnEgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDQKI2RlZmluZSBu
YV9qdGFnX3VhcnRfY2xvY2tfZnJlcSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDUwMDAwMDAwCiNkZWZpbmUgbmFfdWFydDEgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMDgxMDg0
MAojZGVmaW5lIG5hX3VhcnQxX2lycSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDUKI2RlZmluZSBuYV91YXJ0
MV9jbG9ja19mcmVxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDUwMDAwMDAwCiNkZWZpbmUgbmFfYnV0dG9uX3BpbyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMDgxMDgzMAojZGVm
aW5lIG5hX2J1dHRvbl9waW9faXJxICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDYKI2RlZmluZSBuYV9idXR0b25fcGlv
X2Nsb2NrX2ZyZXEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDUw
MDAwMDAwCiNkZWZpbmUgbmFfbGVkX3BpbyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgMHgwMDgxMDg4MAojZGVmaW5lIG5h
X2xlZF9waW9fY2xvY2tfZnJlcSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgNTAwMDAwMDAKI2RlZmluZSBuYV9zZXZlbl9zZWdfcGlvICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwODEwODkw
CiNkZWZpbmUgbmFfc2V2ZW5fc2VnX3Bpb19jbG9ja19mcmVxICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA1MDAwMDAwMAojZGVmaW5lIG5hX3JlY29u
ZmlnX3JlcXVlc3RfcGlvICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDB4MDA4MTA4YTAKI2RlZmluZSBuYV9yZWNvbmZpZ19yZXF1ZXN0X3Bpb19j
bG9ja19mcmVxICAgICAgICAgICAgICAgICAgICAgICA1MDAwMDAwMAojZGVm
aW5lIG5hX3NkcmFtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDB4MDEwMDAwMDAKI2RlZmluZSBuYV9zZHJhbV9zaXpl
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAx
MDAwMDAwCiNkZWZpbmUgbmFfc2RyYW1fZW5kICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgMHgwMjAwMDAwMAojZGVmaW5lIG5h
X3NkcmFtX2Nsb2NrX2ZyZXEgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgNTAwMDAwMDAKI2RlZmluZSBuYV9zeXNpZCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwODEwODI4
CiNkZWZpbmUgbmFfc3lzaWRfY2xvY2tfZnJlcSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA1MDAwMDAwMAojZGVmaW5lIG5hX2xjZF9k
aXNwbGF5ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDB4MDA4MTA4YjAKI2RlZmluZSBuYV9sY2RfZGlzcGxheV9jbG9ja19mcmVx
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDUwMDAwMDAwCiNkZWZp
bmUgbmFfaHJ0aW1lciAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMHgwMDgxMDg2MAojZGVmaW5lIG5hX2hydGltZXJfaXJx
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDEKI2RlZmluZSBuYV9ocnRpbWVyX2Nsb2NrX2ZyZXEgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDUwMDAwMDAwCiNkZWZpbmUgbmFf
aHJjbG9jayAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMHgwMDgxMDkwMAojZGVmaW5lIG5hX2hyY2xvY2tfaXJxICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDIK
I2RlZmluZSBuYV9ocmNsb2NrX2Nsb2NrX2ZyZXEgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDUwMDAwMDAwCiNkZWZpbmUgbmFfdWFydF8w
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
MHgwMDgxMDhlMAojZGVmaW5lIG5hX3VhcnRfMF9pcnEgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDgKI2RlZmlu
ZSBuYV91YXJ0XzBfY2xvY2tfZnJlcSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDUwMDAwMDAwCgovKiBFeGVjdXRpbmcgLi4uc2NyaXB0
cy9uaW9zMi5oL2FsdGVyYV9hdmFsb25fbGFuOTFjMTExLnBtICovCgovKiBS
ZWRlZmluaW5nIGxhbjkxYzExMSAtPiBlbmV0ICovCiN1bmRlZiBuYV9sYW45
MWMxMTEKI3VuZGVmIG5hX2xhbjkxYzExMV9pcnEKCiNkZWZpbmUgbmFfZW5l
dCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgMHgwMDgwMDAwMAojZGVmaW5lIG5hX2VuZXRfaXJxICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDcKCiNk
ZWZpbmUgTEFOOTFDMTExX1JFR0lTVEVSU19PRkZTRVQgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDc2OAojZGVmaW5lIExBTjkxQzExMV9E
QVRBX0JVU19XSURUSCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMzIKCi8qIEV4ZWN1dGluZyAuLi5zY3JpcHRzL25pb3MyLmgvYWx0
ZXJhX2F2YWxvbl90aW1lci5wbSAqLwoKLyogc3lzdGVtIHRpbWVyIGlucHV0
IGNsb2NrIGZyZXF1ZW5jeSAqLwojZGVmaW5lIG5hc3lzX2Nsb2NrX2ZyZXEg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNTAwMDAw
MDAKI2RlZmluZSBuYXN5c19jbG9ja19mcmVxXzEwMDAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDUwMDAwCgovKiBSZWRlZmluaW5n
IHN5c19jbGtfdGltZXIgLT4gdGltZXIwICovCiN1bmRlZiBuYV9zeXNfY2xr
X3RpbWVyCiN1bmRlZiBuYV9zeXNfY2xrX3RpbWVyX2lycQoKI2RlZmluZSBu
YV90aW1lcjAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKCh2
b2lkICopIDB4MDA4MTA4MDApCiNkZWZpbmUgbmFfdGltZXIwX2lycSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
MwoKLyogRXhlY3V0aW5nIC4uLnNjcmlwdHMvbmlvczIuaC9hbHRlcmFfYXZh
bG9uX2p0YWdfdWFydC5wbSAqLwoKLyogTm8gdHJhbnNsYXRpb24gbmVjZXNz
YXJ5IGZvciBqdGFnX3VhcnQgKi8KCi8qIEV4ZWN1dGluZyAuLi5zY3JpcHRz
L25pb3MyLmgvYWx0ZXJhX2F2YWxvbl91YXJ0LnBtICovCgovKiBSZWRlZmlu
aW5nIHVhcnQxIC0+IHVhcnQwICovCiN1bmRlZiBuYV91YXJ0MQojdW5kZWYg
bmFfdWFydDFfaXJxCgojZGVmaW5lIG5hX3VhcnQwICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICgodm9pZCAqKikgMHgwMDgxMDg0MCkKI2Rl
ZmluZSBuYV91YXJ0MF9pcnEgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA1CgovKiBUaGUgZGVmYXVsdCB1YXJ0
IGlzIGFsd2F5cyB0aGUgZmlyc3Qgb25lIGZvdW5kIGluIHRoZSBQVEYgZmls
ZSAqLwojZGVmaW5lIG5hc3lzX3ByaW50Zl91YXJ0IG5hX3VhcnQwCgovKiBS
ZWRlZmluaW5nIHVhcnRfMCAtPiB1YXJ0MSAqLwojdW5kZWYgbmFfdWFydF8w
CiN1bmRlZiBuYV91YXJ0XzBfaXJxCgojZGVmaW5lIG5hX3VhcnQxICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICgodm9pZCAqKikgMHgwMDgx
MDhlMCkKI2RlZmluZSBuYV91YXJ0MV9pcnEgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA4CgovKiBFeGVjdXRp
bmcgLi4uc2NyaXB0cy9uaW9zMi5oL2FsdGVyYV9hdmFsb25fcGlvLnBtICov
CiNpZm5kZWYgX19BU1NFTUJMWV9fCiNpbmNsdWRlIDxhc20vcGlvX3N0cnVj
dC5oPgojZW5kaWYKCi8qIENhc3RpbmcgYmFzZSBhZGRyZXNzZXMgdG8gdGhl
IGFwcHJvcHJpYXRlIHN0cnVjdHVyZSAqLwojdW5kZWYgbmFfYnV0dG9uX3Bp
bwojdW5kZWYgbmFfYnV0dG9uX3Bpb19pcnEKCiNkZWZpbmUgbmFfYnV0dG9u
X3BpbyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKChucF9waW8qKSAw
eDAwODEwODMwKQojZGVmaW5lIG5hX2J1dHRvbl9waW9faXJxICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDYKCi8qIENh
c3RpbmcgYmFzZSBhZGRyZXNzZXMgdG8gdGhlIGFwcHJvcHJpYXRlIHN0cnVj
dHVyZSAqLwojdW5kZWYgbmFfbGVkX3BpbwojZGVmaW5lIG5hX2xlZF9waW8g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgobnBfcGlvKikgMHgw
MDgxMDg4MCkKCi8qIENhc3RpbmcgYmFzZSBhZGRyZXNzZXMgdG8gdGhlIGFw
cHJvcHJpYXRlIHN0cnVjdHVyZSAqLwojdW5kZWYgbmFfc2V2ZW5fc2VnX3Bp
bwojZGVmaW5lIG5hX3NldmVuX3NlZ19waW8gICAgICAgICAgICAgICAgICAg
ICAgICAgICgobnBfcGlvKikgMHgwMDgxMDg5MCkKCi8qIENhc3RpbmcgYmFz
ZSBhZGRyZXNzZXMgdG8gdGhlIGFwcHJvcHJpYXRlIHN0cnVjdHVyZSAqLwoj
dW5kZWYgbmFfcmVjb25maWdfcmVxdWVzdF9waW8KI2RlZmluZSBuYV9yZWNv
bmZpZ19yZXF1ZXN0X3BpbyAgICAgICAgICAgICAgICAgICAoKG5wX3Bpbyop
IDB4MDA4MTA4YTApCgovKiBFeGVjdXRpbmcgLi4uc2NyaXB0cy9uaW9zMi5o
L2FsdGVyYV9hdmFsb25fc3lzaWQucG0gKi8KCi8qIE5vIHRyYW5zbGF0aW9u
IG5lY2Vzc2FyeSBmb3Igc3lzaWQgKi8KCi8qCiAqIEJhc2ljIFN5c3RlbSBJ
bmZvcm1hdGlvbgogKi8KI2RlZmluZSBuYXN5c19pY2FjaGVfc2l6ZSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA0MDk2CiNk
ZWZpbmUgbmFzeXNfaWNhY2hlX2xpbmVfc2l6ZSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAzMgojZGVmaW5lIG5hc3lzX2RjYWNo
ZV9zaXplICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDAKI2RlZmluZSBuYXN5c19kY2FjaGVfbGluZV9zaXplICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwCgojZGVmaW5l
IG5hc3lzX3Byb2dyYW1fbWVtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbmFfc2RyYW0KI2RlZmluZSBuYXN5c19wcm9ncmFtX21l
bV9zaXplICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuYV9zZHJhbV9z
aXplCiNkZWZpbmUgbmFzeXNfcHJvZ3JhbV9tZW1fZW5kICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG5hX3NkcmFtX2VuZAoKCiNkZWZpbmUgbmFf
Y3B1X2Nsb2NrX2ZyZXEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA1MDAwMDAwMAojZGVmaW5lIENQVV9SRVNFVF9BRERSRVNTICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAwMDAwMDAwMDAK
I2RlZmluZSBDUFVfRVhDRVBUX0FERFJFU1MgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAweDAxMDAwMDIwCgojZW5kaWYgLyogX19OSU9T
Ml9IX18gKi8K

--0-1977120465-1270032906=:6829--


