Message-ID: <4448EE7D.1020003@domain.hid>
Date: Fri, 21 Apr 2006 16:38:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3D6F98CD53C31B0D79E055E8"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] let ipipe_catch_event return old handler
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3D6F98CD53C31B0D79E055E8
Content-Type: multipart/mixed; boundary="------------060208050001030501070305"

This is a multi-part message in MIME format.
--------------060208050001030501070305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

this patch extends ipipe_catch_event() so that the previously registered
event handler is returned. The usage scenario are event listeners that
hook onto an existing listener for a specific domain, maybe filtering
events or simply overruling the original handler.

Note that this patch effectively removes the error detection from
ipipe_catch_event(), i.e. requests for event >=3D IPIPE_NR_EVENTS will be=

silently ignored now. Regarding Xenomai as Ipipe user, this is a
non-issue as return codes are not checked there and only valid events
are passed.

Jan

--------------060208050001030501070305
Content-Type: text/plain;
 name="catch_event.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="catch_event.patch"

Index: linux-2.6.16.1/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.1.orig/include/linux/ipipe.h
+++ linux-2.6.16.1/include/linux/ipipe.h
@@ -125,9 +125,13 @@
 typedef void (*ipipe_irq_handler_t)(unsigned irq,
 				    void *cookie);
=20
+#define IPIPE_SAME_HANDLER	((ipipe_irq_handler_t)(-1))
+
 typedef int (*ipipe_irq_ackfn_t)(unsigned irq);
=20
-#define IPIPE_SAME_HANDLER	((ipipe_irq_handler_t)(-1))
+typedef int (*ipipe_event_handler_t)(unsigned event,
+				     struct ipipe_domain *from,
+				     void *data);
=20
 struct ipipe_domain {
=20
@@ -150,9 +154,7 @@
 		void *cookie;
 	} ____cacheline_aligned irqs[IPIPE_NR_IRQS];
=20
-	int (*evhand[IPIPE_NR_EVENTS])(unsigned event,
-				       struct ipipe_domain *from,
-				       void *data); /* Event handlers. */
+	ipipe_event_handler_t evhand[IPIPE_NR_EVENTS]; /* Event handlers. */
 	unsigned long long evself;	/* Self-monitored event bits. */
=20
 #ifdef CONFIG_IPIPE_STATS
@@ -711,11 +713,9 @@
 	clear_bit(IPIPE_SPRINTK_FLAG, &ipd->flags);
 }
=20
-int ipipe_catch_event(struct ipipe_domain *ipd,
-		      unsigned event,
-		      int (*handler)(unsigned event,
-				     struct ipipe_domain *ipd,
-				     void *data));
+ipipe_event_handler_t ipipe_catch_event(struct ipipe_domain *ipd,
+					unsigned event,
+					ipipe_event_handler_t handler);
=20
 cpumask_t ipipe_set_irq_affinity(unsigned irq,
 				 cpumask_t cpumask);
Index: linux-2.6.16.1/kernel/ipipe/generic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.1.orig/kernel/ipipe/generic.c
+++ linux-2.6.16.1/kernel/ipipe/generic.c
@@ -266,9 +266,9 @@
  * ipipe_catch_event() -- Interpose or remove an event handler for a
  * given domain.
  */
-int ipipe_catch_event(struct ipipe_domain *ipd,
-		      unsigned event,
-		      int (*handler)(unsigned event, struct ipipe_domain *ipd, void *d=
ata))
+ipipe_event_handler_t ipipe_catch_event(struct ipipe_domain *ipd,
+					unsigned event,
+					ipipe_event_handler_t handler)
 {
 	int self =3D 0;
=20
@@ -278,7 +278,7 @@
 	}
=20
 	if (event >=3D IPIPE_NR_EVENTS)
-		return -EINVAL;
+		return NULL;
=20
 	if (!xchg(&ipd->evhand[event],handler))	{
 		if (handler) {
@@ -301,7 +301,7 @@
 			ipd->evself |=3D (1LL << event);
 	}
=20
-	return 0;
+	return handler;
 }
=20
 cpumask_t ipipe_set_irq_affinity (unsigned irq, cpumask_t cpumask)

--------------060208050001030501070305--

--------------enig3D6F98CD53C31B0D79E055E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESO59niDOoMHTA+kRAt5tAJwM9g70gfK5812i2R3F2R9lcLoUtgCfSXHd
18N2KDEU2NZNxfEMEMY51q4=
=Nt7W
-----END PGP SIGNATURE-----

--------------enig3D6F98CD53C31B0D79E055E8--

