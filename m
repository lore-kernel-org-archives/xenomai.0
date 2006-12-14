Message-ID: <45814E2A.9020106@domain.hid>
Date: Thu, 14 Dec 2006 14:14:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Working example for direct memory mapped IO
References: <200612132248.36493.niklaus.giger@domain.hid>
In-Reply-To: <200612132248.36493.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBDCD39CD7872FF97025AF8DF"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBDCD39CD7872FF97025AF8DF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Hi
>=20
> To document basic Xenomai/Linux patterns I developed the attached small=
=20
> example for our PPC405 board, which just rolls the 8 debug LEDs.
>=20
> Are there any comments about it?=20

I like the idea of having useful generic code patterns like this in the
examples repos. But I also have a few wishes regarding this particular on=
e:

 * I would prefer that generic patterns are coded against POSIX or maybe
   Native, not against a special RTOS skin (not everyone know the
   VxWorks API by heart ;) ).

 * Try to make use of as less additional patterns beyond the core aspect
   as possible. E.g., running the lights in main would avoid quite some
   code for init/cleanup. This helps the reader to grab the essence of
   the demo. Still, the demo should remain functional!

 * Please format your code according to kernel style (could be any
   style, but we need a standard, so pick that one)

>=20
> Shall I put it into the Wiki at http://www.xenomai.org/index.php/Exampl=
es or=20
> does somebody want to commit it to the examples part of the subversion =
trunk?

I would happily merge a cleaned up version into the repos, e.g. under
the related skin.

Thanks,
Jan


PS: If you want to contribute VxWorks-specific code pattern, you are
welcome as well!


--------------enigBDCD39CD7872FF97025AF8DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgU4qniDOoMHTA+kRAuWPAJ9N9DRPXAyQI+AzWtN42We7PJ9IugCcCUlz
fOGvaU0vEVZKMsUw+rmwzsc=
=9dLs
-----END PGP SIGNATURE-----

--------------enigBDCD39CD7872FF97025AF8DF--

