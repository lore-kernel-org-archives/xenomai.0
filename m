Message-ID: <4603E7FD.4010207@domain.hid>
Date: Fri, 23 Mar 2007 15:45:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [Fwd: [rfc][patch] queued spinlocks (i386)]
References: <4603DA8F.8050900@domain.hid> <1174660491.4606.17.camel@domain.hid>
In-Reply-To: <1174660491.4606.17.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig83518B1E11E64AA087C71825"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig83518B1E11E64AA087C71825
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2007-03-23 at 14:47 +0100, Jan Kiszka wrote:
>> That idea sounds worthwhile for xnlocks as well, doesn't it?
>=20
> Not sure, yet. Real starvation on xnlocks would require non-RT activity=

> to be completely locked out on all CPUs in the first place for that to
> happen, which would be the sign of a serious design flaw. I see no way
> to solve such initial problem by adding some fairness to the lock
> dispatching policy in primary mode.

I wasn't primarily thinking about avoiding starvation (would indeed be
bad if a system suffers from such a risk) but about making spinlock
contention more predictable in case that successive (but bounded) lock
acquisitions may occur.

>=20
> Still, thinking about this patch, since there is a price to pay for thi=
s
> approach due to serious cache-bouncing on high contention, using the
> waiter priority to manage the pending queue instead of a simple FIFO
> ticketing would be at least logically better, but likely even more
> costly.

Yeah, I thought about such approaches as well before. Don't have my
drafts on this at hand, but it was costly, specifically /wrt spinlock siz=
e.

Jan


--------------enig83518B1E11E64AA087C71825
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGA+f9niDOoMHTA+kRAs5PAJ9mPh176X3JdwEN3izR0zLB+BuHjQCeNuHV
aTsZ7Y1Q3i+9xRkVQ/AbpFs=
=mt5/
-----END PGP SIGNATURE-----

--------------enig83518B1E11E64AA087C71825--

