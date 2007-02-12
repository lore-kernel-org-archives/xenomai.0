Message-ID: <45D0666C.8070409@domain.hid>
Date: Mon, 12 Feb 2007 14:06:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Make error
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>	
	<45D029B8.1030805@domain.hid>
	<e45fe62b0702120448i7b23bd24o4fa88a05237a69a@domain.hid>
In-Reply-To: <e45fe62b0702120448i7b23bd24o4fa88a05237a69a@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4247C6D09260A7ED3C9F761B"
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
To: Preetam Joshi <j.preetam@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4247C6D09260A7ED3C9F761B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Preetam Joshi wrote:
> hi,

Please keep the CC when replying (reply-to-all).

>=20
> Itried adding the options as shown in the example latency in the SVN
> repository but the latency example as well as my example both gve the s=
ame
> error stating
>=20
> make: *** No rule to make target `../../skins/native/libnative.la', nee=
ded
> by `latency'.  Stop.
> make: *** No rule to make target `../../skins/native/libnative.la', nee=
ded
> by `mytask'.  Stop.
>=20

You are doing something wrong. Does the user space part build AND
install cleanly? If yes, check out the examples repository next:

svn co svn://svn.gna.org/svn/xenomai/branches/v2.3.x/examples

Then try to build the native examples:

# cd examples/native
# make XENO=3D<path-to-xenomai-installation>

This should work out-of-the-box. You can then add your own example here,
only extending APPLICATIONS in examples/native/Makefile.

Jan


--------------enig4247C6D09260A7ED3C9F761B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0GZsniDOoMHTA+kRAhuvAJ49miMcL7ahx1zF5KsoR4diUVg5eQCcC/Bp
/z3q+2rHkq5fRccV8+FC8MA=
=N2W4
-----END PGP SIGNATURE-----

--------------enig4247C6D09260A7ED3C9F761B--

