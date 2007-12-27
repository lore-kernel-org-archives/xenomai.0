Message-ID: <47739370.8000803@domain.hid>
Date: Thu, 27 Dec 2007 12:58:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2ff1a98a0712200643u797cfad2ve3848d88feda3bea@domain.hid>
	<18290.62470.714603.940223@domain.hid>
In-Reply-To: <18290.62470.714603.940223@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC0E16735DFE1B6D881509E0B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Auto closing of file descriptors and fork.
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
--------------enigC0E16735DFE1B6D881509E0B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>  > Hi,
>  >=20
>  > I have a problem with auto closing of file descriptors and fork. I
>  > have an application (a modified pppd, to name it), which in a certai=
n
>  > mode (pppd "updetach" mode) opens some real-time file descriptors,
>  > forks and exit the parent, continuing to use the file descriptors in=

>  > the child. The problem is that when exiting the parent, file
>  > descriptors are automatically destroyed and therefore can not be use=
d
>  > in the child.
>  >=20
>  > Any ideas for a fix ?
>=20
> More precisely. We need to trap the "fork" event, and handle it in the
> skins event callbacks. We will need to create a new ppd structure for
> the new process, but what will we do with the skin objects ? If we keep=

> the same objects for the child and increment a reference count, we will=

> end up with an object that need to be inserted in two per-process
> lists. If we create new objects, how will we manage for user-space
> references (inherited accross fork) to remain valid ?

The only way I see are process-private file descriptor tables +
reference counters for the underlying objects. On fork, the descriptor
table would be cloned and the reference counter of the contained object
would be incremented, creating another reference to them. Or should we
rather re-open those objects, creating another instance?

BTW, by adding a fork hook, my old idea of storing the ppd reference in
some I-pipe ptdkey comes into reach again.

Jan


--------------enigC0E16735DFE1B6D881509E0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHc5N0niDOoMHTA+kRAncKAJ48uodsiKUkgMEFq1B/9+gD0DppVQCdH01P
A9nstx1ArRgUNycemq63ajQ=
=Y1eT
-----END PGP SIGNATURE-----

--------------enigC0E16735DFE1B6D881509E0B--

