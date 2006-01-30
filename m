Message-ID: <43DE0DA0.2050307@domain.hid>
Date: Mon, 30 Jan 2006 13:59:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] broken docs
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210CE1@domain.hid>	<43DE03CF.3070603@domain.hid>
	<17374.2360.273205.998312@domain.hid>
In-Reply-To: <17374.2360.273205.998312@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig85CC8424A1037F936E867381"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: ROSSIER Daniel <Daniel.Rossier@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig85CC8424A1037F936E867381
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > ROSSIER Daniel wrote:
>  > > Dear Xenomai workers,
>  > >=20
>  > > Would it be possible to have an updated API documentation for Xeno=
mai
>  > > 2.0.x ? (I mean with formal parameters in function prototypes)
>  > >=20
>  > > I tried to regenerate it with make generate-doc, but it seems that=
 a
>  > > SVN working dir is required.
>=20
> make generate-doc is needed for maintenance only. If you want to
> generate doxygen documentation, simply add --enable-dox-doc to Xenomai
> configure command line.
>=20
>  > >=20
>  > > It would be great.
>  >=20
>  > I just had a "quick" look at the status of the documentation in
>  > SVN-trunk (2.1). Unfortunately, doxygen is a terrible tool (to expre=
ss
>  > it politely) when it comes to tracking down bugs in your formatting.=

>  > Something is broken in all modules except RTDM, and although I spent=
 *a
>  > lot* of time in getting RTDM correctly formatted, I cannot tell what=
's
>  > wrong with the rest. This will require some looooong evenings of
>  > continuous patching the docs, recompiling, and checking the result. =
Any
>  > volunteers - I'm lacking the time? :-/
>=20
> Looking at the difference between RTDM documentation blocks and the
> other modules is that the other modules use the "fn" tag. Removing the
> "fn" tag from other modules documentation blocks seems to solve the
> issue.
>=20

Indeed, works. Amazingly blind I was.

Anyway, it still needs some work to remove that stuff (I wonder what the
"correct" usage of @fn is...) and to wrap functions without bodies via
"#ifdef DOXYGEN_CPP" like RTDM does. At this chance, I would also
suggest to replace all \tag by @tag for the sake of a unified style (and
who knows what side effects mixing up both may have).

Jan


--------------enig85CC8424A1037F936E867381
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD3g2gniDOoMHTA+kRAoUZAJwK30jLtoeJjic+3L8REP4XKLdlRgCePJzl
oNVof+pJBt1y0ucp+9rb8Go=
=CmCj
-----END PGP SIGNATURE-----

--------------enig85CC8424A1037F936E867381--

