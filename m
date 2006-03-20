Message-ID: <441EE837.4000406@domain.hid>
Date: Mon, 20 Mar 2006 18:36:55 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] yet another test tool
References: <441DD89A.4000501@domain.hid>	<17438.51347.702261.525919@domain.hid>
	<441EE46E.3080604@domain.hid>
In-Reply-To: <441EE46E.3080604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9366B43AF521DFECD42135A1"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9366B43AF521DFECD42135A1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>  > (...)As Xenomai does not support hard-RT signal delivery yet (...)
>>
>> This is the next feature missing to the POSIX skin. I would like to
>> implement this, but I am not sure which way to go :
>> - either, if it is possible, getting Linux signals services to run in
>>   every domain at Adeos level, by replacing spinlocks with spinlocks_h=
w
>>   and such kind of tricks;
>=20
> Would be a nightmare, I think. Way too many paths are involved in the
> vanilla kernel, and this would be overkill wrt what we want to do.
> Actually, what we need is basically exposing the nucleus signal
> interface to user-space, and map Linux RT signals over nucleus signals.=

> Other (non-RT) Linux signals would keep on being handled in secondary
> mode the way they are now.
>=20
>> - or adding a generic service at the adeos layer (a hook called when
>>   returning to user-space), building a generic user-space signals
>>   service at the nucleus level, and finally building all posix signals=

>>   services on top of this.
>=20
> A (maybe easier) third option would be to generalize some kind of
> pseudo-asynchronous call support, with a worker thread operating on a
> dedicated priority level inside applications registering for
> asynchronous notifications. The kernel-side would handle the server
> wakeups, providing a unified interface for pending on hooks, signals,
> watchdogs etc. It would also need to properly multiplex those events
> notified from within the skins, and wake up the right pending server in=

> user-space, which would in turn fire the user provided handler, all in
> primary mode. In any case, this would not be more costly latency-wise
> than implementing mere callouts, since most of the switching cost comes=

> from the MMU switch, which we would have to do in both cases, anyway.

We would need a "shadow" priority level for each real one so that those
handlers do not cause any priority inversions (the main RT issue of
servers). Moreover, it would require a bulk of extra threads, actually
one per used prio level, to handle all those calls with the correct
priority. My feeling: too costly, memory-wise.

Jan


--------------enig9366B43AF521DFECD42135A1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHug3niDOoMHTA+kRAv3QAJ9jTeAKDJDQYKU/Ot422qg+dzsNxgCfZ2m6
ZNX8p+zAHIK9PgSPGEvWb5s=
=3o2W
-----END PGP SIGNATURE-----

--------------enig9366B43AF521DFECD42135A1--

