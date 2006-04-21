Message-ID: <4449023A.6050809@domain.hid>
Date: Fri, 21 Apr 2006 18:03:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] shadow threads with prio 0 / SCHED_NORMAL
References: <4446B348.10403@domain.hid>	<4448B81E.3090605@domain.hid>
	<17480.63623.600656.828303@domain.hid>
In-Reply-To: <17480.63623.600656.828303@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8A3AC960A3397DF767D57EFA"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8A3AC960A3397DF767D57EFA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > Jan Kiszka wrote:
>  > > Hi,
>  > >=20
>  > > this is an experimental hack to open the non-rt priority levels of=
 Linux
>  > > to Xenomai shadow threads, i.e. allow shadows to be scheduled unde=
r
>  > > SCHED_NORMAL when in secondary mode. The scenario are typical bord=
erline
>  > > threads between RT and non-RT: they share a critical code path wit=
h RT
>  > > threads, maybe mutex protected, but they are mostly time-sharing t=
hreads
>  > > which do not need SCHED_FIFO for this.
>  > >=20
>  > > The patch (be careful, quick-hack!) addresses the prio level 0 in =
the
>  > > ipipe patch, the nucleus/shadow subsystem, and the native skin. A =
quick
>  > > test with the attached demo showed the expected behaviour so far: =
no
>  > > lock-up during busy-waiting in secondary mode, prio-boost when hol=
ding
>  > > the lock (visible via /proc/xenomai/sched), no obvious side effect=
s.
>  > >=20
>  > > Any comments? Does this break other things in a subtle way?
>  >=20
>  > An initial comment on the general usage of this extension: since the=
=20
>  > threads running in SCHED_OTHER/SCHED_NORMAL mode are expected to run=
=20
>  > non-RT workloads while still being able to use the RT infrastructure=
 for=20
>  >   communicating with the rest of the RT system, I think that the bes=
t=20
>  > places for creating such hybrids are in the rt_task_shadow (native s=
kin)=20
>  > and pthread_setschedparam (POSIX skin) calls, which would make it cl=
ear=20
>  > that a regular Linux thread is involved [and as such needs to be cre=
ated=20
>  > by a normal call to pthread_create()], which also happens to benefit=
=20
>  > from the RT infrastructure mainly for communication/sychronization p=
urpose.
>=20
> What about keeping SCHED_RR as the default scheduling policy and
> requiring users to manually select SCHED_NORMAL in thread creation
> attributes in order to create hybrid threads with pthread_create ?
>=20

Considering that Linux uses SCHED_OTHER as default, I think applying the
same on the POSIX skin would follow the "least surprise" principle.

Jan


--------------enig8A3AC960A3397DF767D57EFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESQI6niDOoMHTA+kRAtPAAKCAL1E/aApEq2tdkf0PgjacPFU5jgCfaM9h
gUhEzl26mdw3SSrIxQx4pss=
=J59/
-----END PGP SIGNATURE-----

--------------enig8A3AC960A3397DF767D57EFA--

