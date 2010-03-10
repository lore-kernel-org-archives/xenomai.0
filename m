Message-ID: <4B97EB5C.2090600@domain.hid>
Date: Wed, 10 Mar 2010 19:56:28 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA612F451E221BB5DD73AD331"
Subject: [Xenomai-core] proc_file_read: Apparent buffer overflow
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
--------------enigA612F451E221BB5DD73AD331
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

cat /proc/xenomai/heap returns the first 4096 Bytes and fails then with "=
Bad address".
On the console I see: "proc_file_read: Apparent buffer overflow!"

xeno 2.5.1, linux 2.6.32.8, x86 32bit UP, native skin, lot of rt_queues:
# ls -1 /proc/xenomai/registry/native/queues/ | wc -l
233
# ls -1 /proc/xenomai/registry/native/heaps/ | wc -l
26

regards
Stefan



--------------enigA612F451E221BB5DD73AD331
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLl+thIPTw9rIdn6oRAiG5AJ9q7SIPiVNnhWMcC7P/9SpV9gOhlwCeLqpG
jhvGjvkZOVkQTKor5KHXyD0=
=R51d
-----END PGP SIGNATURE-----

--------------enigA612F451E221BB5DD73AD331--

