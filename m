Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C63DFB.7471E35C"
Subject: AW: AW: AW: [Xenomai-core] vxworks-skin taskSpawn
Date: Thu, 2 Mar 2006 14:16:01 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A1C4016@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C63DFB.7471E35C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote :

> Could you try running "strace" on your program? TIA,=20

Thank you for your suggestion ! Please find attached a textfile =
containing the output of strace. I hope it is more instructive to you =
than it is to me (meaning : please have a look on it).

Took me about 2 hours to figure out what TIA is.
Now I think it is an other example for your laziness ;-)))
(for everybody else whose naitive language is not english : TIA =3D =
Thanks in advance, I hope ;-)  )

By the way : thank you for your "long story" about the background of =
vxworks and UVMs, very interesting !

Best Regards
Roderik

> -----Urspr=FCngliche Nachricht-----
> Von: Philippe Gerum [mailto:rpm@xenomai.org
> Gesendet: Mittwoch, 1. M=E4rz 2006 14:46
> An: Wildenburg, Roderik RAEK3 MRA
> Cc: gilles.chanteperdrix@xenomai.org; xenomai@xenomai.org
> Betreff: Re: AW: AW: [Xenomai-core] vxworks-skin taskSpawn
>=20
> Roderik_Wildenburg@domain.hid wrote:
> > Philippe Gerum wrote :
> >=20
> >>I've run the satch example successfully on an Icecube board=20
> here using=20
> >>-rc2.
> >>What's the status of this issue on your side? Was it a timer=20
> >>configuration issue as suspected by Gilles?
> >>
> >=20
> >=20
> > Status is unchanged. I still try to debugg satch with=20
> gdb/ddd and have been a little bit successfull with this.
>   But I face more and more problems the deeper I dig into the=20
> system (e.g.=20
> unresolved symbols when compiling vxWorks-examples
>   with --debug enabled (see other thread)
>=20
> This has been fixed in the repository:
> http://mail.gna.org/public/xenomai-help/2006-02/msg00149.html
>=20
>   or now, gdb moans about "cannot find bounds of current=20
> function" (do you have any idea, what this means ?))
> >=20
>=20
> It means that GDB is confused actually; while stepping into=20
> some code, it could=20
> not locate the routine the current text address belongs too.=20
> This might happen=20
> when interrupting the program execution while it was running=20
> some code GDB has no=20
> symbolic information about. Nothing to worry about, unless=20
> GDB would not find any=20
> symbol at all.
>=20
> > I don=B4t think it is a timer problem, as my timer is running=20
> in oneshot mode and not in
>   continous mode what causes the problem on Gilles system.=20
> But I am not shure.
>=20
> Could you try running "strace" on your program? TIA,
>=20
> >=20
> > Nevertheless, thank you for asking !! If you have any other=20
> suggestions what I can do, please let me know. I will inform=20
> you when the status changes on my side.
> >=20
> > Best Regards
> > Roderik
> >=20
> >=20
> >=20
>=20
>=20
> --=20
>=20
> Philippe.
>=20

------_=_NextPart_001_01C63DFB.7471E35C
Content-Type: text/plain;
	name="strace_satch_vxworks.txt"
Content-Transfer-Encoding: base64
Content-Description: strace_satch_vxworks.txt
Content-Disposition: attachment;
	filename="strace_satch_vxworks.txt"

fiAjIGluc21vZCB4ZW5vX3V2bS5vDQpVc2luZyAvbGliL21vZHVsZXMvMi40LjI1L2tlcm5lbC9r
ZXJuZWwveGVub21haS9za2lucy91dm0veGVub191dm0ubw0KfiAjIGNkIC9tYzQ1L2FwcC94ZW5v
YXBwLw0KL21jNDUvYXBwL3hlbm9hcHAgIyBscw0KMSAgICAgICAgIE1ha2VmaWxlICBrb2FuLmMg
ICAgc2F0Y2guYw0KMiAgICAgICAgIGtvYW4gICAgICBzYXRjaCAgICAgc2F0Y2guY34NCi9tYzQ1
L2FwcC94ZW5vYXBwICMgc3RyYWNlIC4vc2F0Y2gNCmV4ZWN2ZSgiLi9zYXRjaCIsIFsiLi9zYXRj
aCJdLCBbLyogOCB2YXJzICovXSkgPSAwDQp1bmFtZSh7c3lzPSJMaW51eCIsIG5vZGU9ImFydjAw
NDMiLCAuLi59KSA9IDANCmJyaygwKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9
IDB4MTAwMmQxMDQNCm9wZW4oIi9ldGMvbGQuc28ucHJlbG9hZCIsIE9fUkRPTkxZKSAgICA9IC0x
IEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkNCm9wZW4oIi9ldGMvbGQuc28uY2Fj
aGUiLCBPX1JET05MWSkgICAgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9y
eSkNCm9wZW4oIi9saWIvbGlidXZtLnNvLjAiLCBPX1JET05MWSkgICAgICA9IC0xIEVOT0VOVCAo
Tm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkNCnN0YXQ2NCgiL2xpYiIsIHtzdF9tb2RlPVNfSUZE
SVJ8MDc3NSwgc3Rfc2l6ZT0xMDI0LCAuLi59KSA9IDANCm9wZW4oIi91c3IvbGliL2xpYnV2bS5z
by4wIiwgT19SRE9OTFkpICA9IDMNCnJlYWQoMywgIlwxNzdFTEZcMVwyXDFcMFwwXDBcMFwwXDBc
MFwwXDBcMFwzXDBcMjRcMFwwXDBcMVwwXDBcMzQiLi4uLCAxMDI0KSA9IDEwMjQNCmZzdGF0NjQo
Mywge3N0X21vZGU9U19JRlJFR3wwNzU1LCBzdF9zaXplPTU5NDQwLCAuLi59KSA9IDANCm1tYXAo
MHhmZmRjMDAwLCA4MTc4NCwgUFJPVF9SRUFEfFBST1RfRVhFQywgTUFQX1BSSVZBVEUsIDMsIDAp
ID0gMHhmZmRjMDAwDQptcHJvdGVjdCgweGZmZTAwMDAsIDY1NDAwLCBQUk9UX05PTkUpICAgPSAw
DQptbWFwKDB4ZmZlYzAwMCwgMTYzODQsIFBST1RfUkVBRHxQUk9UX1dSSVRFfFBST1RfRVhFQywg
TUFQX1BSSVZBVEV8TUFQX0ZJWEVELCAzLCAwKSA9IDB4ZmZlYzAwMA0KY2xvc2UoMykgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgID0gMA0Kb3BlbigiL2xpYi9saWJwdGhyZWFkLnNvLjAi
LCBPX1JET05MWSkgID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQ0Kb3Bl
bigiL3Vzci9saWIvbGlicHRocmVhZC5zby4wIiwgT19SRE9OTFkpID0gMw0KcmVhZCgzLCAiXDE3
N0VMRlwxXDJcMVwwXDBcMFwwXDBcMFwwXDBcMFwwXDNcMFwyNFwwXDBcMFwxXDBcMEBcMzc0Ii4u
LiwgMTAyNCkgPSAxMDI0DQpmc3RhdDY0KDMsIHtzdF9tb2RlPVNfSUZSRUd8MDc1NSwgc3Rfc2l6
ZT0xNDE2NTI4LCAuLi59KSA9IDANCm1tYXAoTlVMTCwgNDA5NiwgUFJPVF9SRUFEfFBST1RfV1JJ
VEUsIE1BUF9QUklWQVRFfE1BUF9BTk9OWU1PVVMsIC0xLCAwKSA9IDB4MzAwMTUwMDANCm1tYXAo
MHhmZjZiMDAwLCAzOTU3NzYsIFBST1RfUkVBRHxQUk9UX0VYRUMsIE1BUF9QUklWQVRFLCAzLCAw
KSA9IDB4ZmY2YjAwMA0KbXByb3RlY3QoMHhmZjc5MDAwLCAzMzg0MzIsIFBST1RfTk9ORSkgID0g
MA0KbW1hcCgweGZmN2IwMDAsIDY5NjMyLCBQUk9UX1JFQUR8UFJPVF9XUklURXxQUk9UX0VYRUMs
IE1BUF9QUklWQVRFfE1BUF9GSVhFRCwgMywgMCkgPSAweGZmN2IwMDANCm1tYXAoMHhmZjhjMDAw
LCAyNjA2MDgsIFBST1RfUkVBRHxQUk9UX1dSSVRFfFBST1RfRVhFQywgTUFQX1BSSVZBVEV8TUFQ
X0ZJWEVEfE1BUF9BTk9OWU1PVVMsIC0xLCAwKSA9IDB4ZmY4YzAwMA0KY2xvc2UoMykgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgID0gMA0Kb3BlbigiL2xpYi9saWJjLnNvLjYiLCBPX1JE
T05MWSkgICAgICAgID0gMw0KcmVhZCgzLCAiXDE3N0VMRlwxXDJcMVwwXDBcMFwwXDBcMFwwXDBc
MFwwXDNcMFwyNFwwXDBcMFwxXDBcMVwzMDAiLi4uLCAxMDI0KSA9IDEwMjQNCmZzdGF0NjQoMywg
e3N0X21vZGU9U19JRlJFR3wwNzU1LCBzdF9zaXplPTEzNjM4ODgsIC4uLn0pID0gMA0KbW1hcCgw
eGZlMGMwMDAsIDEzNzAxMjgsIFBST1RfUkVBRHxQUk9UX0VYRUMsIE1BUF9QUklWQVRFLCAzLCAw
KSA9IDB4ZmUwYzAwMA0KbXByb3RlY3QoMHhmZjQzMDAwLCA5NjI3MiwgUFJPVF9OT05FKSAgID0g
MA0KbW1hcCgweGZmNGMwMDAsIDQ5MTUyLCBQUk9UX1JFQUR8UFJPVF9XUklURXxQUk9UX0VYRUMs
IE1BUF9QUklWQVRFfE1BUF9GSVhFRCwgMywgMHgxMzAwMDApID0gMHhmZjRjMDAwDQptbWFwKDB4
ZmY1ODAwMCwgMTAyNTYsIFBST1RfUkVBRHxQUk9UX1dSSVRFfFBST1RfRVhFQywgTUFQX1BSSVZB
VEV8TUFQX0ZJWEVEfE1BUF9BTk9OWU1PVVMsIC0xLCAwKSA9IDB4ZmY1ODAwMA0KY2xvc2UoMykg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMA0KbXByb3RlY3QoMHhmZTBjMDAwLCAx
MjczODU2LCBQUk9UX1JFQUR8UFJPVF9XUklURSkgPSAwDQptcHJvdGVjdCgweGZlMGMwMDAsIDEy
NzM4NTYsIFBST1RfUkVBRHxQUk9UX0VYRUMpID0gMA0KZ2V0cGlkKCkgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgID0gMTI3DQpydF9zaWdhY3Rpb24oU0lHUlRNSU4sIHsweGZmNzM2OTAs
IFtdLCAwfSwgTlVMTCwgOCkgPSAwDQpydF9zaWdhY3Rpb24oU0lHUlRfMSwgezB4ZmY3MzU0OCwg
W10sIDB9LCBOVUxMLCA4KSA9IDANCnJ0X3NpZ2FjdGlvbihTSUdSVF8yLCB7MHhmZjczNmM4LCBb
XSwgMH0sIE5VTEwsIDgpID0gMA0KcnRfc2lncHJvY21hc2soU0lHX0JMT0NLLCBbUlRNSU5dLCBO
VUxMLCA4KSA9IDANCl9zeXNjdGwoe3tDVExfS0VSTiwgS0VSTl9WRVJTSU9OfSwgMiwgMHg3ZmZm
ZmJiOCwgMzIsIChuaWwpLCAwfSkgPSAwDQpicmsoMCkgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgPSAweDEwMDJkMTA0DQpicmsoMHgxMDAyZTEwNCkgICAgICAgICAgICAgICAgICAg
ICAgICAgPSAweDEwMDJlMTA0DQpicmsoMHgxMDAyZjAwMCkgICAgICAgICAgICAgICAgICAgICAg
ICAgPSAweDEwMDJmMDAwDQpnZXRldWlkKCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
PSAwDQpicmsoMHgxMDAzMjAwMCkgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDEwMDMyMDAw
DQpmc3RhdDY0KDEsIHtzdF9tb2RlPVNfSUZDSFJ8MDYwMCwgc3RfcmRldj1tYWtlZGV2KDMsIDAp
LCAuLi59KSA9IDANCmlvY3RsKDEsIFRDR0VUUywge0IzODQwMCBvcG9zdCBpc2lnIGljYW5vbiBl
Y2hvIC4uLn0pID0gMA0KbW1hcChOVUxMLCA0MDk2LCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQ
X1BSSVZBVEV8TUFQX0FOT05ZTU9VUywgLTEsIDApID0gMHgzMDAxNjAwMA0Kd3JpdGUoMSwgIlhl
bm9tYWkvdXZtOiByZWFsLXRpbWUgbnVjbGV1cyB2Ii4uLiwgNjBYZW5vbWFpL3V2bTogcmVhbC10
aW1lIG51Y2xldXMgdjIuMS1yYzIgKENoYW1wYWduZSkgbG9hZGVkLg0KKSA9IDYwDQptbWFwKE5V
TEwsIDEzNTE2OCwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9BTk9OWU1P
VVMsIC0xLCAwKSA9IDB4MzAwMjYwMDANCnNjaGVkX2dldF9wcmlvcml0eV9taW4oMHgxKSAgICAg
ICAgICAgICA9IDENCnNjaGVkX3NldHNjaGVkdWxlcigwLCAweDEsIDB4N2ZmZmZjYTQpICA9IDAN
CnJ0X3NpZ2FjdGlvbihTSUdDSExELCB7MHhmZjc2ZDVjLCBbQ0hMRF0sIFNBX1JFU1RBUlR9LCB7
U0lHX0RGTH0sIDgpID0gMA0KdWdldHJsaW1pdCgweDMsIDB4N2ZmZmY3NjgpICAgICAgICAgICAg
ID0gMA0KYnJrKDB4MTAwMzQwMDApICAgICAgICAgICAgICAgICAgICAgICAgID0gMHgxMDAzNDAw
MA0KcGlwZShbMywgNF0pICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMA0KY2xvbmUoY2hp
bGRfc3RhY2s9MHgxMDAzMzE1MCwgZmxhZ3M9Q0xPTkVfVk18Q0xPTkVfRlN8Q0xPTkVfRklMRVN8
Q0xPTkVfU0lHSEFORCkgPSAxMjgNCndyaXRlKDQsICJEQlwiQlwwXDBcMFwwMDUwXDFQXDBcMTdc
MzY2XDMyMVgwXDJRXDMzMFwwXDBcMFwwXDE3N1wzNzciLi4uLCAxNDgpID0gMTQ4DQpydF9zaWdw
cm9jbWFzayhTSUdfU0VUTUFTSywgTlVMTCwgW1JUTUlOXSwgOCkgPSAwDQp3cml0ZSg0LCAiXDE3
XDM3MFwyMTBAXDBcMFwwXDBcMTc3XDM3N1wzNzRgXDIwXDAtXDM1NFwxNzdcMzc3XDM3NCIuLi4s
IDE0OCkgPSAxNDgNCnJ0X3NpZ3Byb2NtYXNrKFNJR19TRVRNQVNLLCBOVUxMLCBbUlRNSU5dLCA4
KSA9IDANCnJ0X3NpZ3N1c3BlbmQoW10gPHVuZmluaXNoZWQgLi4uPg0KLS0tIFNJR1JUTUlOIChV
bmtub3duIHNpZ25hbCAzMikgQCAwICgwKSAtLS0NCjwuLi4gcnRfc2lnc3VzcGVuZCByZXN1bWVk
PiApICAgICAgICAgICA9IC0xIEVQSVBFIChCcm9rZW4gcGlwZSkNCmdldHRpbWVvZmRheSh7MTc5
NzMyMTEwMSwgNTU3MTQ5fSwgTlVMTCkgPSAwDQp3cml0ZSgxLCAic3RhcnRpbmcgVnhXb3JrcyBz
ZXJ2aWNlcy5cbiIsIDI3c3RhcnRpbmcgVnhXb3JrcyBzZXJ2aWNlcy4NCikgPSAyNw0Kd3JpdGUo
MSwgInNwYXduaW5nIGNvbnN1bWVyIDgwNTQ2MjgyNFxuIiwgMjhzcGF3bmluZyBjb25zdW1lciA4
MDU0NjI4MjQNCikgPSAyOA0KcnRfc2lncHJvY21hc2soU0lHX1NFVE1BU0ssIE5VTEwsIFtSVE1J
Tl0sIDgpID0gMA0Kd3JpdGUoNCwgIlwxN1wzNzBcMjEwQFwwXDBcMFwwXDE3N1wzNzdcMzczXDMy
MFwyMFwwLlwzNzAwXDJleFwyMDAiLi4uLCAxNDgpID0gMTQ4DQpydF9zaWdwcm9jbWFzayhTSUdf
U0VUTUFTSywgTlVMTCwgW1JUTUlOXSwgOCkgPSAwDQpydF9zaWdzdXNwZW5kKFtdIDx1bmZpbmlz
aGVkIC4uLj4NCi0tLSBTSUdSVE1JTiAoVW5rbm93biBzaWduYWwgMzIpIEAgMCAoMCkgLS0tDQo8
Li4uIHJ0X3NpZ3N1c3BlbmQgcmVzdW1lZD4gKSAgICAgICAgICAgPSAtMSBFUElQRSAoQnJva2Vu
IHBpcGUpDQoNCg==

------_=_NextPart_001_01C63DFB.7471E35C--

