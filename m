Message-ID: <43F1D0D7.7040503@domain.hid>
Date: Tue, 14 Feb 2006 13:45:11 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA29322859660FF5FF5C39C76"
Subject: [Xenomai-core] [PATCH] native registry dependencies
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
--------------enigA29322859660FF5FF5C39C76
Content-Type: multipart/mixed; boundary="------------060107080305030903050309"

This is a multi-part message in MIME format.
--------------060107080305030903050309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I'm sure now that the native registry is mandatory as soon as
CONFIG_XENO_OPT_PERVASIVE is selected. This patch enforces the selection
in such a scenario.

Jan

--------------060107080305030903050309
Content-Type: text/plain;
 name="registry_dep.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="registry_dep.patch"

Index: ksrc/skins/native/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/Kconfig	(revision 564)
+++ ksrc/skins/native/Kconfig	(working copy)
@@ -9,7 +9,8 @@
 if XENO_SKIN_NATIVE !=3D n
=20
 config XENO_OPT_NATIVE_REGISTRY
-	bool "Registry support"
+	bool
+	prompt "Registry support" if !XENO_OPT_PERVASIVE
 	default y
 	help
 =09
Index: ksrc/skins/native/Config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/Config.in	(revision 564)
+++ ksrc/skins/native/Config.in	(working copy)
@@ -7,8 +7,14 @@
 if [ "$CONFIG_XENO_SKIN_NATIVE" !=3D "n" ]; then
 	mainmenu_option next_comment
 	comment 'Native interface options'
-	bool 'Registry support' CONFIG_XENO_OPT_NATIVE_REGISTRY
-	int 'Number of registry slots' CONFIG_XENO_OPT_NATIVE_REGISTRY_NRSLOTS =
512
+	if [ "$CONFIG_XENO_OPT_PERVASIVE" !=3D "n" ]; then
+		define_bool CONFIG_XENO_OPT_NATIVE_REGISTRY y
+	else
+		bool 'Registry support' CONFIG_XENO_OPT_NATIVE_REGISTRY
+	fi
+	if [ "$CONFIG_XENO_OPT_NATIVE_REGISTRY" !=3D "n" ]; then
+		int 'Number of registry slots' CONFIG_XENO_OPT_NATIVE_REGISTRY_NRSLOTS=
 512
+	fi
 	dep_bool 'Message pipes' CONFIG_XENO_OPT_NATIVE_PIPE $CONFIG_XENO_OPT_P=
IPE
 	if [ "$CONFIG_XENO_OPT_NATIVE_PIPE" !=3D "n" ]; then
 		int 'Bytes in buffer space' CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ 4096

--------------060107080305030903050309--

--------------enigA29322859660FF5FF5C39C76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8dDXncNeS9Q0k+IRAjKKAJ48yb7FDwjvF/01j34BhQSwdVIOZgCgxnoL
XGHsRkEZ0msH89VMoUriFcg=
=sjf4
-----END PGP SIGNATURE-----

--------------enigA29322859660FF5FF5C39C76--

