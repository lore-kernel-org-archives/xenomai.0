Message-ID: <47C06CED.6020301@domain.hid>
Date: Sat, 23 Feb 2008 19:58:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C020A9.3050704@domain.hid>	<47C021F3.20002@domain.hid>	<18368.23813.430770.37223@domain.hid>	<47C06237.6080000@domain.hid>
	<18368.26367.809400.757141@domain.hid>
In-Reply-To: <18368.26367.809400.757141@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCBADC9167739C7E6F12E7FBB"
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
--------------enigCBADC9167739C7E6F12E7FBB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > At least when SMP is enable, already __xnlock_get becomes far t=
oo
>  > >  > heavy-weighted for being inlined. xnlock_put is fine now, but l=
ooking
>  > >  > closer at the disassembly still revealed a lot of redundancy re=
lated to
>  > >  > acquiring and releasing xnlocks. In fact, we are mostly using
>  > >  > xnlock_get_irqsave and xnlock_put_irqrestore. Both include fidd=
ling with
>  > >  > rthal_local_irq_save/restore, also heavy-weighted on SMP.
>  > >  >=20
>  > >  > So this patch turns the latter two into uninlined functions whi=
ch
>  > >  > reduces the text size or nucleus and skins significantly on x86=
-64/SMP
>  > >  > (XENO_OPT_DEBUG_NUCLEUS disabled):
>  > >=20
>  > > I think the human idea of how long an inline function can be is fa=
r more
>  > > restrictive than what a processor can take. When looking at assemb=
ly
>  > > code, you always find the code long, whereas in reality it is not =
that
>  > > long for a processor.=20
>  > >=20
>  > > Besides, IMO, the proper way to uninline xnlock operations is to l=
eave
>  > > the non contended case inline, and to move the spinning out of lin=
e.
>  >=20
>  > This patch is not just about uninlining xnlock, that's only one half=
 of
>  > the savings. The other one is irq-disabling via i-pipe. The problem =
with
>  > our case is that we have no simple single check to find out that we =
are
>  > on a fast ride. Rather, we have to do quite some calculations/lookup=
s
>  > before the first check, and we have to perform multiple checks even =
in
>  > the best case.
>=20
> This is my fault, a tradeoff I made, I thought that the atomic_cmpxchg
> could be heavy on SMP systems, so I made a first check to see if we are=

> not recursing. But we can do the two operations in one move if we accep=
t
> to have a failing atomic_cmpxchg when recursing.

I'm unsure about the cache pressure of cmpxchg vs. plain read. I guess
the existing variant is already better.

Moreover, the spinning code is only a fraction of the fraction. We
cannot eliminate the recursion check, and we still have all the
local_irq_save code. And _all_ this code mostly comes together, thus we
save so much by uninlining those two functions.

Jan


--------------enigCBADC9167739C7E6F12E7FBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHwGztniDOoMHTA+kRAuTgAJkBrAl8pfRz6tvEBMNXQ37YU8olLACfSxti
bnwNmTLySFRAu5cJOCE3Os0=
=nbL9
-----END PGP SIGNATURE-----

--------------enigCBADC9167739C7E6F12E7FBB--

