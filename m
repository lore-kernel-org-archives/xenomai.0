Message-ID: <45101503.5020600@domain.hid>
Date: Tue, 19 Sep 2006 18:04:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] How to do tracing with Xenomai on a 2.4 kernel?
References: <450FEF8D.7070002@domain.hid>
In-Reply-To: <450FEF8D.7070002@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig96E272990DA5F105518784E3"
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
To: Yoann Allain <yoann.allain@domain.hid>
Cc: jean-olivier.villemure@domain.hid, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96E272990DA5F105518784E3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Yoann Allain wrote:
> Hello,
>=20
> I'm new to Xenomai (I used RTAI 2~3 years ago) and as I was using LTT t=
o
> trace RTAI tasks on 2.4 kernel, I wanted to use it with Xenomai too.
> But the fact is it seems to me that there is no LTT support in Xenomai
> for 2.4 kernels... Is that right?
>=20
> To do some tracing, either I work with 2.4 kernel+RTAI+LTT or with 2.6
> kernel+Xenomai+LTTng. Is that right ? Or is there another solution to d=
o
> some tracing on 2.4 kernel with Xenomai?
>=20

Tracing based on LTTng is currently in a stalled state. We have
instrumentation in place if you look at the Xenomai code, but the status
of LTTng is still in flux.

If you happened to have read LKML recently, a lot of dogfights took
place if and how tracing should be included in Linux. LTTng or a
superset with other tracers now seems to be on a fairly good way to get
integrated - but surely not as-is.

So I would forward the question to those (CC'ed) who already worked on
the integration or have announced to do so soon. How do you see the
situation and what might be the time-frame for Xenomai support now?

Regarding 2.4: back-porting LTTng support is yet another issue which -
as I see it - can only be considered once 2.6 support is done. LTTng's
dependencies on 2.6 infrastructure will likely require "some" effort, so
the question is if there will be someone to work on this (or sponsor it).=


Jan


--------------enig96E272990DA5F105518784E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFEBUEniDOoMHTA+kRAmS1AJ47Qa4LK+IuB9RCZtsN1TU1hT2qBwCfbpzW
SruTOCiDB5I4BzkPfJF9rFw=
=XaVN
-----END PGP SIGNATURE-----

--------------enig96E272990DA5F105518784E3--

