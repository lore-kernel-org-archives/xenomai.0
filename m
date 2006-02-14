Message-ID: <43F1CF9F.6020608@domain.hid>
Date: Tue, 14 Feb 2006 13:39:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] separate queue debugging switch
References: <43F1C095.8030805@domain.hid>
In-Reply-To: <43F1C095.8030805@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig797C5F1E1A30C2BC2C73C683"
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
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig797C5F1E1A30C2BC2C73C683
Content-Type: multipart/mixed; boundary="------------030902040403090508010900"

This is a multi-part message in MIME format.
--------------030902040403090508010900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>=20
> while XENO_OPT_DEBUG is generally a useful switch for tracing potential=

> issues in the core and the skins, it also introduces high latencies via=

> the queue debugging feature (due to checks iterating over whole queues)=
=2E
>=20
> This patch introduces separate control over queue debugging so that you=

> can have debug checks without too dramatic slowdowns.
>=20

And this revision also takes care of 2.4.

Jan

--------------030902040403090508010900
Content-Type: text/plain;
 name="DEBUG_QUEUE-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="DEBUG_QUEUE-v2.patch"

Index: ksrc/nucleus/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/Kconfig	(revision 564)
+++ ksrc/nucleus/Kconfig	(working copy)
@@ -87,6 +87,15 @@
 	Do not switch this option on unless you really know what you
 	are doing.
=20
+config XENO_OPT_DEBUG_QUEUES
+	bool "Queue Debugging support"
+	depends on XENO_OPT_DEBUG
+	help
+=09
+	This option activates debugging checks for all queueing
+	operations of the Xenomai core. It adds even more runtime
+	overhead then CONFIG_XENO_OPT_DEBUG, use with care.
+
 config XENO_OPT_WATCHDOG
 	bool "Watchdog support"
 	default n
Index: ksrc/nucleus/Config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/Config.in	(revision 564)
+++ ksrc/nucleus/Config.in	(working copy)
@@ -18,6 +18,9 @@
 	bool 'Interrupt shield support' CONFIG_XENO_OPT_ISHIELD
 	bool 'Statistics collection' CONFIG_XENO_OPT_STATS
 	bool 'Debug support' CONFIG_XENO_OPT_DEBUG
+	if [ "$CONFIG_XENO_OPT_DEBUG" =3D "y" ]; then
+		bool 'Queue Debugging support' CONFIG_XENO_OPT_DEBUG_QUEUES
+	fi
 	bool 'Watchdog support' CONFIG_XENO_OPT_WATCHDOG
=20
 	bool 'Enable periodic timer support' CONFIG_XENO_OPT_TIMING_PERIODIC
Index: include/nucleus/queue.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/queue.h	(revision 564)
+++ include/nucleus/queue.h	(working copy)
@@ -57,27 +57,27 @@
=20
     xnholder_t head;
     int elems;
-#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_DEBUG) && defined(CON=
FIG_SMP)
+#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_DEBUG_QUEUES) && defi=
ned(CONFIG_SMP)
     xnlock_t lock;
-#endif /* __KERNEL__ && CONFIG_XENO_OPT_DEBUG && CONFIG_SMP */
+#endif /* __KERNEL__ && CONFIG_XENO_OPT_DEBUG_QUEUES && CONFIG_SMP */
=20
 } xnqueue_t;
=20
-#if defined(CONFIG_XENO_OPT_DEBUG) && defined(CONFIG_SMP)
+#if defined(CONFIG_XENO_OPT_DEBUG_QUEUES) && defined(CONFIG_SMP)
 #define DECLARE_XNQUEUE(q) xnqueue_t q =3D { { &(q).head, &(q).head }, 0=
, XNARCH_LOCK_UNLOCKED }
-#else /* !(CONFIG_XENO_OPT_DEBUG && CONFIG_SMP) */
+#else /* !(CONFIG_XENO_OPT_DEBUG_QUEUES && CONFIG_SMP) */
 #define DECLARE_XNQUEUE(q) xnqueue_t q =3D { { &(q).head, &(q).head }, 0=
 }
-#endif /* CONFIG_XENO_OPT_DEBUG && CONFIG_SMP */
+#endif /* CONFIG_XENO_OPT_DEBUG_QUEUES && CONFIG_SMP */
=20
 static inline void initq (xnqueue_t *qslot) {
     inith(&qslot->head);
     qslot->elems =3D 0;
-#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_DEBUG) && defined(CON=
FIG_SMP)
+#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_DEBUG_QUEUES) && defi=
ned(CONFIG_SMP)
     xnlock_init(&qslot->lock);
-#endif /* __KERNEL__ && CONFIG_XENO_OPT_DEBUG && CONFIG_SMP */
+#endif /* __KERNEL__ && CONFIG_XENO_OPT_DEBUG_QUEUES && CONFIG_SMP */
 }
=20
-#ifdef CONFIG_XENO_OPT_DEBUG
+#ifdef CONFIG_XENO_OPT_DEBUG_QUEUES
=20
 #if defined(__KERNEL__) || defined(__XENO_UVM__) || defined(__XENO_SIM__=
)
=20
@@ -172,7 +172,7 @@
    dth(__holder);				\
    --(__qslot)->elems; })
=20
-#else /* !CONFIG_XENO_OPT_DEBUG */
+#else /* !CONFIG_XENO_OPT_DEBUG_QUEUES */
=20
 static inline int insertq (xnqueue_t *qslot,
                            xnholder_t *head,
@@ -206,7 +206,7 @@
     return --qslot->elems;
 }
=20
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#endif /* CONFIG_XENO_OPT_DEBUG_QUEUES */
=20
 static inline xnholder_t *getheadq (xnqueue_t *qslot)
 {

--------------030902040403090508010900--

--------------enig797C5F1E1A30C2BC2C73C683
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8c+fniDOoMHTA+kRAsnrAJ0fKeK9seVScyZybZ6hvZ3PTuyWigCfSP7U
UMqYrwLrsdloVlQBdXwJJKg=
=8eji
-----END PGP SIGNATURE-----

--------------enig797C5F1E1A30C2BC2C73C683--

