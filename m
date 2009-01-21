Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C97B60.CB8DED50"
Date: Tue, 20 Jan 2009 17:40:01 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D534028@domain.hid>
In-Reply-To: <4975E612.9040708@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D533F9A@slcmail.slc.mew.int>
	<49757B25.8020500@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB0@domain.hid>
	<4975E491.1040506@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB6@domain.hid>
	<4975E612.9040708@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] fpu issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


This is a multi-part message in MIME format.

------_=_NextPart_001_01C97B60.CB8DED50
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello everyone. I have the dumps here from the header file that Gilles
was kind enough to provide to me.

When the problem does not occur:

sizeof(fpreg_t): 12
cwd: 0000037f,  swd: 00000000
fip: 08048c3e,  fcs: 01d00073
foo: 0959961c,  fos: 0000007b
FPU registers stack, top at 0:
7: Empty
6: Empty
5: Empty
4: Empty
3: Empty
2: Empty
1: Empty
0: Empty

When the problem does occur:

sizeof(fpreg_t): 12
cwd: 0000037f,  swd: 00000000
fip: 08048c3e,  fcs: 01d00073
foo: 00000000,  fos: 00000000
FPU registers stack, top at 0:
7:  10.000000000
6:  25.000000000
5: 0
4: 0
3: 0
2: 0
1: 0
0: - inf.

What's interesting is that 10.0 and 25.0 are coming from my other task.
I will attach my code as well. You can see that I'm dumping these values
in func2, and it seems that the FPU is perhaps left in an undesirable
state by func?

This problem occurs on a geode GX1 and a geode LX800. I hate geodes.

Steven



> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Tuesday, January 20, 2009 7:56 AM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] fpu issue
>=20
> Steven Seeger wrote:
> > I do not have fxsr support. I noticed that instruction being used
and
> > didn't find it in my datasheet. I guess my question is you want me
to
> > dump the fpu state before I initialize the volatile doubles.
However,
> I
> > don't have a saved state at that point. What exactly do I pass in?
Or
> do
> > you want me to save and then dump?
>=20
> Yes, save then dump.
>=20
> --
>                                                  Gilles.

------_=_NextPart_001_01C97B60.CB8DED50
Content-Type: application/octet-stream;
	name="double_test.cpp"
Content-Transfer-Encoding: base64
Content-Description: double_test.cpp
Content-Disposition: attachment;
	filename="double_test.cpp"

