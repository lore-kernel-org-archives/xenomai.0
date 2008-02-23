Message-ID: <47C01300.9070204@domain.hid>
Date: Sat, 23 Feb 2008 13:35:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47BEA5C3.9050100@domain.hid>
	<18367.7523.207507.331701@domain.hid>
In-Reply-To: <18367.7523.207507.331701@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD6D986DD30EDE816C3A8E748"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH] tracer: use per-cpu trace buffers
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD6D986DD30EDE816C3A8E748
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > This patch addresses two issues:
>  >=20
>  >  - fixes boot hang with CONFIG_IPIPE_TRACE, !CONFIG_IPIPE_TRACE_VMAL=
LOC,
>  >    and large CONFIG_NR_CPUS (due to the huge trace buffers this impl=
ies,
>  >    even if the system has only a few CPUs in fact)
>=20
> This is something I observed even on UP systems: the kernel does not
> boot on ARM if CONFIG_IPIPE_TRACE_VMALLOC is not selected.
>=20

Yeah, well known, that's why we have vmalloc'ed trace buffers.

I just wondered again if this is an arch-specific issue, or if it
depends on the RAM size. If it is arch-specific, you are welcome to
change the default of IPIPE_TRACE_VMALLOC ("default y if ARM || ...").
Or reduce IPIPE_TRACE_SHIFT for ARM, given there is a reasonable value
(/wrt to the tracer) your boards still boot with.

Jan


--------------enigD6D986DD30EDE816C3A8E748
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHwBMEniDOoMHTA+kRAsjGAJ9IKd31IfOPX3W8pmZ6ekf2zx8fGACdHyOH
iKRj9tEV7bBqkQQMQerhIn0=
=7jKK
-----END PGP SIGNATURE-----

--------------enigD6D986DD30EDE816C3A8E748--

