Message-ID: <441EDA08.7050900@domain.hid>
Date: Mon, 20 Mar 2006 17:36:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] yet another test tool
References: <441DD89A.4000501@domain.hid>
	<17438.51347.702261.525919@domain.hid>
In-Reply-To: <17438.51347.702261.525919@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig285556D83F5765B264B5CD81"
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
--------------enig285556D83F5765B264B5CD81
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > (...)As Xenomai does not support hard-RT signal delivery yet (...)
>=20
> This is the next feature missing to the POSIX skin. I would like to
> implement this, but I am not sure which way to go :
> - either, if it is possible, getting Linux signals services to run in
>   every domain at Adeos level, by replacing spinlocks with spinlocks_hw=

>   and such kind of tricks;
> - or adding a generic service at the adeos layer (a hook called when
>   returning to user-space), building a generic user-space signals
>   service at the nucleus level, and finally building all posix signals
>   services on top of this.
>=20
> The first approach guarantees the best integration with Linux, but
> potentially add sections in Linux that are not preemptible by any
> Xenomai skin. With the second approach, all services related to signals=

> have to be reimplemented plus some shortcuts to have standard user-spac=
e
> tools such as "kill" working.
>=20

The preemptibility of the Linux signal code path heavily depends on the
tasklist_lock, and that was still an issue even for PREEMPT_RT with all
their modifications the last time I checked their code more thoroughly
(~2 months ago). Meanwhile, things may have improved for that tree, but
I doubt that this is already in mainline, not to speak of older 2.6 or
even 2.4 kernels.

As a first step, I would vote for establishing that generic service to
redirect the userspace return path to some arbitrary handler in hard-RT
context. Then we can think about how to handle signal injection from
Linux vs. injection from Xenomai gracefully.

>=20
>  >=20
>  > What do you think, is it worth including as a POSIX counterpart for
>  > testsuite/latency?
>=20
> There are a few details that I do not like about this tool, but we may
> take it, and fix the details later.

It's a real hack, isn't it ;)? But what precisely do you mean?

Jan


--------------enig285556D83F5765B264B5CD81
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHtoIniDOoMHTA+kRAh+oAJ0QAzEF1e9tt16x1FgobHoXZZsUfQCfRAta
CO91aZ4zXERPW7UMiHyqgjg=
=Q7LH
-----END PGP SIGNATURE-----

--------------enig285556D83F5765B264B5CD81--

