Message-ID: <44ACF6D8.6060609@domain.hid>
Date: Thu, 06 Jul 2006 13:41:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
References: <44ACF5FA.2050205@domain.hid>
In-Reply-To: <44ACF5FA.2050205@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3D8C04E032772AFE6A5A2467"
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
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3D8C04E032772AFE6A5A2467
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>=20
> I think to remember people crying for some execution time statistics fo=
r quite a
> while now. Here comes a straightforward approach to add this on a per-t=
hread basis.
> The results are printed like this:
>=20
> root@domain.hid :/root# cat /proc/xenomai/stat=20
> CPU  PID    MSW        CSW        PF    STAT              TIME  NAME
>   0  0      0          7508041    0     01400080     166038894  ROOT
>   0  0      0          2          0     00000082            55  timsPip=
eReceiver
>   0  1009   751        8800       0     00c00082        143026  display=
-1008
>   0  1010   0          7514585    0     00c00084      54472477  samplin=
g-1008
>=20
> The new TIME column contains the accumulated execution time of each act=
ive thread in
> nanoseconds. It's now a job of some user-space tool (shell script?) to =
pick those

I was thinking of the right unit, I swear:
s/nanoseconds/microseconds/

> numbers up and do, e.g., periodic evaluation (I'm thinking of some "xen=
o-top"). Any
> volunteer around to hack this? Would be very welcome!
>=20
> Jan
>=20
> PS: Could someone have a look that I didn't miss an accounting point an=
d my
> acquisition is sound?
>=20

Jan


--------------enig3D8C04E032772AFE6A5A2467
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErPbYniDOoMHTA+kRAhgTAJ9RDX2v/0QxR/1o4wPhNGk32ccH/QCfUeax
0eW9Nd7CetwNZInwedVh6TU=
=rX18
-----END PGP SIGNATURE-----

--------------enig3D8C04E032772AFE6A5A2467--

