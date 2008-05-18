Message-ID: <4830677C.9050401@domain.hid>
Date: Sun, 18 May 2008 19:29:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18459.38249.462320.715909@domain.hid>	<18459.38430.835407.942336@domain.hid>	<18459.38500.720338.652195@domain.hid>	<18459.38558.684426.240775@domain.hid>	<18459.38644.699369.801548@domain.hid>	<18459.38704.252719.734650@domain.hid>	<18459.38785.367098.763153@domain.hid>	<18459.38879.202210.838294@domain.hid>	<48305C5D.3020601@domain.hid>
	<18480.25075.894860.415321@domain.hid>
In-Reply-To: <18480.25075.894860.415321@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig472A7C4269E1794B2DAF5DD5"
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
--------------enig472A7C4269E1794B2DAF5DD5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Since binding of the semaphore heaps is now made by xeno_skin_bind=
, there is
>  > > much less modifications in src/skins/posix/init.c. However, I had =
to do
>  > > something really ugly: since binding the semaphore heaps by xeno_s=
kin_bind
>  > > requires calls to open, ioctl, mmap, close and munmap, I redefined=
 these symbols
>  > > to be the __real_ variants before including bind.h.
>  >=20
>  > Is there any upside to do this instead of simply calling the __real_=
*
>  > placeholders, since we do already provide weak wrappers for those wh=
en the
>  > linker's wrapping magic is not invoked?
>=20
> The point is that the wrappers and linker magic only take place for
> POSIX skins. Other skins have to call the genuine open, ioctl, mmap,
> close and munmap services.

What about controlling the desired prefix for generic functions in
bind.h via some #define that the caller has to/can set before including
the header:

#define POSIX_PREFIX	__real_
#include <asm-generic/bits/bind.h>

and there we would have:

POSIX_PREFIX##open(...);

Looks a bit cleaner to me.

Jan


--------------enig472A7C4269E1794B2DAF5DD5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIMGeBniDOoMHTA+kRAipLAJ4nhf0hSwGG+EPNbHboOdsecZ0NEgCeNM0b
l8Z1W8wbLz9/BR9C4fJV7hg=
=Lq0d
-----END PGP SIGNATURE-----

--------------enig472A7C4269E1794B2DAF5DD5--

