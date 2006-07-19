Message-ID: <44BEAD52.8040309@domain.hid>
Date: Thu, 20 Jul 2006 00:08:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] uvm/vxworks and uvm/vrtx are still being built
References: <44BD77E6.6030004@domain.hid> <1153340912.5032.30.camel@domain.hid>
In-Reply-To: <1153340912.5032.30.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0CDFDDAE4CEE867108EE2EC5"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0CDFDDAE4CEE867108EE2EC5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> ...
> To sum up, the UVM support is hard to explain to potential users, adds =
a
> fair amount of confusion when compared to using the direct syscall
> interfaces from user-space, and can't evolve up to the point where I
> could be happy with them.
>=20

Thanks for clarifying. I never looked that deep into the UVM (except
when I broke something with an arch patch). I just wrote that mail while
waiting on the user-space part for being built ;). The UVM lib is
default=3Dy, maybe something we should change soon as well.

> PS: regarding the RTAI issue, most projects migrating from there to Xen=
o
> are AFAIK, converting their applications to use the native skin
> directly, or even the POSIX one. Fact is that RTAI is more than 300
> calls, if you take into account all the interface variants. Given the
> nature of what is actually a set of APIs, more than a single one, the
> sandboxed environment the UVM brings does not fit the RTAI interfaces a=
t
> all. People really interested in having a 100% compatible RTAI skin ove=
r
> Xenomai that accurately emulates LXRT should definitely implement the
> direct syscall interface for it.
>=20

AFAIK no one insisted yet on user-space support for the RTAI skin. So
this seconds that porting actually takes place at the application level.
I guess it would take a rather large RTAI app so that writing a really
compatible skin becomes worth the effort.

Jan


--------------enig0CDFDDAE4CEE867108EE2EC5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEvq1SniDOoMHTA+kRAuuDAJ4+kTbW4C3uScAC2RkN+odYJ+QDKgCghNgJ
6xlXq9TMYC8hXEnTBB7ATJw=
=gJmx
-----END PGP SIGNATURE-----

--------------enig0CDFDDAE4CEE867108EE2EC5--

