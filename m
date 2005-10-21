Message-ID: <4358A63B.6030907@domain.hid>
Date: Fri, 21 Oct 2005 10:26:35 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8396D522D1EF43B2D506D0CA"
Subject: [Xenomai-core] [patch] problems with nucleus/types.h
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
--------------enig8396D522D1EF43B2D506D0CA
Content-Type: multipart/mixed; boundary="------------020701070902050108060906"

This is a multi-part message in MIME format.
--------------020701070902050108060906
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

after the latest changes in include/nucleus/types.h, I get some warnings
during userspace lib compilation on my box:

In file included from /usr/src/xenomai/include/nucleus/queue.h:24,
                 from /usr/src/xenomai/include/nucleus/timer.h:24,
                 from /usr/src/xenomai/include/nucleus/thread.h:24,
                 from
/usr/src/xenomai/skins/native/lib/../../native/task.h:27,
                 from /usr/src/xenomai/skins/native/lib/timer.c:21:
/usr/src/xenomai/include/nucleus/types.h: In function
'xnobject_create_name':
/usr/src/xenomai/include/nucleus/types.h:99: warning: implicit
declaration of function 'snprintf'
/usr/src/xenomai/include/nucleus/types.h:99: warning: incompatible
implicit declaration of built-in function 'snprintf'

This is due to the static inline definition of xnobject_create_name in
the mentioned header and missing a snprintf prototype in userspace.

What about the attached patch? It also avoids duplicating code by using
strncpy (or am I overseeing a specific reason for doing it the other way?).

Jan

--------------020701070902050108060906
Content-Type: text/plain;
 name="xnobject-name.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xnobject-name.patch"

Index: include/nucleus/types.h
===================================================================
--- include/nucleus/types.h	(revision 54)
+++ include/nucleus/types.h	(working copy)
@@ -76,26 +76,16 @@
 
 #define XNOBJECT_NAME_LEN 32
 
-static inline void xnobject_copy_name (char *dst,
-				       const char *src)
-{
-    if (src)
-	{
-	const char *rp = src;
-	char *wp = dst;
-	do
-	    *wp++ = *rp;
-	while (*rp && rp++ - src < XNOBJECT_NAME_LEN);
-	}
-    else
-	*dst = '\0';
-}
+#define xnobject_copy_name(dst, src) \
+do { \
+    if (src) \
+        strncpy(dst, src, XNOBJECT_NAME_LEN); \
+    else \
+        *dst = '\0'; \
+} while (0)
 
-static inline int xnobject_create_name(
-		    char *dst, size_t n, void *obj)
-{
-    return snprintf(dst, n, "%p", obj);
-}
+#define xnobject_create_name(dst, n, obj) \
+    snprintf(dst, n, "%p", obj)
 
 #define minval(a,b) ((a) < (b) ? (a) : (b))
 #define maxval(a,b) ((a) > (b) ? (a) : (b))

--------------020701070902050108060906--

--------------enig8396D522D1EF43B2D506D0CA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDWKY7ncNeS9Q0k+IRAvi0AKDGNbW7IJAyfEsXRDtMzk41tA1+XgCg4QEt
A5ufNxzBpv9cfjbfEhbZCus=
=U/YU
-----END PGP SIGNATURE-----

--------------enig8396D522D1EF43B2D506D0CA--

