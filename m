Message-ID: <487B8B3E.8020805@domain.hid>
Date: Mon, 14 Jul 2008 19:22:06 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAEAC969CEFB74C362A24E7FB"
Subject: [Xenomai-help] rt_task_bind() and timeout values
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAEAC969CEFB74C362A24E7FB
Content-Type: multipart/mixed;
 boundary="------------090502020203040606020107"

This is a multi-part message in MIME format.
--------------090502020203040606020107
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi all,

If I call rt_task_bind() with a timeout value other than TM_NONBLOCK or T=
M_INFINITE
it works not as expected (by me).

System: Debian Lenny with Xenomai 2.4.3 and Kernel 2.6.24.

The attached example calls 3 times rt_task_bind() for a nonexistent task:=


1. dont wait: rt_task_bind(&task,"SomeTaskName",TM_NONBLOCK)
   -> returns -11 (EWOULDBLOCK) -> OK

2. wait 5 secs: rt_task_bind(&task,"SomeTaskName",5000000000LL);
   -> returns immediately -13 (EACCES) without waiting -> ?
   -> I expected ETIMEDOUT after 5 seconds

3. wait forever: rt_task_bind(&task,"SomeTaskName",TM_INFINITE);
   -> blocks a expected -> OK

I have the same problem with rt_queue_bind() calls.

Do i expect something wrong?

Thanks for your help!

kisda


--------------090502020203040606020107
Content-Type: text/plain;
 name="bind_task.c"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="bind_task.c"

I2luY2x1ZGUgPHN5cy9tbWFuLmg+DQojaW5jbHVkZSA8bmF0aXZlL3Rhc2suaD4NCg0KUlRf
VEFTSyBtdGFzayx0YXNrOw0KDQppbnQgbWFpbiAoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkN
Cg0Kew0KICAgIGludCBlcnI7DQoNCiAgICBtbG9ja2FsbChNQ0xfQ1VSUkVOVHxNQ0xfRlVU
VVJFKTsNCg0KICAgIGVyciA9IHJ0X3Rhc2tfc2hhZG93KCZtdGFzaywgTlVMTCwgMTAsIDAp
Ow0KDQogICAgaWYgKGVycikNCiAgICAgICAgZnByaW50ZihzdGRlcnIsInJ0X3Rhc2tfc2hh
ZG93IGZhaWxlZCwgY29kZSAlZFxuIixlcnIpOw0KDQogICAgLy8gMS4gZG9udCB3YWl0DQog
ICAgZXJyID0gcnRfdGFza19iaW5kKCZ0YXNrLCJTb21lVGFza05hbWUiLFRNX05PTkJMT0NL
KTsNCg0KICAgIGlmIChlcnIpDQogICAgICAgIGZwcmludGYoc3RkZXJyLCJiaW5kICgxKSBm
YWlsZWQsIGNvZGUgJWRcbiIsZXJyKTsNCg0KICAgIC8vIDIuIHdhaXQgNSBzZWNzDQogICAg
ZXJyID0gcnRfdGFza19iaW5kKCZ0YXNrLCJTb21lVGFza05hbWUiLDUwMDAwMDAwMDBMTCk7
DQoNCiAgICBpZiAoZXJyKQ0KICAgICAgICBmcHJpbnRmKHN0ZGVyciwiYmluZCAoMikgZmFp
bGVkLCBjb2RlICVkXG4iLGVycik7DQoNCiAgICAvLyAzLiB3YWl0IGZvcmV2ZXINCiAgICBl
cnIgPSBydF90YXNrX2JpbmQoJnRhc2ssIlNvbWVUYXNrTmFtZSIsVE1fSU5GSU5JVEUpOw0K
DQogICAgaWYgKGVycikNCiAgICAgICAgZnByaW50ZihzdGRlcnIsImJpbmQgKDMpIGZhaWxl
ZCwgY29kZSAlZFxuIixlcnIpOw0KfQ0K
--------------090502020203040606020107--

--------------enigAEAC969CEFB74C362A24E7FB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIe4tEIPTw9rIdn6oRAjvOAJ0Y1P7zSdpfR63gz+nYH4RY9L3agACfWE/E
GyFVUSrqWmbpv2df4XhLYOE=
=tzqJ
-----END PGP SIGNATURE-----

--------------enigAEAC969CEFB74C362A24E7FB--

