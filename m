Message-ID: <47C05FE8.4090908@domain.hid>
Date: Sat, 23 Feb 2008 19:03:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C020A9.3050704@domain.hid>	<47C02194.6010607@domain.hid>
	<18368.23071.202085.682705@domain.hid>
In-Reply-To: <18368.23071.202085.682705@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF7B61BE8C87D3A395085CA5D"
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
--------------enigF7B61BE8C87D3A395085CA5D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > In order to allow further optimizations of xnlock, I started with
>  > refactoring the related system.h. This improves the readability
>  > significantly, IMHO. It also happen to reduce the text size of
>  > __xnlock_get a bit by avoid redundant rthal_processor_id read-outs.
>  >=20
>  > Another quirk I happen to remove: xnlock debugging depends on
>  > XENO_OPT_DEBUG_NUCLEUS, but needlessly we used to pick the debug ver=
sion
>  > of xnlock_t already with XENO_OPT_DEBUG.
>=20
> There is a lot of whitespace change in this patch, which make it hard t=
o
> read.

Well, this patch is mostly about whitespace and formatting fixes (among
which ifdef reduction falls for me as well). But I can split it up if
desired.

>=20
> Anyway, there are a few things I do not like in this patch:
> - macro which make reference to symbols defined elsewhere

You mean XNLOCK_DBG_PREPARE_ACQUIRE vs. XNLOCK_DBG_SPINNING/ACQUIRED?
Granted, not nice but so far the most compact approach I found. My goal
was to keep the lock implementations as pure as possible (you can easily
ignore the debug stuff now when reading xnlock_get/put).

> - functions arguments as macro, I find more readable the #ifdef with th=
e
>   different function prototypes, the code can be read without having to=

>   look at a different place.

I'm open to learn a third way to achieve what we need. I'm just
convinced that the old way was far worse.

Please consider for a better suggestion that the number of variants
increase with my ticket lock. That's why I tried to stuff things in
macros. Hmm, maybe we should simply get rid of the file/line/function
stuff completely and switch to IP + ksyms. What do you think?

>=20
> Something we could be interesting would be to be able to enable
> spinlocks debug in UP, which would enable real debugging xnlocks in thi=
s
> case. I made an attempt of doing this on ARM some time ago, this
> generated a kernel that would lockup at boot. But I think this is
> something we should sort out.
>=20

Yeah, sounds good and should be feasible. Will check.

Jan


--------------enigF7B61BE8C87D3A395085CA5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHwF/sniDOoMHTA+kRAodUAJ9iw6OfatHvzTv2/qHtojgSYnriMQCcDO+b
gcb7dWCyP38E8GETeKCgEWM=
=nua8
-----END PGP SIGNATURE-----

--------------enigF7B61BE8C87D3A395085CA5D--

