Message-ID: <44FEED82.80803@domain.hid>
Date: Wed, 06 Sep 2006 17:47:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai + PREEMPT_RT
References: <1157501591.22250.25.camel@domain.hid>	
	<44FEA7F5.6090409@domain.hid>
	<1157554292.3541.28.camel@domain.hid>
In-Reply-To: <1157554292.3541.28.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5DC3A52FB2B828C0EB83A4F1"
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
To: Daniel Walker <dwalker@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5DC3A52FB2B828C0EB83A4F1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Walker wrote:
> On Wed, 2006-09-06 at 12:50 +0200, Jan Kiszka wrote:
>>> Or even better, is anyone already doing work with these two
>>> technologies combined?
>> There once existed a combo patch (that I don't find ATM) of an ancient=

>> -rt version + old Adeos, a combination that will more or less
>> automatically come again when PREEMPT_RT is mainline. Porting the
>> nucleus over PREEMPT_RT so that the skins can run "natively" is anothe=
r
>> task yet to begin. Anyway, we are already including this perspective i=
n
>> current design decisions when subsystems are revised or enhanced.
>=20
> So I take it that designing the combined version is still taking place?=


You can do so. It's a mid- to long-term goal while we also have to take
care of immediate user requirements.

>=20
> It sounds like the current direction is more of a straight merge.=20
> Since PREEMPT_RT and Xenomai are somewhat parallel in purpose would
> there be any room to eliminate duplication between the two?

There are certainly duplications, both wrt/ technology and application
scenarios, though none of both projects is a subset of the other. For
sure it would be nice if we can find common grounds, make components
interchangeable or merge features into mainline. If you already have any
rough ideas, please let us know.

Jan


--------------enig5DC3A52FB2B828C0EB83A4F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/u2CniDOoMHTA+kRArJIAJ4gqvcVS7MdDdX9pKLXFhOqs9P+pACfW6g1
44v+ivorRssEegEjAMpBMTk=
=vM15
-----END PGP SIGNATURE-----

--------------enig5DC3A52FB2B828C0EB83A4F1--

