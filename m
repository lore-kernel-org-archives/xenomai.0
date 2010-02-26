Message-ID: <4B87CE3E.2070402@domain.hid>
Date: Fri, 26 Feb 2010 14:35:58 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B6E8167.6010907@domain.hid>	<4B76B7F2.2050303@domain.hid>	<4B76C045.2070602@domain.hid>	<1266140329.27019.17.camel@domain.hid>	<4B867EB5.9090504@domain.hid>	<4B867FF9.2020709@domain.hid>	<4B868228.10206@domain.hid>
	<4B868958.3000503@domain.hid> <4B86B0DB.4000600@domain.hid>
In-Reply-To: <4B86B0DB.4000600@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig050B67FC72DFD433907B61AC"
Subject: Re: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig050B67FC72DFD433907B61AC
Content-Type: multipart/mixed;
 boundary="------------030509060107080400090407"

This is a multi-part message in MIME format.
--------------030509060107080400090407
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 25.02.2010 18:18, schrieb Stefan Kisdaroczi:
> <snip>
>>>
>>> Hi Gilles,
>>>
>>> can a init.d script with
>>>   echo "<gid>" > /sys/module/xeno_nucleus/parameters/xenomai_gid
>>> work in module and builtin case ?
>>
>> it seems that init.d will work for the builtin case and modprobe.d for=
 the
>> module case. So adding both should work "in all cases" :-)
>> I'll give it a try ...
>=20
> Attached a patch that adds a init-script /etc/init.d/xenomai to the pac=
kage libxenomai1.
> If group xenomai and the file /sys/module/xeno_nucleus/parameters/xenom=
ai_gid are found,
> xenomai_gid is set on startup.
>=20
> Now looking at modprobe.d ...

I have attached a patch against debian xenomai version 2.5.1-4, changes:
 - create group xenomai on install
 - added a init-script which sets /sys/.../xenomai_gid if
   /sys/.../xenomai_gid exists
 - added a modprobe-script that adds the xenomai_gid parameter if the use=
r
   did call modprobe without xenomai_gid=3D

With this changes, all users which are member of the group xenomai are ab=
le
to run xenomai apps, with xeno_nucleus builtin or as a module.

Please do not merge anywhere for now, comments are welcome.

Stefan

--------------030509060107080400090407
Content-Type: text/plain;
 name="xenomai-group-debian.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="xenomai-group-debian.patch"

