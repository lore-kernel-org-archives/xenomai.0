Message-ID: <46D530AB.5080306@domain.hid>
Date: Wed, 29 Aug 2007 10:39:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46D52231.9040309@domain.hid>
In-Reply-To: <46D52231.9040309@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig682FB5FE430732B6CD925547"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Newbies developer instructions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Ravid Baruch Naali <ravidbn@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig682FB5FE430732B6CD925547
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ravid Baruch Naali wrote:
> Hello Xenomai-core mailing list,
>=20
>=20
> I'm eager to contribute to the Xenomai project, but since I could not
> find any opened bugs or a detailed task list apart from:
>=20
> http://www.xenomai.org/index.php/TaskMarket
>=20
> I was wondering if there is way for newbies like me to get involved?
>=20
> If any of you can send me a pointer to where should i begin, I will be
> more then greatful.

=DCber-cool - someone looking for work! :)

There are a thousand things to do. The most productive things are likely
those you stumble over when using Xenomai in your project. What is not
working? What could be solved better or should be added? Also: What
features should be checked against regressions while the development
advances (more automatic test cases - very important!)?

Besides this, here are some more potential points to start with:

 o https://mail.gna.org/public/xenomai-core/2007-08/msg00017.html :)

 o Write more examples/tutorials for your favourite skin (see examples
   repos in SVN).

 o Check the code against its (doxygen) documentation - everything still
   up-to-date? Something yet undocumented?

 o Work with Paul Corner (paul_c@domain.hid) on some regularly updated
   Xenomai LiveCD (I guess he would be happy about help).

 o Enhance the testsuite / test script to collect more data, and
   specifically to evaluate the data more systematically (up to
   re-creating something like http://issaris.org/rtai/summary.php). To
   start with: I once had the idea to create some statistics collection
   library for the testsuite so that all tests could use the same
   infrastructure to process/visualise benchmark results.

 o ... (things I forgot)

Jan


--------------enig682FB5FE430732B6CD925547
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG1TCrniDOoMHTA+kRAsEIAJ925f6BzB6x3TyLTUnwAFM4f/VmwgCeOqw9
mS7yY39PMgiJNZpR/YDKRlI=
=1l2J
-----END PGP SIGNATURE-----

--------------enig682FB5FE430732B6CD925547--

