Message-ID: <47C07049.7070207@domain.hid>
Date: Sat, 23 Feb 2008 20:13:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C020A9.3050704@domain.hid>	<47C02491.203@domain.hid>	<18368.24026.551410.454239@domain.hid>	<47C063F0.8040503@domain.hid>
	<18368.26938.940855.287204@domain.hid>
In-Reply-To: <18368.26938.940855.287204@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig41486B776B262A8BE9FFFC37"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC][PATCH 4/4] Recursive FIFO ticket xnlock
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
--------------enig41486B776B262A8BE9FFFC37
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > The root of all this: When Nick Piggin posted his first suggest=
ion for
>  > >  > ticket spinlocks on LKML, I immediately liked the idea. For det=
ails
>  > >  > check LWN [1], in a nutshell: This algorithm enforces strict FI=
FO order
>  > >  > for the admission to contended spinlocks, thus it improves the
>  > >  > determinism on SMP systems with more than 2 CPUs.
>  > >  >=20
>  > >  > Meanwhile, ticket spinlocks are mainline (2.6.25). But that ver=
sion has
>  > >  > to drawbacks for us: it doesn't support nesting like xnlock doe=
s, and it
>  > >  > is x86-only so far.
>  > >  >=20
>  > >  > So I designed a version for Xenomai which is both nestable and
>  > >  > arch-independent. It is certainly not as optimal as mainline's =
version,
>  > >  > but our code path stresses the locking code differently anyway.=

>  > >  >=20
>  > >  > This thing here /seems/ to work, but I'm lacking CPUs at home t=
o test.
>  > >  > You can't truly stress ticket locks with only a single dual-cor=
e :-/.
>  > >  > QEMU runs into a live-lock with -smp 2, this patch applied and =
two
>  > >  > moderate latency loops, but that might be an artifact of its
>  > >  > single-threaded VCPU scheduling. And kvm currently locks up und=
er SMP
>  > >  > even without any change, but kvm and SMP is a story of its own.=
 There is
>  > >  > hope: 16-way is waiting at work... :)
>  > >=20
>  > > Xenomai uses a Big Kernel Lock, an approach known to not scale ver=
y
>  > > well. So, if we want to scale correctly on machines with many cpus=
, we
>  > > should change our locking strategy first.
>  >=20
>  > Per-cpu IPC objects, per-cpu nklock - I'm all with you! But that's s=
tuff
>  > for a massive restructuring we could schedule for Xenomai 3.
>=20
> This does not look that easy. What I meant is rather that Xenomai is
> probably run mostly on machines with not so many cpus.

You do not have to be an oracle to predict that the number of cores will
grow quickly in the foreseeable future on almost any arch, and that
users will like to _use_  more of them for RT. Running Xenomai on big
boxes is already no big deal today, you just have to keep the RT (and
borderline) load confined to a few of them. (Statically!) spreading the
load over more cores is then just the next logical step.

For sure, what I'm proposing, strict user-manageable cpu-locality of
objects and thus of lock mechanisms, is not simple to achieve - but it
would scale like hell and it would keep the costs mostly at UP level, on
huge SMP boxes, NUMA included. But even in that case, you will need
spinlocks from time to time, and you will want them to remain as
predictable as possible. So this patch is also a bit of an investment in
the future. :)

Jan


--------------enig41486B776B262A8BE9FFFC37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHwHBNniDOoMHTA+kRAtNZAJ9gKlDnc2oZB/3/TOrApvozoertdQCfc455
7AxpB2LGLliB9bqe/DWL3WM=
=s0lq
-----END PGP SIGNATURE-----

--------------enig41486B776B262A8BE9FFFC37--

