Message-ID: <43F08392.3000403@domain.hid>
Date: Mon, 13 Feb 2006 14:03:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEDF37C462A65F5B1A7F85968"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Kconfig inconsistencies
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
--------------enigEDF37C462A65F5B1A7F85968
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

here are some build screw-ups one can create by switching off the wrong
options:

 o CONFIG_XENO_OPT_NATIVE_REGISTRY (but CONFIG_XENO_OPT_PERVASIVE
   remains on): unresolved symbols rt_registry_bind and
   rt_registry_fetch, several warnings due to "#[el]if CONFIG_XENO_..."
   instead of "#[el]if defined(CONFIG_XENO_...)"

 o CONFIG_XENO_OPT_PERVASIVE: xnheap_init_mapped and
   xnheap_destroy_mapped become unresolved

The first issue reminds me of my unanswered question if
(CONFIG_XENO_OPT_PERVASIVE && CONFIG_XENO_SKIN_NATIVE &&
!CONFIG_XENO_OPT_NATIVE_REGISTRY) makes any sense at all (kernel objects
created from user space are looked up via the registry, right?).


I haven't worked out any patch for those issues. Actually, I only wanted
to put this patch forward when stumbling over the other:

--- ksrc/skins/native/Kconfig   (revision 564)
+++ ksrc/skins/native/Kconfig   (working copy)
@@ -127,7 +127,6 @@

 config XENO_OPT_NATIVE_INTR
 	bool "Interrupts"
-	default y
 	help

 	This option provides a simple API to deal with interrupts,

Rationale: the /default/ way of handling IRQs should be via RTDM-based
drivers. Only users who know what they are doing should leave this path
and will have to switch on this feature explicitly. If this view can be
commonly accepted, I will add some lines to the feature's help text as we=
ll.

Jan


--------------enigEDF37C462A65F5B1A7F85968
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8IOSniDOoMHTA+kRAvnFAJ44nC5v/RRcUy3/WbBcWXZyqfYAMACbBO43
yeFAyb+Z34LL1DLGHwB5Kd0=
=jZwj
-----END PGP SIGNATURE-----

--------------enigEDF37C462A65F5B1A7F85968--

