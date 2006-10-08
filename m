Message-ID: <45293C9B.1030608@domain.hid>
Date: Sun, 08 Oct 2006 19:59:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Compiler and linker flags
References: <OFACF3C5AC.1F615263-ONC12571FD.004ACE3C-C12571FD.004F1995@domain.hid>	<4528FBE5.7020803@domain.hid>
	<17705.6276.735921.764908@domain.hid>
In-Reply-To: <17705.6276.735921.764908@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF949BE9FEF1786F71C3099E5"
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
Cc: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF949BE9FEF1786F71C3099E5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Thomas Wiedemann wrote:
>  > >> BTW, providing a patch, even if it's trivial, is always welcome i=
n such
>  > >> cases.
>  > >=20
>  > > I had already attached it to the email, but then i thought it was =
so
>  > > ridiculously small ... and removed it :)
>  > > So here it is again.
>  >=20
>  > The point is if you start a thread like "[PATCH] Remove -I. from
>  > xeno-config" and attach a full patch (including ChangeLog fragment) =
you
>  > make it more likely to gain full attention and help to get it applie=
d
>  > quickly.
>  >=20
>  > >=20
>  > > =20
>  > >> Well, -Wall should be considered a reasonable policy to keep code=
 clean.
>  > >> Me feeling is that this switch is fairly appropriate, specificall=
y for
>  > >> real-time applications. But it can easily be relaxed by adding sp=
ecific
>  > >> -Wno-xxx after the Xenomai flags. And *that* should happen explic=
itly.
>  > >>
>  > >> -pipe is an optimisation of the build process, something one may
>  > >> discuss, though I don't see an immediate reason why it could fail=
 in the
>  > >> context of Xenomai applications (that should use the GNU toolchai=
n=20
>  > > anyway).
>  > >=20
>  > > I definitley agree on the use of "-Wall" and "-pipe", but i think =
these
>  > > optional flags should be set in the main project, and not by exter=
nal
>  > > libraries or tools. It's not that i think they would conflict with=

>  > > other flags or that they are wrong or inappropriate, but just beca=
use
>  > > i expect *-config-tools to not specify any flags that affect the
>  > > compiler behaviour. I just don't want every libraries' config-scri=
pt
>  > > to place the authors favorite compiler-flags into my own flags.
>  >=20
>  > I agree now, for the sake of cleanness and as we are not just discus=
sing
>  > -Wall and -pipe here:
>  >=20
>  > # xeno-config --xeno-cflags
>  > -I. -I<xenomai-inst>/include -O2 -D_GNU_SOURCE -D_REENTRANT -D__XENO=
__
>  > -Wall -pipe -fstrict-aliasing -Wno-strict-aliasing
>  >=20
>  > # xeno-config --posix-cflags
>  > -I. -I<xenomai-inst>/include -I<xenomai-inst>/include/posix -O2
>  > -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -pipe -fstrict-aliasing
>  > -Wno-strict-aliasing
>  >=20
>  > # xeno-config --xeno-ldflags
>  > -L<xenomai-inst>/lib -lpthread -rdynamic
>  >=20
>  > # xeno-config --posix-ldflags
>  > -Wl,@<xenomai-inst>/lib/posix.wrappers -L<xenomai-inst>/lib -lpthrea=
d_rt
>  > -lpthread -lrt -rdynamic
>  >=20
>  > (all x86, other platforms may vary)
>  >=20
>  > @All: What flags are *really* required to build and link some *user*=

>  > application against Xenomai? Beside that -I. at least -O2 can be fai=
rly
>  > problematic I guess - if not even more. Also the debug mode of the
>  > Xenomai build leaks to the user if (s)he wants it or not.
>  >=20
>  > Time for a cleanup?
>=20
> -D_GNU_SOURCE is necessary, at least when compiling for the POSIX skin,=

> because on some platforms, it makes the defines for the pthread mutex
> types available.
>=20
> -D_REENTRANT is required when compiling a multithreaded application wit=
h
> the glibc. Theoretically, the glibc is not supposed to make its service=
s
> thread safe when a program is not compiled with this define.
>=20

Ok, they will be saved from the hoover. What about those:

 o -D__XENO__
 o -fstrict-aliasing -Wno-strict-aliasing
 o -rdynamic

Again, only /wrt to user apps. We can keep them all internally.

Jan


--------------enigF949BE9FEF1786F71C3099E5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFKTyeniDOoMHTA+kRApqtAJwNRbqaJWbGr/txSh/e1QwVkNcv+gCeJBO2
HV+7/FDsoNjyWEsXdOavna8=
=B76A
-----END PGP SIGNATURE-----

--------------enigF949BE9FEF1786F71C3099E5--

