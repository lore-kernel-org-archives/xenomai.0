Message-ID: <438DE166.5090303@domain.hid>
Date: Wed, 30 Nov 2005 18:29:10 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] don't try this at home...
References: <438DD4E2.9080208@domain.hid>
In-Reply-To: <438DD4E2.9080208@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF3EC91A35F84733D0D4516EB"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF3EC91A35F84733D0D4516EB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi Philippe,
>=20
> I'm afraid this one is serious: let the attached migration stress test
> run on likely any Xenomai since 2.0, preferably with
> CONFIG_XENO_OPT_DEBUG on. Will give a nice crash sooner or later (I'm
> trying to set up a serial console now).
>=20

As it took some time to persuade my box to not just reboot but to give a
message, I'm posting here the kernel dump of the P-III running
nat_migration:

[...]
Xenomai: starting native API services.
ce649fb4 ce648000 00000b17 00000202 c0139246 cdf2819c cdf28070 0b12d310
       00000037 ce648000 00000000 c02f0700 00009a28 00000000 b7e94a70
bfed63c8
       00000000 ce648000 c0102fcb b7e94a70 bfed63dc b7faf4b0 bfed63c8
00000000
Call Trace:
 [<c0139246>] __ipipe_dispatch_event+0x96/0x130
 [<c0102fcb>] work_resched+0x6/0x1c
Xenomai: fatal: blocked thread migration[22175] rescheduled?!
(status=3D0x300010, sig=3D0, prev=3Dwatchdog/0[3])
 CPU  PID    PRI  TIMEOUT  STAT      NAME
>  0  0      0    0        00500080  ROOT
   0  22175  1    0        00300110  migration
Timer: none

cea05ee4 d0842c62 cdcb0000 cea6d030 c02f0700 c035cbec c02f0700 00000286
       c0139246 00000022 c02f0700 cdf28070 cdf28070 00000022 00000001
c02f0700
       cea6d030 cdf28070 cea6d158 cea05f78 c02b26c0 cea04000 00000238
d1244537
Call Trace:
 [<c0139246>] __ipipe_dispatch_event+0x96/0x130
 [<c02b26c0>] schedule+0x2d0/0x720
 [<c0137b20>] watchdog+0x0/0x80
 [<c02b3967>] schedule_timeout+0x47/0xb0
 [<c0120070>] process_timeout+0x0/0x10
 [<c0120492>] msleep_interruptible+0x42/0x60
 [<c0137b70>] watchdog+0x50/0x80
 [<c012d0ab>] kthread+0x8b/0x90
 [<c012d020>] kthread+0x0/0x90
 [<c0100ef5>] kernel_thread_helper+0x5/0x10


Jan


--------------enigF3EC91A35F84733D0D4516EB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDjeFmncNeS9Q0k+IRAkKjAKDlIAF9EzEqZ4sBpwZBArSD897GMQCg1TP5
7x3NSEYLUP1NXt1aEnMqIhQ=
=J1lw
-----END PGP SIGNATURE-----

--------------enigF3EC91A35F84733D0D4516EB--