I2luY2x1ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDxpb3N0cmVhbT4KI2luY2x1ZGUgPG5hdGl2
ZS90YXNrLmg+CiNpbmNsdWRlICJpMzg3LmgiCgpzdGF0aWMgUlRfVEFTSyB0YXNrLHRhc2syOwoK
dm9pZCBmdW5jKHZvaWQqKQp7CiAgICB2b2xhdGlsZSBkb3VibGUgbWluID0gMTAuMDsKICAgIHZv
bGF0aWxlIGRvdWJsZSB2YWwgPSAyNS4wOwogICAgCiAgICBmb3IoOzspCiAgICB7CiAgICAgICAg
aWYodmFsID4gbWluKSB7CiAgICAgICAgICAgIAogICAgICAgIH0KICAgICAgICBlbHNlIHN0ZDo6
Y291dCA8PCAic2hvdWxkbid0IHNlZSB0aGlzICIgPDwgbWluIDw8ICcgJyA8PCB2YWwgPDwgc3Rk
OjplbmRsOwogICAgICAgIAogICAgICAgIHJ0X3Rhc2tfc2xlZXAoMTAwMDAwKTsKICAgIH0KICAg
IAp9CgovL3N0YXRpYyBjb25zdCBkb3VibGUgbWluID0gNS4wOwovL3N0YXRpYyBjb25zdCBkb3Vi
bGUgdmFsID0gMjAuMDsKCnZvaWQgX2Z1bmMyKHZvaWQqKQp7CiAgICBmcGVudl90IGVudjsKICAg
IAogICAgb2xkX3NhdmVfZnAoJmVudik7CiAgICBkdW1wX29sZF9mcCgmZW52KTsKICAgIGNvbnN0
IGRvdWJsZSBtaW4gPSA1LjA7CiAgICBjb25zdCBkb3VibGUgdmFsID0gMjAuMDsKICAgIC8vY29u
c3QgdW5zaWduZWQgbG9uZyBsb25nIG1pbiA9IDU7CiAgICAvL2NvbnN0IHVuc2lnbmVkIGxvbmcg
bG9uZyB2YWwgPSAyMDsKICAgIAogICAgdW5zaWduZWQgY2hhciBnYXJiYWdlWzhdID0geyAwLCAw
LCAwLCAwLCAwLCAwLCAtOCwgLTEgfTsKICAgIAogICAgLy9ydF90YXNrX3NsZWVwKDUwMDAwMDAw
MCk7CgogICAgc3RkOjpjb3V0IDw8ICJjcmFwOiAiIDw8ICooZG91YmxlKilnYXJiYWdlIDw8IHN0
ZDo6ZW5kbDsKICAgIHN0ZDo6Y291dCA8PCAic2hvdWxkIHNlZSB0aGlzICIgPDwgbWluIDw8ICcg
JyA8PCB2YWwgPDwgJyAnIDw8ICh2b2lkKikmbWluIDw8ICcgJyA8PCAodm9pZCopJnZhbCA8PCBz
dGQ6OmVuZGw7CiAgICBzdGQ6OmNvdXQgPDwgKGludCkoY2hhcikoKGNoYXIqKSZtaW4pWzBdIDw8
ICIsICIgPDwgCiAgICAoaW50KShjaGFyKSgoY2hhciopJm1pbilbMV0gPDwgIiwgIiA8PCAKICAg
IChpbnQpKGNoYXIpKChjaGFyKikmbWluKVsyXSA8PCAiLCAiIDw8IAogICAgKGludCkoY2hhciko
KGNoYXIqKSZtaW4pWzNdIDw8ICIsICIgPDwgCiAgICAoaW50KShjaGFyKSgoY2hhciopJm1pbilb
NF0gPDwgIiwgIiA8PCAKICAgIChpbnQpKGNoYXIpKChjaGFyKikmbWluKVs1XSA8PCAiLCAiIDw8
IAogICAgKGludCkoY2hhcikoKGNoYXIqKSZtaW4pWzZdIDw8ICIsICIgPDwgCiAgICAoaW50KShj
aGFyKSgoY2hhciopJm1pbilbN10gPDwgIiwgIiA8PCAgc3RkOjplbmRsOwogICAgCiAgICBmb3Io
OzspCiAgICB7CiAgICAgICAgaWYodmFsID4gbWluKSB7CiAgICAgICAgICAgIAogICAgICAgIH0K
ICAgICAgICBlbHNlIHsKICAgICAgICAgICAgc3RkOjpjb3V0IDw8ICJzaG91bGRuJ3Qgc2VlIHRo
aXMgIiA8PCBtaW4gPDwgJyAnIDw8IHZhbCA8PCAnICcgPDwgKHZvaWQqKSZtaW4gPDwgJyAnIDw8
ICh2b2lkKikmdmFsICA8PCBzdGQ6OmVuZGw7CiAgICAgICAgfQogICAgICAgIAogICAgICAgIHJ0
X3Rhc2tfc2xlZXAoMTAwMDAwKTsKICAgIH0KfQoKdm9pZCBmdW5jMih2b2lkKikKewogICAgLy92
b2xhdGlsZSBkb3VibGUgZCA9IDEyMy4wOwogICAgLy9kICs9IDUuMDsKICAgIAogICAgX2Z1bmMy
KE5VTEwpOwp9CgppbnQgbWFpbigpCnsKICAgIG1sb2NrYWxsKE1DTF9DVVJSRU5UIHwgTUNMX0ZV
VFVSRSk7CiAgICAKICAgIHJ0X3Rhc2tfc3Bhd24oJnRhc2ssICJkdW1teSIsIDAsIDYwLCBUX0ZQ
VSwgZnVuYywgTlVMTCk7CiAgICBydF90YXNrX3NwYXduKCZ0YXNrMiwgImR1bW15MiIsIDAsIDUw
LCBUX0ZQVSwgZnVuYzIsIE5VTEwpOwogICAgCiAgICB1c2xlZXAoNTAwMDAwKTsKICAgIAogICAg
cmV0dXJuIDA7Cn0K

------_=_NextPart_001_01C97B60.CB8DED50--

