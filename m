Message-ID: <483278B2.9040805@domain.hid>
Date: Tue, 20 May 2008 09:07:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18459.38249.462320.715909@domain.hid>	<18459.38430.835407.942336@domain.hid>	<18459.38500.720338.652195@domain.hid>	<18459.38558.684426.240775@domain.hid>	<18459.38644.699369.801548@domain.hid>	<18459.38704.252719.734650@domain.hid>	<18459.38785.367098.763153@domain.hid>	<18459.38879.202210.838294@domain.hid>	<48305C5D.3020601@domain.hid>	<18480.25075.894860.415321@domain.hid>	<4830677C.9050401@domain.hid>	<18480.27194.137841.953471@domain.hid>	<48306CDD.8050607@domain.hid>	<18480.28886.48710.503957@domain.hid>	<48307BDF.1010906@domain.hid>
	<18482.1009.89042.272689@domain.hid>
	<48327587.5000600@domain.hid>
In-Reply-To: <48327587.5000600@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1A1081C35378E603C92F25B5"
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1A1081C35378E603C92F25B5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>  > Gilles Chanteperdrix wrote:
>>  > > Jan Kiszka wrote:
>>  > >  > Gilles Chanteperdrix wrote:
>>  > >  > > Jan Kiszka wrote:
>>  > >  > >  > Gilles Chanteperdrix wrote:
>>  > >  > >  > > Philippe Gerum wrote:
>>  > >  > >  > >  > Gilles Chanteperdrix wrote:
>>  > >  > >  > >  > > Since binding of the semaphore heaps is now made b=
y xeno_skin_bind, there is
>>  > >  > >  > >  > > much less modifications in src/skins/posix/init.c.=
 However, I had to do
>>  > >  > >  > >  > > something really ugly: since binding the semaphore=
 heaps by xeno_skin_bind
>>  > >  > >  > >  > > requires calls to open, ioctl, mmap, close and mun=
map, I redefined these symbols
>>  > >  > >  > >  > > to be the __real_ variants before including bind.h=
=2E
>>  > >  > >  > >  >=20
>>  > >  > >  > >  > Is there any upside to do this instead of simply cal=
ling the __real_*
>>  > >  > >  > >  > placeholders, since we do already provide weak wrapp=
ers for those when the
>>  > >  > >  > >  > linker's wrapping magic is not invoked?
>>  > >  > >  > >=20
>>  > >  > >  > > The point is that the wrappers and linker magic only ta=
ke place for
>>  > >  > >  > > POSIX skins. Other skins have to call the genuine open,=
 ioctl, mmap,
>>  > >  > >  > > close and munmap services.
>>  > >  > >  >=20
>>  > >  > >  > What about controlling the desired prefix for generic fun=
ctions in
>>  > >  > >  > bind.h via some #define that the caller has to/can set be=
fore including
>>  > >  > >  > the header:
>>  > >  > >  >=20
>>  > >  > >  > #define POSIX_PREFIX	__real_
>>  > >  > >  > #include <asm-generic/bits/bind.h>
>>  > >  > >  >=20
>>  > >  > >  > and there we would have:
>>  > >  > >  >=20
>>  > >  > >  > POSIX_PREFIX##open(...);
>>  > >  > >  >=20
>>  > >  > >  > Looks a bit cleaner to me.
>>  > >  > >=20
>>  > >  > > Well, in this case we end up cluttering the code with the PO=
SIX_PREFIX
>>  > >  > > macro, even in the non posix case where no prefix is needed.=

>>  > >  >=20
>>  > >  > Yes, but there are only few spots. The advantage of this strat=
egy is
>>  > >  > that it is explicit in-place (ie. inside bind.h). That avoids =
potential
>>  > >  > collateral damage in the future when other services are added =
to that
>>  > >  > helper which shall not be wrapped.
>>  > >=20
>>  > > Actually, the only important call is open. Since once the file
>>  > > descriptor has been created with __real_open, all syscall wrapper=
s will
>>  > > automatically fall back to the __real syscall variants.
>>  > >=20
>>  >=20
>>  > Then let's just provide __real_open() as a weak symbol in all libs;=
 that's less
>>  > error-prone that fiddling with the preprocessor.
>>
>> For now, I kept a solution based on the preprocessor. If I remember
>> correctly, the __real stuff needs to be in a separate object, this
>> means that we cannot put __real_open definition in bind.h, we have to
>> generate an open_wrapper.lo object and link every library with this
>> object. Is this really what we want ?
>>
>=20
> bind.h is meant to be included exclusively from init.c files. So yes, a=
s far as
> possible, we don't want to mess with the preprocessor.

Then better let the caller decide which version to call. A simple
argument to xeno_bind_skin can be passed through to map_sem_heap and
define there if open or __real_open is used. As the functions are
inlined, we shouldn't see the other symbol after the compilation.

Jan


--------------enig1A1081C35378E603C92F25B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIMni6niDOoMHTA+kRAn3ZAJ9Kcxbl8bjejZO5s7NTxWBCfTGeegCeJTZm
D374vC5zWuEpYtI1Yv9tMVk=
=2l+i
-----END PGP SIGNATURE-----

--------------enig1A1081C35378E603C92F25B5--