ZGlmZiAtdU5ycCB4ZW5vbWFpLTIuNS4xLm9yaWcvZGViaWFuL2xpYnhlbm9tYWkxLmRpcnMg
eGVub21haS0yLjUuMS9kZWJpYW4vbGlieGVub21haTEuZGlycw0KLS0tIHhlbm9tYWktMi41
LjEub3JpZy9kZWJpYW4vbGlieGVub21haTEuZGlycwkyMDEwLTAyLTI2IDAxOjAxOjA3LjAw
MDAwMDAwMCArMDEwMA0KKysrIHhlbm9tYWktMi41LjEvZGViaWFuL2xpYnhlbm9tYWkxLmRp
cnMJMjAxMC0wMi0yNiAwMToxNjoxMy4wMDAwMDAwMDAgKzAxMDANCkBAIC0xLDIgKzEsMyBA
QA0KK2V0Yy9tb2Rwcm9iZS5kDQogZXRjL3VkZXYvcnVsZXMuZA0KIHVzci9zaGFyZS9saW50
aWFuL292ZXJyaWRlcw0KZGlmZiAtdU5ycCB4ZW5vbWFpLTIuNS4xLm9yaWcvZGViaWFuL2xp
Ynhlbm9tYWkxLm1vZHByb2JlIHhlbm9tYWktMi41LjEvZGViaWFuL2xpYnhlbm9tYWkxLm1v
ZHByb2JlDQotLS0geGVub21haS0yLjUuMS5vcmlnL2RlYmlhbi9saWJ4ZW5vbWFpMS5tb2Rw
cm9iZQkxOTcwLTAxLTAxIDAxOjAwOjAwLjAwMDAwMDAwMCArMDEwMA0KKysrIHhlbm9tYWkt
Mi41LjEvZGViaWFuL2xpYnhlbm9tYWkxLm1vZHByb2JlCTIwMTAtMDItMjYgMDE6MDc6NDEu
MDAwMDAwMDAwICswMTAwDQpAQCAtMCwwICsxLDMgQEANCitpbnN0YWxsIHhlbm9fbnVjbGV1
cyAvc2Jpbi9tb2Rwcm9iZSAtLWlnbm9yZS1pbnN0YWxsIHhlbm9fbnVjbGV1cyAkQ01ETElO
RV9PUFRTIFwNCisgICQoL3Vzci9iaW4vdGVzdCAkKC9iaW4vZWNobyAtbiAnJENNRExJTkVf
T1BUUycgfCAvYmluL2dyZXAgeGVub21haV9naWQpIFwNCisgICAgfHwgL3Vzci9iaW4vZ2V0
ZW50IGdyb3VwIHhlbm9tYWkgfCAvdXNyL2Jpbi9jdXQgLWQ6IC1mMyB8IC9iaW4vc2VkIC1l
ICdzL14veGVub21haV9naWRcPS8nKQ0KZGlmZiAtdU5ycCB4ZW5vbWFpLTIuNS4xLm9yaWcv
ZGViaWFuL2xpYnhlbm9tYWkxLnBvc3RpbnN0IHhlbm9tYWktMi41LjEvZGViaWFuL2xpYnhl
bm9tYWkxLnBvc3RpbnN0DQotLS0geGVub21haS0yLjUuMS5vcmlnL2RlYmlhbi9saWJ4ZW5v
bWFpMS5wb3N0aW5zdAkyMDEwLTAyLTI2IDAxOjAxOjA3LjAwMDAwMDAwMCArMDEwMA0KKysr
IHhlbm9tYWktMi41LjEvZGViaWFuL2xpYnhlbm9tYWkxLnBvc3RpbnN0CTIwMTAtMDItMjYg
MDE6MDY6MDAuMDAwMDAwMDAwICswMTAwDQpAQCAtMSw2ICsxLDIyIEBADQogIyEvYmluL3No
IC1lDQogDQotcm0gLWYgL2V0Yy91ZGV2L3J1bGVzLmQveGVub21haS5ydWxlcw0KLWxuIC1z
ZiAuLi94ZW5vbWFpLnJ1bGVzIC9ldGMvdWRldi9ydWxlcy5kL3hlbm9tYWkucnVsZXMNCitj
YXNlICIkMSIgaW4NCisgICAgY29uZmlndXJlKQ0KKyAgICAgICAgIyBBZGQgdGhlIHhlbm9t
YWkgZ3JvdXAgdW5sZXNzIGl0J3MgYWxyZWFkeSB0aGVyZQ0KKyAgICAgICAgaWYgISBnZXRl
bnQgZ3JvdXAgeGVub21haSA+L2Rldi9udWxsOyB0aGVuDQorICAgICAgICAgICAgYWRkZ3Jv
dXAgLS1xdWlldCAtLXN5c3RlbSB4ZW5vbWFpIHx8IHRydWUNCisgICAgICAgIGZpDQorICAg
ICAgICBybSAtZiAvZXRjL3VkZXYvcnVsZXMuZC94ZW5vbWFpLnJ1bGVzDQorICAgICAgICBs
biAtc2YgLi4veGVub21haS5ydWxlcyAvZXRjL3VkZXYvcnVsZXMuZC94ZW5vbWFpLnJ1bGVz
DQorICAgIDs7DQorDQorICAgIGFib3J0LXVwZ3JhZGV8YWJvcnQtcmVtb3ZlfGFib3J0LWRl
Y29uZmlndXJlKQ0KKyAgICA7Ow0KKw0KKyAgICAqKQ0KKyAgICAgICAgZWNobyAicG9zdGlu
c3QgY2FsbGVkIHdpdGggdW5rbm93biBhcmd1bWVudCBcYCQxJyIgPiYyDQorICAgICAgICBl
eGl0IDENCisgICAgOzsNCitlc2FjDQogDQogI0RFQkhFTFBFUiMNCmRpZmYgLXVOcnAgeGVu
b21haS0yLjUuMS5vcmlnL2RlYmlhbi9saWJ4ZW5vbWFpMS54ZW5vbWFpLmluaXQgeGVub21h
aS0yLjUuMS9kZWJpYW4vbGlieGVub21haTEueGVub21haS5pbml0DQotLS0geGVub21haS0y
LjUuMS5vcmlnL2RlYmlhbi9saWJ4ZW5vbWFpMS54ZW5vbWFpLmluaXQJMTk3MC0wMS0wMSAw
MTowMDowMC4wMDAwMDAwMDAgKzAxMDANCisrKyB4ZW5vbWFpLTIuNS4xL2RlYmlhbi9saWJ4
ZW5vbWFpMS54ZW5vbWFpLmluaXQJMjAxMC0wMi0yNiAwMTo0ODoyOC4wMDAwMDAwMDAgKzAx
MDANCkBAIC0wLDAgKzEsMzYgQEANCisjIS9iaW4vc2ggLWUNCisjIyMgQkVHSU4gSU5JVCBJ
TkZPDQorIyBQcm92aWRlczogICAgICAgICAgeGVub21haQ0KKyMgUmVxdWlyZWQtU3RhcnQ6
ICAgIG1vdW50a2VybmZzDQorIyBSZXF1aXJlZC1TdG9wOg0KKyMgRGVmYXVsdC1TdGFydDog
ICAgIFMNCisjIERlZmF1bHQtU3RvcDoNCisjIFNob3J0LURlc2NyaXB0aW9uOiBTZXQgeGVu
b19udWNsZXVzIGdyb3VwDQorIyMjIEVORCBJTklUIElORk8NCisNCitHUk9VUD14ZW5vbWFp
DQorSU5JVE5BTUU9L2V0Yy9pbml0LmQveGVub21haQ0KK0ZJTEVOQU1FPS9zeXMvbW9kdWxl
L3hlbm9fbnVjbGV1cy9wYXJhbWV0ZXJzL3hlbm9tYWlfZ2lkDQorR0lEPSQoZ2V0ZW50IGdy
b3VwICRHUk9VUCB8IGN1dCAtZDogLWYzKQ0KKw0KK3Rlc3QgLWUgJEZJTEVOQU1FIHx8IGV4
aXQgMA0KK3Rlc3QgLW4gIiRHSUQiIHx8IGV4aXQgMA0KKw0KK2Nhc2UgIiQxIiBpbg0KKyAg
c3RhcnQpDQorICAgICAgICBlY2hvICIkR0lEIiA+ICRGSUxFTkFNRQ0KKyAgICAgICAgOzsN
CisgIHN0b3ApDQorICAgICAgICBlY2hvICItMSIgPiAkRklMRU5BTUUNCisgICAgICAgIDs7
DQorICByZXN0YXJ0fGZvcmNlLXJlbG9hZCkNCisgICAgICAgICQwIHN0YXJ0DQorICAgICAg
ICA7Ow0KKyAgKikNCisgICAgICAgIGVjaG8gIlVzYWdlOiAkSU5JVE5BTUUge3N0YXJ0fHN0
b3B8cmVzdGFydHxmb3JjZS1yZWxvYWR9Ig0KKyAgICAgICAgZXhpdCAxDQorICAgICAgICA7
Ow0KK2VzYWMNCisNCitleGl0IDANCisNCmRpZmYgLXVOcnAgeGVub21haS0yLjUuMS5vcmln
L2RlYmlhbi9ydWxlcyB4ZW5vbWFpLTIuNS4xL2RlYmlhbi9ydWxlcw0KLS0tIHhlbm9tYWkt
Mi41LjEub3JpZy9kZWJpYW4vcnVsZXMJMjAxMC0wMi0yNiAwMTowMTowNy4wMDAwMDAwMDAg
KzAxMDANCisrKyB4ZW5vbWFpLTIuNS4xL2RlYmlhbi9ydWxlcwkyMDEwLTAyLTI2IDAxOjE3
OjE5LjAwMDAwMDAwMCArMDEwMA0KQEAgLTEwMCw2ICsxMDAsNyBAQCBpbnN0YWxsOiBidWls
ZA0KIAlmb3IgZiBpbiAkKENVUkRJUikva3NyYy9udWNsZXVzL3VkZXYvKi5ydWxlcyA7IGRv
IFwNCiAJICAgIGNhdCAkJGYgPj4gJChDVVJESVIpL2RlYmlhbi9saWJ4ZW5vbWFpMS9ldGMv
dWRldi94ZW5vbWFpLnJ1bGVzIDsgXA0KIAlkb25lDQorCWluc3RhbGwgLW0gNjQ0IGRlYmlh
bi9saWJ4ZW5vbWFpMS5tb2Rwcm9iZSAkKENVUkRJUikvZGViaWFuL2xpYnhlbm9tYWkxL2V0
Yy9tb2Rwcm9iZS5kL3hlbm9tYWkNCiAJIyByZW1vdmUgZW1wdHkgZGlyZWN0b3J5DQogCXJt
IC1yZiAkKENVUkRJUikvZGViaWFuL3hlbm9tYWktZG9jL3Vzci9zaGFyZS9kb2MveGVub21h
aS1kb2MvcHMNCiAJY3AgZGViaWFuL2xpYnhlbm9tYWkxLmxpbnRpYW4gJChDVVJESVIpL2Rl
Ymlhbi9saWJ4ZW5vbWFpMS91c3Ivc2hhcmUvbGludGlhbi9vdmVycmlkZXMvbGlieGVub21h
aTENCkBAIC0xMzIsNiArMTMzLDcgQEAgYmluYXJ5LWluZGVwOiBidWlsZCBpbnN0YWxsDQog
YmluYXJ5LWFyY2g6IGJ1aWxkIGluc3RhbGwNCiAJZGhfdGVzdGRpciAtcw0KIAlkaF90ZXN0
cm9vdCAtcw0KKwlkaF9pbnN0YWxsaW5pdCAtcyAtLW5hbWU9eGVub21haQ0KIAlkaF9pbnN0
YWxsbWFuIC1zDQogCWRoX2luc3RhbGxkb2NzIC1zIC1BIENSRURJVFMgUkVBRE1FLklOU1RB
TEwgVFJPVUJMRVNIT09USU5HDQogCWRoX2xpbmsgLXMNCg==
--------------030509060107080400090407--

--------------enig050B67FC72DFD433907B61AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLh84+IPTw9rIdn6oRAktXAJ4zuFusdJRzbK1DNOSJmBE3reSBeACfS11s
N8zNcJ0RorA3WiJM5ZtKfi0=
=yyqZ
-----END PGP SIGNATURE-----

--------------enig050B67FC72DFD433907B61AC--

