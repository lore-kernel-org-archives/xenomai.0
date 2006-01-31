Message-ID: <43DFBD14.3090809@domain.hid>
Date: Tue, 31 Jan 2006 20:40:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Shared irqs v.6
References: <b647ffbd0601311053s2f9f77c3m@domain.hid>
In-Reply-To: <b647ffbd0601311053s2f9f77c3m@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7F810CE654C824179E94FE0B"
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7F810CE654C824179E94FE0B
Content-Type: multipart/mixed; boundary="------------030104050109080200040605"

This is a multi-part message in MIME format.
--------------030104050109080200040605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> Hi,
>=20
> the previous version contained an ugly bug, namely the misuse of the
> test_and_set/clear_bit interface
> that led to a broken system from time to time.
>=20

And here is a tiny patch to make RTDM shared-IRQ-aware. If you release
another version before a merge, you may include it into your patch.

Note that I struggled a bit with finding the right prefix. I decided to
separate the namespaces of return flags and creation flags - hopefully
in a reasonable manner.

Jan

--------------030104050109080200040605
Content-Type: text/plain;
 name="rtdm_shared_irq.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtdm_shared_irq.patch"

Index: ksrc/skins/rtdm/drvlib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/drvlib.c	(revision 503)
+++ ksrc/skins/rtdm/drvlib.c	(working copy)
@@ -1200,7 +1200,7 @@
  * @param[in,out] irq_handle IRQ handle
  * @param[in] irq_no Line number of the addressed IRQ
  * @param[in] handler Interrupt handler
- * @param[in] flags Currently unused, pass 0
+ * @param[in] flags Registration flags, see @ref RTDM_IRQTYPE_xxx for de=
tails
  * @param[in] device_name Optional device name to show up in real-time I=
RQ
  * lists (not yet implemented)
  * @param[in] arg Pointer to be passed to the interrupt handler on invoc=
ation
Index: include/rtdm/rtdm_driver.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtdm/rtdm_driver.h	(revision 503)
+++ include/rtdm/rtdm_driver.h	(working copy)
@@ -693,6 +693,15 @@
=20
 typedef xnintr_t                    rtdm_irq_t;
=20
+/*!
+ * @anchor RTDM_IRQTYPE_xxx   @name RTDM_IRQTYPE_xxx
+ * Interrupt registrations flags
+ * @{
+ */
+/** Enable IRQ-sharing with other real-time drivers */
+#define RTDM_IRQTYPE_SHARED         XN_ISR_SHARED
+/** @} */
+
 /**
  * Interrupt handler
  *
@@ -702,7 +711,6 @@
  */
 typedef int (*rtdm_irq_handler_t)(rtdm_irq_t *irq_handle);
=20
-
 /*!
  * @anchor RTDM_IRQ_xxx   @name RTDM_IRQ_xxx
  * Return flags of interrupt handlers

--------------030104050109080200040605--

--------------enig7F810CE654C824179E94FE0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD370VniDOoMHTA+kRAuztAJ46yKEoQ8aNlyQrcTef6OhmPCjfcwCfaB5F
yH9nJjnerY3k0f9c5sHffZ0=
=dglc
-----END PGP SIGNATURE-----

--------------enig7F810CE654C824179E94FE0B--

