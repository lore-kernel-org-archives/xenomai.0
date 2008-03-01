Message-ID: <47C9ACF9.4020106@domain.hid>
Date: Sat, 01 Mar 2008 20:22:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C020A9.3050704@domain.hid>	<47C02194.6010607@domain.hid>	<18368.23071.202085.682705@domain.hid>	<47C05FE8.4090908@domain.hid>
	<18377.42613.595681.980063@domain.hid>
In-Reply-To: <18377.42613.595681.980063@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9D0BA5D537701BC5B73EFE70"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 1/4] Refactor generic system.h
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
--------------enig9D0BA5D537701BC5B73EFE70
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > In order to allow further optimizations of xnlock, I started wi=
th
>  > >  > refactoring the related system.h. This improves the readability=

>  > >  > significantly, IMHO. It also happen to reduce the text size of
>  > >  > __xnlock_get a bit by avoid redundant rthal_processor_id read-o=
uts.
>  > >  >=20
>  > >  > Another quirk I happen to remove: xnlock debugging depends on
>  > >  > XENO_OPT_DEBUG_NUCLEUS, but needlessly we used to pick the debu=
g version
>  > >  > of xnlock_t already with XENO_OPT_DEBUG.
>  > >=20
>  > > There is a lot of whitespace change in this patch, which make it h=
ard to
>  > > read.
>  >=20
>  > Well, this patch is mostly about whitespace and formatting fixes (am=
ong
>  > which ifdef reduction falls for me as well). But I can split it up i=
f
>  > desired.
>  >=20
>  > >=20
>  > > Anyway, there are a few things I do not like in this patch:
>  > > - macro which make reference to symbols defined elsewhere
>  >=20
>  > You mean XNLOCK_DBG_PREPARE_ACQUIRE vs. XNLOCK_DBG_SPINNING/ACQUIRED=
?
>  > Granted, not nice but so far the most compact approach I found. My g=
oal
>  > was to keep the lock implementations as pure as possible (you can ea=
sily
>  > ignore the debug stuff now when reading xnlock_get/put).
>  >=20
>  > > - functions arguments as macro, I find more readable the #ifdef wi=
th the
>  > >   different function prototypes, the code can be read without havi=
ng to
>  > >   look at a different place.
>  >=20
>  > I'm open to learn a third way to achieve what we need. I'm just
>  > convinced that the old way was far worse.
>  >=20
>  > Please consider for a better suggestion that the number of variants
>  > increase with my ticket lock. That's why I tried to stuff things in
>  > macros. Hmm, maybe we should simply get rid of the file/line/functio=
n
>  > stuff completely and switch to IP + ksyms. What do you think?
>=20
> I do not want to leave this in a dead end. IMO, your approach make
> xnlock_get readable in the non debugging case at the expense of its
> readability in the debugging case. I would better see the two
> implementations with a unique ifdef. Granted, there will be some code
> duplication, but it will not be that much, and this allows us to move
> the debugging version out of line while keeping the non debugging case
> inline.

Don't panic. I'm sitting on a new version of this patch series, only=20
running a final benchmark to estimate the gain. This unfortunately takes =

a lot of time.

BTW, the series will also add lock debugging for UP, and it beautifies=20
the refactoring a bit more, addressing your concerns.

Jan


--------------enig9D0BA5D537701BC5B73EFE70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHyaz+niDOoMHTA+kRAqJTAJ0QtLB2uAw5E5JCscjZY0FVW9l+OgCdGju8
He44izckYGci4tLPX26Solo=
=eblQ
-----END PGP SIGNATURE-----

--------------enig9D0BA5D537701BC5B73EFE70--

