Message-ID: <49B39DB5.8040601@domain.hid>
Date: Sun, 08 Mar 2009 11:28:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig676764E9C82C41FFC52E8AAF"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] xnshadow_relax in taskexit_event
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig676764E9C82C41FFC52E8AAF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

this looks suspicious to me:

static inline void do_taskexit_event(struct task_struct *p)
{
	...
	if (xnpod_shadow_p())
		xnshadow_relax(0);

A) The only call context of this hook is do_exit() - and that's Linux
kernel code which should always run in secondary mode, no?

B) Even if we were called once in a while from primary mode here, too,
the check xnpod_shadow_p() would only tell us that we are a shadow
thread, not in which mode we currently run.

I've tested a removal of this hunk and found no regressions so far. Will
post a patch unless someone can explain why we actually need this (and
why A) and B) are non-issues).

Jan


--------------enig676764E9C82C41FFC52E8AAF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkmznbwACgkQniDOoMHTA+laXgCfZJn+CmLVcflzU2t6Bp3phy+a
EJAAn1qCIKk5dSEmE22fr0tHQD/psX0r
=MY02
-----END PGP SIGNATURE-----

--------------enig676764E9C82C41FFC52E8AAF--

