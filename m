Message-ID: <43F219C9.2030903@domain.hid>
Date: Tue, 14 Feb 2006 18:56:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] separate queue debugging switch
References: <43F1C095.8030805@domain.hid> <43F2161D.9000906@domain.hid>
In-Reply-To: <43F2161D.9000906@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3E924AB6A76ACD4BCC8A022F"
Sender: jan.kiszka@domain.hid
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
--------------enig3E924AB6A76ACD4BCC8A022F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> while XENO_OPT_DEBUG is generally a useful switch for tracing potentia=
l
>> issues in the core and the skins, it also introduces high latencies vi=
a
>> the queue debugging feature (due to checks iterating over whole queues=
).
>>
>> This patch introduces separate control over queue debugging so that yo=
u
>> can have debug checks without too dramatic slowdowns.
>>
>=20
> Maybe it's time to introduce debug levels, so that we could reuse them
> in order to
> add more (selectable) debug instrumentation; queue debugging could then=

> be given a
> certain level (likely something like CONFIG_XENO_DEBUG_LEVEL=3D8712 for=

> this one...), instead of going for a specific conditional each time we
> introduce new checks?
>=20

Hmm, this means someone have to define what should be printed at which
level - tend to be hard decisions... Often it is at least as much useful
to have debug groups so that specific parts can be excluded from
debugging. I'm pro such groups (one would be those queues e.g.) but
contra too many levels (2, at most 3).

At this chance, I would also suggest to introduce some ASSERT macro (per
group, per level). That could be used to instrument the core with
runtime checks. But it could also be quickly removed at compilation
time, reducing the code size (e.g. checks at the nucleus layer against
buggy skins or at RTDM layer against rough drivers).

Jan


--------------enig3E924AB6A76ACD4BCC8A022F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8hnJniDOoMHTA+kRArK6AJ4hTwy97z/3bpBP7/9HDFMdlkBvhwCeOqu5
qVxqvH18bDo+2abMzekhDkY=
=9Zj6
-----END PGP SIGNATURE-----

--------------enig3E924AB6A76ACD4BCC8A022F--

