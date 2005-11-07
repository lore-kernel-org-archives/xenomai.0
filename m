Message-ID: <436F80D9.7090503@domain.hid>
Date: Mon, 07 Nov 2005 17:29:13 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig920B257BFF8D8003D5FAAC66"
Subject: [Xenomai-core] [PATCH] fixes, clarifications, cleanups for RTDM
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
--------------enig920B257BFF8D8003D5FAAC66
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

this patch
 o fixes a cleanup-on-error problem with rtdm_task_init
 o moves this call into drvlib (i.e. de-inlines it)
 o gets rid of __u64 and __s64 usages in favour of uint64_t and int64_t
   (for consistent types in both kernel and user space)
 o tries to improve the documentation of rtdm_device.device_name and
   RTDM_EXECUTE_ATOMICALLY and
 o moves EXPORT_SYMBOLs to their related functions

Tested, caused no regressions so far. Please apply.

Jan


--------------enig920B257BFF8D8003D5FAAC66
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDb4DZncNeS9Q0k+IRAkpsAJ43PEs3fuvEFJvN/HLUajiHYnlBuQCdFm/B
yo9gHOOixhOGOpYgCuXIqBw=
=jweG
-----END PGP SIGNATURE-----

--------------enig920B257BFF8D8003D5FAAC66--

