Message-ID: <494D5A00.6070809@domain.hid>
Date: Sat, 20 Dec 2008 21:48:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081219084446.8148.89319.stgit@domain.hid>
	<494D1ED5.2090300@domain.hid>
In-Reply-To: <494D1ED5.2090300@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig12A9CC302639FD2BB4FC44AC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH  0/3] NMI watchdog fixes / enhancements
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig12A9CC302639FD2BB4FC44AC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> This is basically a repost of the NNI watchdog series I sent out a few=

>> weeks ago. I just rebased things over latest trunk and fixed some
>> warnings.
>>
>> All patches are also available at
>> git://git.kiszka.org/xenomai.git nmi-wd-queue
>=20
> That is a lot of stuff to review. I am afraid it is impossible to revie=
w
> everything, so the only thing we can rely on is testing, hence the next=

> question: have these patches been tested in every configuration
> (enabled, disabled, built-in, module, voluntary overrun)?

In most configurations, but definitely not in all (they are too many).

This is a debugging tool, so first of all the disabled case must not
cause harm, and I'm quite sure I haven't changed anything regarding
this. Moreover, the enabled case was not working for many recent
platforms anymore as we were lacking P6 support. So there shouldn't be
much to loose.

>=20
> As for the 32nd bit issue, I am afraid it can not explain the spurious
> shots observed on some platfomrs (note that I implemented the early sho=
t
> thing a bit in the dark: I never observed the spurious shots myself),
> that is because the nmi timer is programmed for durations between 100us=

> and 10ms, which should be far from using the 32nd bit.

Yes, the signedness issue that is fixed in patch 1 has likely nothing to
do with the spurious invocations. But wherever they may still come from,
patch 3 ensures that they are now properly ignored (ie. forwarded to the
next handling instance).

Jan


--------------enig12A9CC302639FD2BB4FC44AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAklNWgsACgkQniDOoMHTA+nMGACeNKq7hoR9xduR8+BRGjnqJEyG
ikEAn30QEPGhaHxEwZdTtC1XlIBHlxhH
=7yrH
-----END PGP SIGNATURE-----

--------------enig12A9CC302639FD2BB4FC44AC--

