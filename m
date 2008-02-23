Message-ID: <47C063F0.8040503@domain.hid>
Date: Sat, 23 Feb 2008 19:20:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C020A9.3050704@domain.hid>	<47C02491.203@domain.hid>
	<18368.24026.551410.454239@domain.hid>
In-Reply-To: <18368.24026.551410.454239@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7CFC9B7DFD0722518A94DC1A"
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
--------------enig7CFC9B7DFD0722518A94DC1A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > The root of all this: When Nick Piggin posted his first suggestion f=
or
>  > ticket spinlocks on LKML, I immediately liked the idea. For details
>  > check LWN [1], in a nutshell: This algorithm enforces strict FIFO or=
der
>  > for the admission to contended spinlocks, thus it improves the
>  > determinism on SMP systems with more than 2 CPUs.
>  >=20
>  > Meanwhile, ticket spinlocks are mainline (2.6.25). But that version =
has
>  > to drawbacks for us: it doesn't support nesting like xnlock does, an=
d it
>  > is x86-only so far.
>  >=20
>  > So I designed a version for Xenomai which is both nestable and
>  > arch-independent. It is certainly not as optimal as mainline's versi=
on,
>  > but our code path stresses the locking code differently anyway.
>  >=20
>  > This thing here /seems/ to work, but I'm lacking CPUs at home to tes=
t.
>  > You can't truly stress ticket locks with only a single dual-core :-/=
=2E
>  > QEMU runs into a live-lock with -smp 2, this patch applied and two
>  > moderate latency loops, but that might be an artifact of its
>  > single-threaded VCPU scheduling. And kvm currently locks up under SM=
P
>  > even without any change, but kvm and SMP is a story of its own. Ther=
e is
>  > hope: 16-way is waiting at work... :)
>=20
> Xenomai uses a Big Kernel Lock, an approach known to not scale very
> well. So, if we want to scale correctly on machines with many cpus, we
> should change our locking strategy first.

Per-cpu IPC objects, per-cpu nklock - I'm all with you! But that's stuff
for a massive restructuring we could schedule for Xenomai 3.

This thing here surely does not help to scale RT loads across 16 CPUs or
more. But it already pays off determinism-wise with 3 or 4 CPUs involved
in RT jobs with moderate contention on nklock. It is nothing for 2-way
boxes (except for testing) where the exiting algorithm is more efficient
(and where you don't have the risk of unfair lock admission anyway).

Jan


--------------enig7CFC9B7DFD0722518A94DC1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHwGPwniDOoMHTA+kRAl55AJ9/buGbR2LklaO6WuQUrpBaMYwtRACdFECv
7ni3b83oYOod8SGcgygiHtQ=
=fv0l
-----END PGP SIGNATURE-----

--------------enig7CFC9B7DFD0722518A94DC1A--

