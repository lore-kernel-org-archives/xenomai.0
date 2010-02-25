Message-ID: <4B867EB5.9090504@domain.hid>
Date: Thu, 25 Feb 2010 14:44:21 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B6E8167.6010907@domain.hid>
	<4B76B7F2.2050303@domain.hid>	<4B76C045.2070602@domain.hid>
	<1266140329.27019.17.camel@domain.hid>
In-Reply-To: <1266140329.27019.17.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig90FC8F801F9E006BE402FB48"
Subject: Re: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig90FC8F801F9E006BE402FB48
Content-Type: multipart/mixed;
 boundary="------------050407060607080303010302"

This is a multi-part message in MIME format.
--------------050407060607080303010302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Am 14.02.2010 10:38, schrieb Philippe Gerum:
> <snip>
> In any case, thanks for your work so far. We probably need to discuss
> the packaging issues on this list, so that we get both consistency and
> usability in the future.
>=20
> Gilles and Roland, if this is fine with you, I'll handle the liaison
> role with upstream packagers, so please CC me explicitly on those mails=
=2E
> We'll sort out this issue, it doesn't look that bad anyway.

udev/xenomai.rules sets the group for realtime devices to "xenomai".
Patch attached to create the group "xenomai" on installation.

Additionally, it would be nice to set "xeno_nucleus.xenomai_gid" to
group "xenomai" too. Is this possible with a udev rule ?

regards
kisda

--------------050407060607080303010302
Content-Type: text/plain;
 name="group-xenomai.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="group-xenomai.patch"

diff --git a/debian/libxenomai1.postinst b/debian/libxenomai1.postinst
index 8afc6fc..97c3476 100644
--- a/debian/libxenomai1.postinst
+++ b/debian/libxenomai1.postinst
@@ -1,6 +1,22 @@
 #!/bin/sh -e
=20
-rm -f /etc/udev/rules.d/xenomai.rules
-ln -sf ../xenomai.rules /etc/udev/rules.d/xenomai.rules
+case "$1" in
+    configure)
+        # Add the xenomai group unless it's already there
+        if ! getent group xenomai >/dev/null; then
+            addgroup --quiet --system xenomai || true
+        fi
+        rm -f /etc/udev/rules.d/xenomai.rules
+        ln -sf ../xenomai.rules /etc/udev/rules.d/xenomai.rules
+    ;;
+
+    abort-upgrade|abort-remove|abort-deconfigure)
+    ;;
+
+    *)
+        echo "postinst called with unknown argument \`$1'" >&2
+        exit 1
+    ;;
+esac
=20
 #DEBHELPER#

--------------050407060607080303010302--

--------------enig90FC8F801F9E006BE402FB48
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLhn61IPTw9rIdn6oRAgN4AJ9yGRmCsUMZFBuDb+aPEu7h60kEiQCdGdAo
rCLkCdNcTfem5gZgyIw/MR4=
=aFyZ
-----END PGP SIGNATURE-----

--------------enig90FC8F801F9E006BE402FB48--

