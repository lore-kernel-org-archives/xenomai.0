Message-ID: <443E99C5.70202@domain.hid>
Date: Thu, 13 Apr 2006 20:34:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEE7E85F38C072CDABBABC243"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] let skins select nucleus features
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
--------------enigEE7E85F38C072CDABBABC243
Content-Type: multipart/mixed; boundary="------------080205020005000003090300"

This is a multi-part message in MIME format.
--------------080205020005000003090300
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

this patch aims at avoiding to select unneeded nucleus features if no
user is requiring it in the skins. Particularly, it addresses the
nucleus registry and the pipes.

I have spent no effort on 2.4 yet as I first want to wait for comments.
Furthermore, 2.4. is lacking "select", so the feature selection has to
remain manually there anyway.

Jan

--------------080205020005000003090300
Content-Type: text/plain;
 name="nucleus-features.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="nucleus-features.patch"

Index: ksrc/nucleus/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/Kconfig	(revision 924)
+++ ksrc/nucleus/Kconfig	(working copy)
@@ -32,15 +32,7 @@ config XENO_OPT_SECURITY_ACCESS
 	think twice before switching this off.
=20
 config XENO_OPT_PIPE
-	bool "Message pipes"
-	default y
-	help
-
-	Message pipes are bi-directional FIFO communication
-	channels allowing data exchange between real-time kernel
-	threads and regular user-space processes. Pipes natively
-	preserve message boundaries, but can also be used in byte
-	streaming mode from kernel to user-space.
+	bool
=20
 config XENO_OPT_PIPE_NRDEV
 	int "Number of pipe devices"
@@ -48,14 +40,23 @@ config XENO_OPT_PIPE_NRDEV
 	default 32
 	help
 =09
+	Message pipes are bi-directional FIFO communication
+	channels allowing data exchange between real-time kernel
+	threads and regular user-space processes. Pipes natively
+	preserve message boundaries, but can also be used in byte
+	streaming mode from kernel to user-space.
+=09
 	This option sets the maximum number of pipe devices supported
 	in the system. Pipe devices are named /dev/rtpN where N is a
 	device minor number ranging from 0 to XENO_OPT_PIPE_NRDEV - 1.
=20
 config XENO_OPT_REGISTRY
 	bool
-	prompt "Registry support" if !XENO_OPT_PERVASIVE
-	default y
+
+config XENO_OPT_REGISTRY_NRSLOTS
+	int "Number of registry slots"
+	depends on XENO_OPT_REGISTRY
+	default 512
 	help
 =09
 	The registry is used by Xenomai skins to bind real-time
@@ -63,12 +64,6 @@ config XENO_OPT_REGISTRY
 	can be further retrieved and shared by real-time applications
 	regardless of their runtime space (i.e. kernel or user). Each
 	named object occupies a registry slot.
-
-config XENO_OPT_REGISTRY_NRSLOTS
-	int "Number of registry slots"
-	depends on XENO_OPT_REGISTRY
-	default 512
-	help
 =09
 	This option sets the maximum number of real-time objects the
 	registry can handle. All skins using the registry share this
Index: ksrc/skins/vrtx/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/vrtx/Kconfig	(revision 924)
+++ ksrc/skins/vrtx/Kconfig	(working copy)
@@ -1,7 +1,7 @@
 config XENO_SKIN_VRTX
 	depends on XENO_OPT_NUCLEUS
 	tristate "VRTX emulator"
-	default n
+	select XENO_OPT_REGISTRY
 	help
=20
 	This API skin emulates Mentor Graphics's VRTX operating
Index: ksrc/skins/vxworks/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/vxworks/Kconfig	(revision 924)
+++ ksrc/skins/vxworks/Kconfig	(working copy)
@@ -1,7 +1,7 @@
 config XENO_SKIN_VXWORKS
 	depends on XENO_OPT_NUCLEUS
 	tristate "VxWorks emulator"
-	default n
+	select XENO_OPT_REGISTRY
 	help
=20
 	This API skin emulates WindRiver's VxWorks operating system.
Index: ksrc/skins/native/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/Kconfig	(revision 924)
+++ ksrc/skins/native/Kconfig	(working copy)
@@ -10,7 +10,7 @@ if XENO_SKIN_NATIVE !=3D n
=20
 config XENO_OPT_NATIVE_PIPE
 	bool "Message pipes"
-	depends on XENO_OPT_PIPE
+	select XENO_OPT_PIPE
 	default y
 	help
 =09
@@ -33,6 +33,18 @@ config XENO_OPT_NATIVE_PIPE_BUFSZ
 	This option sets the memory size available for per-pipe
 	buffering when message pipes are used in byte stream mode.
=20
+config XENO_OPT_NATIVE_REGISTRY
+	bool
+	prompt "Registry support" if !XENO_OPT_PERVASIVE
+	select XENO_OPT_REGISTRY
+	default y
+	help
+=09
+	The registry is used to bind real-time objects to symbolic names,
+	so that these objects can be further retrieved and shared by
+	real-time applications regardless of their runtime space (i.e.
+	kernel or user). Each named object occupies a registry slot.
+
 config XENO_OPT_NATIVE_SEM
 	bool "Counting semaphores"
 	default y


--------------080205020005000003090300--

--------------enigEE7E85F38C072CDABBABC243
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEPpnFniDOoMHTA+kRAoaFAJ4/pWggOmvGFbvqt2cjZjd0uPcbygCfV9h3
g8d/xoKxX45APMR7BQqVmpo=
=TnCm
-----END PGP SIGNATURE-----

--------------enigEE7E85F38C072CDABBABC243--

