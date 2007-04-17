Message-ID: <4625115C.6070007@domain.hid>
Date: Tue, 17 Apr 2007 20:26:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <5C40CD1E4697424ABDE3AC57CF1B22C603221037@domain.hid>
	<4624D71E.3040008@domain.hid>
In-Reply-To: <4624D71E.3040008@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1418AF733F7E0804F4687487"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Perfs and rt alarms questions.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, "RAKOTOSALAMA,
	Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1418AF733F7E0804F4687487
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> RAKOTOSALAMA, Nirilanto wrote:
>> Hello everybody.
>>
>> I managed to compile a stable kernel (the Scalability O(1) scheduler o=
ptions seems to make my system freeze)
>=20
> That's not good. What precisely did you do? Applied the .config you
> posted, just enabling CONFIG_XENO_OPT_SCALABLE_SCHED? And what test
> case, latency?

Hmm, maybe related: Philippe, I once posted you an oops under
qemu-system-x86_64 which we explained with a probably broken toolchain.

I just pulled out that config again, updated everything
(crosstools-0.43: gcc-4.1.1-glibc-2.3.6-tls + tiny patch [1], Xenomai
trunk, adeos-ipipe-2.6.19-x86_64-1.0-06) - and still got that crash on
"latency" startup. The oops still happens around [2]. Interesting is
that turning off CONFIG_XENO_OPT_SCALABLE_SCHED makes it go away.

Given that I now tested my setup with gcc4 (instead of the earlier gcc3
run), there may be some code that "confuses" compilers (or it's simply
broken). I failed to reproduce the issue on x86, and cross debugging
somehow still don't work for me, so I can't tell more.

Jan

[1]https://www.x86-64.org/pipermail/discuss/2006-November/009546.html
[2]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/shadow.=
c?v=3DSVN-trunk#225



--------------enig1418AF733F7E0804F4687487
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGJRFcniDOoMHTA+kRAgBHAJ9YBP7MF8fQd3v4PviAS+nniUheOwCfWBUX
2/asRzmuM838/8EArspqqYo=
=zAoF
-----END PGP SIGNATURE-----

--------------enig1418AF733F7E0804F4687487--

