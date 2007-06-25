Message-ID: <468025AA.7080908@domain.hid>
Date: Mon, 25 Jun 2007 22:29:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200706252111.40219.dmitry.adamushko@domain.hid>
In-Reply-To: <200706252111.40219.dmitry.adamushko@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5A5E4B430FBEEC67D7161B73"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC][PATCH] shirq locking rework
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5A5E4B430FBEEC67D7161B73
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Dmitry Adamushko wrote:
> Hello Jan,
>=20
> well, take it with 2 huge grains of salt.. it's even not compile-tested=
 :-)

Yeah, that might explain while already trying to parse it manually
failed: What is xnintr_sync_stat_references? :)

>=20
> I don't think I've got it really nicer than your first patch.. the only=
 additional point is that
> 'prev =3D xnstat_get_current()' reference is also tracked as reference =
accounting becomes
> a part of the xnstat interface (not sure we do need it though).

Mind to elaborate on _why_ you think we need this, specifically if it
adds new atomic counters? I'm too lazy looking for the probably valid
reason on my own. Apropos atomic use counters: already considered all
memory barrier issues for your locking scheme?

>=20
> Well (#2), I have to say that the whole intr subsystem looks not that n=
ice (maybe partly due
> to being overloaded with xnstat details).. so I think, it'd require a c=
loser look.

Let's get it right first, then think about aesthetic or even concrete
optimisations again.

>=20
> Anyway, here is what I've got out of your patch so far.. the main issue=
 is whether we go this way
> or it just makes things even more uglier.

Again, correctness, race-avoidance worries me first right now.

>=20
> (a side effect : I transformed xnstat_* macroses into 'static inline' f=
unction.. I guess, this way it's a bit nicer)

Uhh, be careful, I burned my fingers with similar things recently as
well. You have to make sure that all types are resolvable for _all_
includers of that header. Otherwise, I'm fine with cleanups like this.
But I think there was once a reason for #define.

Thanks,
Jan


PS: Please note my latest refactoring check-in to SVN, touching stat.h.


--------------enig5A5E4B430FBEEC67D7161B73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgCWrniDOoMHTA+kRAnpCAJ9fRKkiA1hj6oyEcm7yHKOEIgWVuQCeNNn5
BrqSwdrZsWagGUhvkyOH7qE=
=EFWN
-----END PGP SIGNATURE-----

--------------enig5A5E4B430FBEEC67D7161B73--

