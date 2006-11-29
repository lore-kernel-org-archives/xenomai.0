Message-ID: <456D43D5.7060905@domain.hid>
Date: Wed, 29 Nov 2006 09:24:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <456C3EFB.7030303@domain.hid>
	<26126961.1164785592715.JavaMail.ngmail@domain.hid>
In-Reply-To: <26126961.1164785592715.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF63E3E519C3E2EFAE14E9C62"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [RFC][PATCH 2/2] global CPU affinity control
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF63E3E519C3E2EFAE14E9C62
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> thanks for the patch!
> This looks fine to me. This allows me easily to set the affinity of the=
 xenomai tasks.
>=20
> As far as I understood, I have to specify XNPOD_ALL_CPUS as parameter
> at rt_task_create() to use this feature.

=2E..or an empty mask, both works.

> What about the rtnet internal (kernel) task (created via RTDM)?=20
> Will it use this affinity as well or do I have to "force" rtnet somehow=
 to use the
> "global" xenomai affinity?

Yes, it affects any Xenomai thread that doesn't specify an explicit
mask. And it forces all IRQs that are newly attached to the specified
affinity. You should be able to watch this under
/proc/irq/<n>/smp_affinity. That avoids e.g. that the NIC IRQ pops up on
CPU 0 but has to wake up the stack manager on CPU 1.

Jan


--------------enigF63E3E519C3E2EFAE14E9C62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFbUPVniDOoMHTA+kRAo/qAJ40pDm0kxhTa+92lqBVfIKduauUXQCfSpOS
ql1cBFFe6KRmEa11kQZ9sdI=
=KEaX
-----END PGP SIGNATURE-----

--------------enigF63E3E519C3E2EFAE14E9C62--

