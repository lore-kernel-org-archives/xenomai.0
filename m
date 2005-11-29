Message-ID: <438C40AC.5020800@domain.hid>
Date: Tue, 29 Nov 2005 12:51:08 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig55F8F86B2C49C0221A8B160F"
Subject: [Xenomai-core] NMI-WD dependencies
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
--------------enig55F8F86B2C49C0221A8B160F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

what precisely are the requirements to build Xenomai's NMU watchdog?
Something like

"depends on X86_LOCAL_APIC || X86_VISWS_APIC"?

Please add the correct dependency to the build system to avoid
compilation errors like I just got after switching off the UP_APIC and
forgetting the NMI watchdog.

Jan


--------------enig55F8F86B2C49C0221A8B160F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDjECsncNeS9Q0k+IRAs1VAJ46ryhiVL7EpbITGIVMdEK8n0pPBgCgiVUc
GXFz2TfEEvqr2alRiyr4nks=
=iN63
-----END PGP SIGNATURE-----

--------------enig55F8F86B2C49C0221A8B160F--

