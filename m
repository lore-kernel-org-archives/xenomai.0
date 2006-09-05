Message-ID: <44FD5CF1.7000603@domain.hid>
Date: Tue, 05 Sep 2006 13:18:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM PCI development framework
References: <1157443250.4466.12.camel@domain.hid>
In-Reply-To: <1157443250.4466.12.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD41E75BF20B1960E5DBA7AA6"
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
To: ramv <vikesh.rambaran@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD41E75BF20B1960E5DBA7AA6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

ramv wrote:
> hi
> how are you?
>=20
> This is my first attempt at writing a linux device driver. After readin=
g
> through some of the "Linux Device Drivers 3rd edition", and through
> Xenomai RTDM, i thought a good place to start was a generic framework
> which detects and allocates PCI resources with the necessary error
> handling. It makes available callback functions as well as the allocate=
d
> resources. The aim is to expand it to provide a framework for a standar=
d
> linux char device driver. Thereafter update the framework to be RTDM
> compatible. I've spoken with Jan Kiska with regards to this and it may
> useful to others. There is still much work to be done on, especially to=

> bring it up to the Xenomai/RTDM coding standard but attached please fin=
d
> a first attempt.
>=20
> Comments and constructive criticism would be greatly appreciated!
> [The Xenomai GPL file headers are included, hope you don't mind]

The idea to provide some template for (PCI) driver development is
definitely a good one. Your approach already look quite nice, but it is
generally wise to apply such templates at least on two different drivers
to see what may be missing, what needs refinement, or what is not require=
d.

A few comments already: it would be nice to add kernel 2.4 support to
your Makefile. Keep an eye on potential "over-design", i.e. avoid
wrapping trivial things, rather concentrate on providing templates the
user can fill in stuff directly.

>
> Jan, i went away for a long weekend at the sea to visit my parents.
> Apologies for not replying earlier

There is life offline? ;)
(No need to apologise, we are all busy with various stuff.)

>=20
> ***********************************************************************=
********************************
> Disclaimer:  The information contained in this communication is confide=
ntial and may be legally privileged. =20

Mmm, was it illegal then to read your mail? Or the attachment?? ;)

Jan


--------------enigD41E75BF20B1960E5DBA7AA6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/VzxniDOoMHTA+kRAlnEAJ9PwGR7dtfW7ZbpeTiFypSp6Kkq1ACeO2Mb
WBXPFybj31u1HFiOhaX7mvw=
=4UWu
-----END PGP SIGNATURE-----

--------------enigD41E75BF20B1960E5DBA7AA6--

