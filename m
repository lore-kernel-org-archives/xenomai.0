Message-ID: <4C163AB5.3020903@domain.hid>
Date: Mon, 14 Jun 2010 16:20:37 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA5558DFAA82E9C42B2AC905B"
Subject: [Xenomai-core] [PATCH] debian: fix init script start/stop values
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
--------------enigA5558DFAA82E9C42B2AC905B
Content-Type: multipart/mixed;
 boundary="------------050905050300080902060609"

This is a multi-part message in MIME format.
--------------050905050300080902060609
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

the attached patch fixes the following installation warning on debian squ=
eeze and ubuntu lucid:
update-rc.d: warning: xenomai start runlevel arguments (2 3 4 5) do not m=
atch LSB Default-Start values (S)
update-rc.d: warning: xenomai stop runlevel arguments (0 1 6) do not matc=
h LSB Default-Stop values (none)

Stefan


--------------050905050300080902060609
Content-Type: text/plain;
 name="0001-debian-fix-init-script-start-stop-values.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-debian-fix-init-script-start-stop-values.patch"

RnJvbSAxYWMyMjM4ZTJmOGVkYjU5MTJjOWQwMmVjNTA4YTQ2NGFkZDE0ZDE2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmYW4gS2lzZGFyb2N6aSA8a2lzZGFAaGlzcGVl
ZC5jaD4KRGF0ZTogTW9uLCAxNCBKdW4gMjAxMCAxNjoxNDo1MCArMDIwMApTdWJqZWN0OiBb
UEFUQ0hdIGRlYmlhbjogZml4IGluaXQgc2NyaXB0IHN0YXJ0L3N0b3AgdmFsdWVzCgotLS0K
IGRlYmlhbi9saWJ4ZW5vbWFpMS54ZW5vbWFpLmluaXQgfCAgICA0ICsrLS0KIDEgZmlsZXMg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RlYmlhbi9saWJ4ZW5vbWFpMS54ZW5vbWFpLmluaXQgYi9kZWJpYW4vbGlieGVub21haTEu
eGVub21haS5pbml0CmluZGV4IGUyNDNiNWUuLjU2ODBhYjcgMTAwNjQ0Ci0tLSBhL2RlYmlh
bi9saWJ4ZW5vbWFpMS54ZW5vbWFpLmluaXQKKysrIGIvZGViaWFuL2xpYnhlbm9tYWkxLnhl
bm9tYWkuaW5pdApAQCAtMyw4ICszLDggQEAKICMgUHJvdmlkZXM6ICAgICAgICAgIHhlbm9t
YWkKICMgUmVxdWlyZWQtU3RhcnQ6ICAgIG1vdW50a2VybmZzCiAjIFJlcXVpcmVkLVN0b3A6
Ci0jIERlZmF1bHQtU3RhcnQ6ICAgICBTCi0jIERlZmF1bHQtU3RvcDoKKyMgRGVmYXVsdC1T
dGFydDogICAgIDIgMyA0IDUKKyMgRGVmYXVsdC1TdG9wOiAgICAgIDAgMSA2CiAjIFNob3J0
LURlc2NyaXB0aW9uOiBTZXQgeGVub19udWNsZXVzIGdyb3VwCiAjIyMgRU5EIElOSVQgSU5G
TwogCi0tIAoxLjUuNi41Cgo=
--------------050905050300080902060609--

--------------enigA5558DFAA82E9C42B2AC905B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFMFjq6IPTw9rIdn6oRAuhSAJ4w+j3OxA9ofxWba+7j6TGkdHCfnACfemPo
8lJl/y2+JIMneQXGwdKy4Ao=
=yOOK
-----END PGP SIGNATURE-----

--------------enigA5558DFAA82E9C42B2AC905B--

