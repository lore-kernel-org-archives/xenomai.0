Message-ID: <43988465.1020102@domain.hid>
Date: Thu, 08 Dec 2005 20:07:17 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE41052A4187371B3E5591313"
Subject: [Xenomai-core] [doc-patch] rt_task_create & user stack size
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
--------------enigE41052A4187371B3E5591313
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Please apply this, the statement is no longer valid.

--- ksrc/skins/native/task.c    (revision 243)
+++ ksrc/skins/native/task.c    (working copy)
@@ -117,7 +117,7 @@
  *
  * @param stksize The size of the stack (in bytes) for the new
  * task. If zero is passed, a reasonable pre-defined size will be
- * substituted. This parameter is ignored for user-space tasks.
+ * substituted.
  *
  * @param prio The base priority of the new task. This value must
  * range from [1 .. 99] (inclusive) where 1 is the lowest effective

Jan


--------------enigE41052A4187371B3E5591313
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDmIRlncNeS9Q0k+IRAkQEAKCdZyPiWhU/wRMm97/u8S3XNxEbewCgvTZC
gD2+2/ApUkOekLIbHWaljMY=
=yh4n
-----END PGP SIGNATURE-----

--------------enigE41052A4187371B3E5591313--

