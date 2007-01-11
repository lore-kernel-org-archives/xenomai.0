Message-ID: <45A658C0.1070908@domain.hid>
Date: Thu, 11 Jan 2007 16:33:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Unwanted mode switch.
References: <45A656C6.6060406@domain.hid>
In-Reply-To: <45A656C6.6060406@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6F1B229E6392FE828DD7294F"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6F1B229E6392FE828DD7294F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi,
>=20
> in order to test the nocow patch, I wrote the attached test. Despite th=
e
> fact that there is no longer any page fault (I have nucleus debugging
> on, so I would get a message if there was a fault), there is still an
> unwanted mode switch at step 5. Any idea what could be the cause ?
>=20

Put in some xntrace_user_freeze(0) before or after the point-of-interest
in the program, switch on the tracer, and check ipipe/trace/frozen (with
appropriate back_trace_points or post_trace_points) what is going on.
Once you know the particular code path, instrumenting it can also be
done this way: xntrace_special(some_id, some_value_of_interest).

Jan


--------------enig6F1B229E6392FE828DD7294F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFpljEniDOoMHTA+kRAisdAJ9+gG6dfz/IqiaKzwjFJix97ZUQKwCeKCFD
zF+AIXqGSMWw1t0lPOltdYY=
=Oypm
-----END PGP SIGNATURE-----

--------------enig6F1B229E6392FE828DD7294F--

