Message-ID: <44FED2B7.8090408@domain.hid>
Date: Wed, 06 Sep 2006 15:52:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Sleep return value
References: <20060906134139.GA5852@domain.hid>
In-Reply-To: <20060906134139.GA5852@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB1651FE084D16A91F2403A10"
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
To: Bernhard Walle <bernhard.walle@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB1651FE084D16A91F2403A10
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Bernhard Walle wrote:
> Hello,
>=20
> ,----
> | int rtdm_task_sleep (uint64_t delay);
> | int rtdm_task_sleep_until (uint64_t wakeup_time);
> `----
>=20
> wouldn't it make sense to return 0 on success and in error case the
> number of nanoseconds that are remaining to the originally requested
> sleep period just as the Linux sleeping function behave?

Do you have a use-case for this? Would you consider this as the normal
scenario?

Also note that changing the return type would take away to possibility
to pass the error code.

>=20
> Of course that would introduce an incompatibility to current code.

Given a reasonably urging use-case or brokenness of the original
interface, API revisions may actually take place in RTDM (see the
history). But they will surely not happen without thorough
considerations of pros and cons. :)

Jan


--------------enigB1651FE084D16A91F2403A10
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/tK3niDOoMHTA+kRAisqAJ9QXLcvLT6UmoxINGrSD1ueKtLC3QCfd9Lr
FeeMbHHxn1m6Au00uhhFOkg=
=71J/
-----END PGP SIGNATURE-----

--------------enigB1651FE084D16A91F2403A10--

