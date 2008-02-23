Message-ID: <47C06237.6080000@domain.hid>
Date: Sat, 23 Feb 2008 19:13:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C020A9.3050704@domain.hid>	<47C021F3.20002@domain.hid>
	<18368.23813.430770.37223@domain.hid>
In-Reply-To: <18368.23813.430770.37223@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE96B0F66A548B62A12136F9C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 3/4] Uninline heavy locking functions
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
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE96B0F66A548B62A12136F9C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > At least when SMP is enable, already __xnlock_get becomes far too
>  > heavy-weighted for being inlined. xnlock_put is fine now, but lookin=
g
>  > closer at the disassembly still revealed a lot of redundancy related=
 to
>  > acquiring and releasing xnlocks. In fact, we are mostly using
>  > xnlock_get_irqsave and xnlock_put_irqrestore. Both include fiddling =
with
>  > rthal_local_irq_save/restore, also heavy-weighted on SMP.
>  >=20
>  > So this patch turns the latter two into uninlined functions which
>  > reduces the text size or nucleus and skins significantly on x86-64/S=
MP
>  > (XENO_OPT_DEBUG_NUCLEUS disabled):
>=20
> I think the human idea of how long an inline function can be is far mor=
e
> restrictive than what a processor can take. When looking at assembly
> code, you always find the code long, whereas in reality it is not that
> long for a processor.=20
>=20
> Besides, IMO, the proper way to uninline xnlock operations is to leave
> the non contended case inline, and to move the spinning out of line.

This patch is not just about uninlining xnlock, that's only one half of
the savings. The other one is irq-disabling via i-pipe. The problem with
our case is that we have no simple single check to find out that we are
on a fast ride. Rather, we have to do quite some calculations/lookups
before the first check, and we have to perform multiple checks even in
the best case.

>=20
> And this is something we should not do without measuring its impact.

For sure, will be done. But I'm very optimistic about the results given
this massive code size reduction - which should translates in less cache
misses for the worst-case path. What increase latency most for us
(special hardware properties aside) is memory access, both data and text.=


Jan



--------------enigE96B0F66A548B62A12136F9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHwGI3niDOoMHTA+kRAjyuAKCC0VEzVyo7pmFD4RI+eZbVPwQosgCfS8a4
c8hkdo/tVSrH3iR+eFFv3ys=
=ff2U
-----END PGP SIGNATURE-----

--------------enigE96B0F66A548B62A12136F9C--

