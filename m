Message-ID: <44C50309.70303@domain.hid>
Date: Mon, 24 Jul 2006 19:27:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Newbie and Coldfire
References: <44C4E547.10304@domain.hid>
In-Reply-To: <44C4E547.10304@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig60D8D8D266CE1ADD13A734DD"
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
To: Miguel Angel Alvarez <ma.alvarez@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig60D8D8D266CE1ADD13A734DD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Miguel Angel Alvarez wrote:
> Hi.
>=20
> I do not know if this in the correct mailing list to do this question.
> If not, please redirect me to the correct one.
>=20
> I am beginning a new proyect using a Coldifre micro (Have previous
> experience with i386 and PPC). It is also my first proyect with real
> time linux, so I have began to read articles about preemption patches,
> RTAI...
>=20
> It seems that Xenomai is the best effort to obtain hard real-time
> characteristics to my system, but... it is not ported to support
> Coldfire. Could anyone give me an advise on the difficulty of porting
> the systen to this architecture? Should I consider it just impossible?
>=20

Disclaimer: No expert on Coldfire speaking here. But given that Xenomai
already runs fine over Blackfin (also a MMU-less arch) and that it has a
clean architecture abstraction: should definitely be feasible.

The first step always involves an Adeos I-pipe patch. Check available
patches for other archs to assess the required effort for you. Feel free
to drop questions on their design or your Coldfire ideas on
xenomai-core/help or on adeos-main (similar people will listen).

Jan


--------------enig60D8D8D266CE1ADD13A734DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFExQMJniDOoMHTA+kRAi6zAJsGrzeaEfo1AYY2Eq03CnGA3gVBjwCePgBD
G65DEATvhh4Tp0zfezcK8sc=
=QU88
-----END PGP SIGNATURE-----

--------------enig60D8D8D266CE1ADD13A734DD--

