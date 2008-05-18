Message-ID: <48306CDD.8050607@domain.hid>
Date: Sun, 18 May 2008 19:52:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18459.38249.462320.715909@domain.hid>	<18459.38430.835407.942336@domain.hid>	<18459.38500.720338.652195@domain.hid>	<18459.38558.684426.240775@domain.hid>	<18459.38644.699369.801548@domain.hid>	<18459.38704.252719.734650@domain.hid>	<18459.38785.367098.763153@domain.hid>	<18459.38879.202210.838294@domain.hid>	<48305C5D.3020601@domain.hid>	<18480.25075.894860.415321@domain.hid>	<4830677C.9050401@domain.hid>
	<18480.27194.137841.953471@domain.hid>
In-Reply-To: <18480.27194.137841.953471@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig90779EC1F5D33F98822AB408"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Patch 7/7] Re-implementation of mutexes,
 user-space support.
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig90779EC1F5D33F98822AB408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Philippe Gerum wrote:
>  > >  > Gilles Chanteperdrix wrote:
>  > >  > > Since binding of the semaphore heaps is now made by xeno_skin=
_bind, there is
>  > >  > > much less modifications in src/skins/posix/init.c. However, I=
 had to do
>  > >  > > something really ugly: since binding the semaphore heaps by x=
eno_skin_bind
>  > >  > > requires calls to open, ioctl, mmap, close and munmap, I rede=
fined these symbols
>  > >  > > to be the __real_ variants before including bind.h.
>  > >  >=20
>  > >  > Is there any upside to do this instead of simply calling the __=
real_*
>  > >  > placeholders, since we do already provide weak wrappers for tho=
se when the
>  > >  > linker's wrapping magic is not invoked?
>  > >=20
>  > > The point is that the wrappers and linker magic only take place fo=
r
>  > > POSIX skins. Other skins have to call the genuine open, ioctl, mma=
p,
>  > > close and munmap services.
>  >=20
>  > What about controlling the desired prefix for generic functions in
>  > bind.h via some #define that the caller has to/can set before includ=
ing
>  > the header:
>  >=20
>  > #define POSIX_PREFIX	__real_
>  > #include <asm-generic/bits/bind.h>
>  >=20
>  > and there we would have:
>  >=20
>  > POSIX_PREFIX##open(...);
>  >=20
>  > Looks a bit cleaner to me.
>=20
> Well, in this case we end up cluttering the code with the POSIX_PREFIX
> macro, even in the non posix case where no prefix is needed.

Yes, but there are only few spots. The advantage of this strategy is
that it is explicit in-place (ie. inside bind.h). That avoids potential
collateral damage in the future when other services are added to that
helper which shall not be wrapped.

Jan


--------------enig90779EC1F5D33F98822AB408
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIMGzhniDOoMHTA+kRAtgiAJ0f2FD5HDKgvausM5Z8YipkxVTGUQCdGOxj
apWgWOAsVcm2PyMs/9SZ9AU=
=a9j+
-----END PGP SIGNATURE-----

--------------enig90779EC1F5D33F98822AB408--

