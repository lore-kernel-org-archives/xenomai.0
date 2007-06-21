Message-ID: <467A42FE.1090305@domain.hid>
Date: Thu, 21 Jun 2007 11:21:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <467639BE.30504@domain.hid> <467641F3.3010308@domain.hid>	
	<1182357772.6137.39.camel@domain.hid> <46795F21.8040007@domain.hid>	
	<1182378551.6079.45.camel@domain.hid> <467A2FB2.6050006@domain.hid>
	<1182416810.9709.38.camel@domain.hid>
In-Reply-To: <1182416810.9709.38.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig39011D1F09A9205FA8F02318"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH-STACK] Synchronised timebases and more
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig39011D1F09A9205FA8F02318
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2007-06-21 at 09:58 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> If you think of it, decoupling only requires to keep a constant epoch=

>>> (at least one the nucleus does not update) somewhere within the timeb=
ase struct,
>>> the user code could wire to some value when it sees fit (e.g. pSOSish=
 tm_set(),
>> I know. It should be simple.
>>
>>> or VRTX's sc_stime() and so on). Obtaining a so-called constant-based=
 time would have
>>> then to be available through an additional method, returning constant=
_epoch + delta,
>>> whatever delta means wrt aperiodic/periodic behaviour. The point here=
 is that we
>>> would just shift the constant epoch - decorrelated from system time -=
 from default
>>> xntbase_get_time() behaviour to something which should be explicitly =
requested
>>> through a new specialized timebase method if needed.
>> Well, that's precisely the set of new conversion functions I'm a bit
>> afraid of. But as it now comes with the "special case", not the defaul=
t
>> one, I would be fine with it.
>>
>=20
> Indeed, it's really about shifting the default behaviour to synchronize=
d
> timebases. There is not much harm to expect from using specialized
> services to get a constant-based timebase anyway, since only skin
> developers would need that, and those people ought to know what they ar=
e
> doing.

Nope, it's a user thing: The user has to convert timestamps from one
skin (e.g. an RTDM device) into his own or vice versa. That makes it so
critical.

>=20
>>> IOW, introducing synchronized timebases is not the issue, making time=
base
>>> synchronization the default behaviour is what has some importance her=
e.
>> I predict it will save all of us from headache, at least from more
>> headache than with the other way around. :)
>>
>=20
> Ok, let's go for it, the changes are easily identifiable. I guess that
> is something we could not postpone to 2.5 anyway. I want to merge this
> asap now, because I don't want to delay -rc1 anymore, and the merge
> window is almost closed.
>=20
> Actual uses of this feature - e.g. POSIX resync - should go into -rc2,
> unless they are (almost) ready for merge right now.
>=20

Do you already have an idea about the "decoupling API"? Or should we
postpone this to -rc2 as well? Same for resync as a generic xntbase featu=
re.

Jan


--------------enig39011D1F09A9205FA8F02318
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGekL+niDOoMHTA+kRAr+qAJ4zQLQ6QfmvECuw/NqaA65NIdOxcACeIP9d
AxWjcmyOuom3l3DGoHGHMuY=
=iR0O
-----END PGP SIGNATURE-----

--------------enig39011D1F09A9205FA8F02318--

