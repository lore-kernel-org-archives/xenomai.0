Message-ID: <45D20F8E.9040900@domain.hid>
Date: Tue, 13 Feb 2007 20:20:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pthread_make_periodic_np and clock_gettime
References: <5D63919D95F87E4D9D34FF7748CE2C2A8018AD@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A8018AD@ARVMAIL1.mra.roland-man.biz>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6DE1BF66DAB2423798280C97"
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
To: Roderik_Wildenburg@domain.hid
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6DE1BF66DAB2423798280C97
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
> Can anybody tell me, how I have to set the 2. parameter (starttp) of
> pthread_make_periodic_np ?
> When I use clock_gettime to fill startp I get a giant timeout value in
> the /proc/xenomai/sched list and my task never gets periodic.
>=20
> Is this just a problem of my hardware(PPC)/xenomai(2.3) combination or
> does anybody else have the same problem.=20
>=20
> See attached code example for easier testing.
>=20

Confirmed over v2.3.x in periodic mode, aperiodic is fine. Gilles?

> Thanks a lot for your help
> Roderik
>=20
> MAN Roland Druckmaschinen AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Ral=
l, Paul Steidle
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933

Hah, I waited for the first footer of this kind appearing on mailing
lists! As far as I understood the new German law, this is not required
when you post to public forums. But probably your corporate mail server
injects this automatically.

Jan


--------------enig6DE1BF66DAB2423798280C97
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0g+OniDOoMHTA+kRAu2BAJ4q8it6tK9EBjiOo+0txoTEdNz8xgCfdDzk
BHSucNXLf2T3Y6Hl0JsuCuQ=
=4Cin
-----END PGP SIGNATURE-----

--------------enig6DE1BF66DAB2423798280C97--

