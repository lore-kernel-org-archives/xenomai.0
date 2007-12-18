Message-ID: <47680FC4.1030505@domain.hid>
Date: Tue, 18 Dec 2007 19:21:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <835557.38744.qm@domain.hid>
In-Reply-To: <835557.38744.qm@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4FCC33E03F8E73613AAAF72A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] Using ADEOS to run multiple Linux kernels
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jonathan Day <imipak@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4FCC33E03F8E73613AAAF72A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jonathan Day wrote:
> Hi,
>=20
> According to the white papers and other documentation
> on the ADEOS site, it is possible to use the ADEOS
> nanokernel to run multiple kernels in parallel.
> However, what I am not entirely sure on is how you
> would actually do so.
>=20
> What I am wanting to do is run two Linux kernels in
> parallel, minus the overheads of virtualization (I
> don't need it), where the only requirements are that
> if one Linux kernel crashes, it won't take out the
> other and that there's some way of restarting a
> crashed kernel.

I guess you are rather looking for para-virtualized Linux over something
like the Xen hypervisor. This comes with some overhead, but it is fairly
low. The point is that you need memory protection for crash recovery -
otherwise you risk that the crash corrupts memory of the backup kernel.
And with memory protection comes the (para-)virtualization overhead.

In contrast, Adeos, also in its broader original design, is intended to
run multiple kernel _cooperatively_, and that conflicts with your
requirement of crash isolation.

>=20
> The documentation I can find suggests that ADEOS would
> be perfect for the job. It's lightweight, doesn't have
> anything I don't need, and is designed to run multiple
> kernels within it. The only bit left is to find an
> example, a HOWTO, or some other information on how I'd
> actually do something like this.

AFAIK, this vision of the paper always remained a vision. In practice,
the non-root domains are always some specialized, cooperating real-time
kernels.

>=20
> Can anyone give me a recommendation on where I'd find
> the information I'd need?
>=20
> Jonathan
>=20

Jan


--------------enig4FCC33E03F8E73613AAAF72A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHaA/MniDOoMHTA+kRAhdhAJ9qiTIp/0PG4NLBeYUndjUhuXTRmQCfdntd
8FrtHkReFu3X0Mn8it7xRjs=
=Xb2y
-----END PGP SIGNATURE-----

--------------enig4FCC33E03F8E73613AAAF72A--

