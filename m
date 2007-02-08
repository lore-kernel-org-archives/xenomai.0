Message-ID: <45CAE2C5.1070108@domain.hid>
Date: Thu, 08 Feb 2007 09:43:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45CA5AFD.9020805@domain.hid> <45CAE367.5040803@domain.hid>
In-Reply-To: <45CAE367.5040803@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF142C029B668335CB9C525AD"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: Linux lock-up with rtcanrecv
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF142C029B668335CB9C525AD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hi Jan,
>=20
> Jan Kiszka wrote:
>> Hi all,
>>
>> fiddling with latest Xenomai trunk and 2.3.x on one of our robots (the=
re
>> is still a bug in trunk /wrt broken timeouts of rt_dev_read on
>> xeno_16550A - different issue...), I ran into a weird behaviour of
>> rtcanrecv:
>>
>> I have a continuous stream of a few thousand packets/s towards the
>> robot. When I start up two "rtcanrecv rtcan0 -p1000" instances (or one=
 +
>> our own receiver application), the second one causes a Linux lock-up.
>> Sometimes this happens during startup of the second rtcanrecv, but at
>> latest on its termination. Other RT tasks are still running. I can
>> resolve the lock-up by pulling the CAN cable, everyone is fine
>> afterwards and can be cleaned up. I played with quite a few combinatio=
ns
>> of recent ipipe patches and Xenomai revisions (even back to #1084 in
>> v2.3.x), no noticeable difference.
>>
>> Seems like I have to take a closer look - once time permits and the
>> robot is available. So any ideas or attempts to reproduce this are
>> welcome, current .config attached (no magic knob found there yet).
>=20
> I will try to reporduce the problem a.s.a.p.

TiA.

>=20
>> Jan
>>
>>
>> PS: Wolfgang, any objections against "decoupling" -v from -p and
>> lowering the receiver priority to 0?
>=20
> No, -v with -p looks like a bug anyway. And does it make sense to defin=
e
> an option for the task priority?

I don't think so because a) the timestamps are recorded at IRQ level
anyway and we b) printf the result in secondary mode. My reason for
lowering the prio was to avoid the the receiver runs under Linux with
SCHED_FIFO.

Jan


--------------enigF142C029B668335CB9C525AD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFyuLFniDOoMHTA+kRAoSCAJsFf4R+IoIf+Wdq5/3gssSlIDjTggCdFU23
wXGul5F8Q2OgWZETCXrvwq8=
=5idr
-----END PGP SIGNATURE-----

--------------enigF142C029B668335CB9C525AD--

