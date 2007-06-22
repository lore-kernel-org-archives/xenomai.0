Message-ID: <467BB833.1030401@domain.hid>
Date: Fri, 22 Jun 2007 13:53:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46782305.4080501@domain.hid>	
	<b647ffbd0706201404r256038b7sbb9318cdc1746b7c@domain.hid>	
	<4679A302.2060403@domain.hid>	
	<b647ffbd0706210103q186c00d7wdb861759ff5c0d78@domain.hid>	
	<467A42F6.8080706@domain.hid>	
	<b647ffbd0706210252o1074fa6aof00e82b5ba5a2509@domain.hid>	
	<467A7593.4040402@domain.hid>
	<b647ffbd0706210614ib24568bq6f5bc149c2bbc423@domain.hid>
	<467A7FCA.40708@domain.hid>
In-Reply-To: <467A7FCA.40708@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig77E431FC389964AA9490A1D6"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC][PATCH] shirq locking rework
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
--------------enig77E431FC389964AA9490A1D6
Content-Type: multipart/mixed;
 boundary="------------000802080007060309030304"

This is a multi-part message in MIME format.
--------------000802080007060309030304
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Dmitry Adamushko wrote:
>> On 21/06/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>> [ .. ]
>>>> surprise-surprise.. sure, one way or another it must be fixed. heh..=

>>>> too many bugs (and I don't even want to say who's responsible) :-/
>>> I wouldn't accept all the responsibility if I were you.
>> I have no problems in this respect. I was just a bit sarcastic with
>> the way to say "it's my fault".
>>
>>
>>> It's a sign that the design might be
>>> too complex now
>> frankly speaking, I don't think it's really complex :)
>>
>>
>>> Things get worse, at least with XENO_OPT_STATS: Due to the runtime
>>> statistics collection, we may end up with dangling references to our
>>> xnintr object even after xnintr_shirq_unlock().
>>>
>>> We would actually need some kind of IRQ_INPROGRESS + synchronize_irq(=
)
>>> at i-pipe level. But we have the problem, in contrast to the kernel,
>>> that we reschedule from inside the handler (more precisely: at nucleu=
s
>>> level), thus synchronize_irq() would not just wait on some simple
>>> handler to exit...
>> Yeah.. we had already conversations on this topic (I think with
>> Philippe) and, if I recall right, that was one of the reasons. That's
>> why synchronize_irq() is in the nucleus layer.
>=20
> Hmm, then we may be forced to get the cookie out of ipipe's hands again=

> and put it back into a nucleus irq array, i.e. move the cookie
> dereferencing under a nucleus managed per-irq lock. But there is still
> the issue with xnsched_t::current_account...
>=20

Hell, what a mess...

Here is a first attempt to address the remaining issues. Take it with a
huge grain of salt, I haven't yet made up my mind if it really solves
our races and if it isn't too ugly.

Please direct special attention to

 - xnintr_sync_stat_references (the comment says it all)

 - xnintr_edge_shirq_handler (unrelated change, but I somehow felt like
   this is nicer)

Only compile-tested under various .configs. Any comment welcome.

Thanks,
Jan

--------------000802080007060309030304
Content-Type: text/plain;
 name="fix-intr-locking-part-ii.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-intr-locking-part-ii.patch"

Index: xenomai/ksrc/nucleus/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/intr.c
+++ xenomai/ksrc/nucleus/intr.c
@@ -41,6 +41,18 @@
=20
 DEFINE_PRIVATE_XNLOCK(intrlock);
=20
+typedef struct xnintr_irq {
+
+	DECLARE_XNLOCK(lock);
+
+#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIR=
Q_EDGE)
+	xnintr_t *handlers;
+	int unhandled;
+#endif
+} ____cacheline_aligned_in_smp xnintr_irq_t;
+
+static xnintr_irq_t xnirqs[RTHAL_NR_IRQS];
+
 #ifdef CONFIG_XENO_OPT_STATS
 xnintr_t nkclock;	/* Only for statistics */
 int xnintr_count =3D 1;	/* Number of attached xnintr objects + nkclock *=
/
@@ -63,9 +75,23 @@ static inline void xnintr_stat_counter_d
 	xnarch_memory_barrier();
 	xnintr_list_rev++;
 }
+
+static inline void xnintr_sync_stat_references(xnintr_t *intr)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		xnsched_t *sched =3D xnpod_sched_slot(cpu);
+
+		/* I don't feel very well... hacking this. */
+		while (sched->current_account =3D=3D &intr->stat[cpu].account)
+			cpu_relax();
+	}
+}
 #else
 static inline void xnintr_stat_counter_inc(void) {}
 static inline void xnintr_stat_counter_dec(void) {}
+static inline void xnintr_sync_stat_references(xnintr_t *intr) {}
 #endif /* CONFIG_XENO_OPT_STATS */
=20
 /*
@@ -76,7 +102,7 @@ static inline void xnintr_stat_counter_d
 static void xnintr_irq_handler(unsigned irq, void *cookie)
 {
 	xnsched_t *sched =3D xnpod_current_sched();
-	xnintr_t *intr =3D (xnintr_t *)cookie;
+	xnintr_t *intr;
 	xnstat_runtime_t *prev;
 	xnticks_t start;
 	int s;
@@ -86,6 +112,16 @@ static void xnintr_irq_handler(unsigned=20
 	xnltt_log_event(xeno_ev_ienter, irq);
=20
 	++sched->inesting;
+
+	xnlock_get(&xnirqs[irq].lock);
+
+#ifdef CONFIG_SMP
+	/* In SMP case, we have to reload the cookie under the per-IRQ lock
+	   to avoid racing with xnintr_detach. */
+	intr =3D rthal_irq_cookie(&rthal_domain, irq);
+#else
+	intr =3D cookie;
+#endif
 	s =3D intr->isr(intr);
=20
 	if (unlikely(s =3D=3D XN_ISR_NONE)) {
@@ -102,6 +138,8 @@ static void xnintr_irq_handler(unsigned=20
 		intr->unhandled =3D 0;
 	}
=20
+	xnlock_put(&xnirqs[irq].lock);
+
 	if (s & XN_ISR_PROPAGATE)
 		xnarch_chain_irq(irq);
 	else if (!(s & XN_ISR_NOENABLE))
@@ -161,18 +199,6 @@ void xnintr_clock_handler(void)
=20
 #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIR=
Q_EDGE)
=20
-typedef struct xnintr_shirq {
-
-	xnintr_t *handlers;
-	int unhandled;
-#ifdef CONFIG_SMP
-	xnlock_t lock;
-#endif
-
-} xnintr_shirq_t;
-
-static xnintr_shirq_t xnshirqs[RTHAL_NR_IRQS];
-
 #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL)
 /*
  * Low-level interrupt handler dispatching the user-defined ISRs for
@@ -184,7 +210,7 @@ static void xnintr_shirq_handler(unsigne
 	xnsched_t *sched =3D xnpod_current_sched();
 	xnstat_runtime_t *prev;
 	xnticks_t start;
-	xnintr_shirq_t *shirq =3D &xnshirqs[irq];
+	xnintr_irq_t *shirq =3D &xnirqs[irq];
 	xnintr_t *intr;
 	int s =3D 0;
=20
@@ -253,7 +279,7 @@ static void xnintr_edge_shirq_handler(un
 	xnsched_t *sched =3D xnpod_current_sched();
 	xnstat_runtime_t *prev;
 	xnticks_t start;
-	xnintr_shirq_t *shirq =3D &xnshirqs[irq];
+	xnintr_irq_t *shirq =3D &xnirqs[irq];
 	xnintr_t *intr, *end =3D NULL;
 	int s =3D 0, counter =3D 0;
=20
@@ -277,15 +303,15 @@ static void xnintr_edge_shirq_handler(un
 		s |=3D ret;
=20
 		if (code =3D=3D XN_ISR_HANDLED) {
-			end =3D NULL;
+			if (!(end =3D (intr->next)))
+				end =3D shirq->handlers;
 			xnstat_counter_inc(
 				&intr->stat[xnsched_cpu(sched)].hits);
 			xnstat_runtime_lazy_switch(sched,
 				&intr->stat[xnsched_cpu(sched)].account,
 				start);
 			start =3D xnstat_runtime_now();
-		} else if (code =3D=3D XN_ISR_NONE && end =3D=3D NULL)
-			end =3D intr;
+		}
=20
 		if (counter++ > MAX_EDGEIRQ_COUNTER)
 			break;
@@ -326,7 +352,7 @@ static void xnintr_edge_shirq_handler(un
=20
 static inline int xnintr_irq_attach(xnintr_t *intr)
 {
-	xnintr_shirq_t *shirq =3D &xnshirqs[intr->irq];
+	xnintr_irq_t *shirq =3D &xnirqs[intr->irq];
 	xnintr_t *prev, **p =3D &shirq->handlers;
 	int err;
=20
@@ -379,17 +405,16 @@ static inline int xnintr_irq_attach(xnin
=20
 	intr->next =3D NULL;
=20
-	/* Add a given interrupt object. */
-	xnlock_get(&shirq->lock);
+	/* Add the given interrupt object. No need to synchronise with the IRQ
+	   handler, we are only extending the chain. */
 	*p =3D intr;
-	xnlock_put(&shirq->lock);
=20
 	return 0;
 }
=20
 static inline int xnintr_irq_detach(xnintr_t *intr)
 {
-	xnintr_shirq_t *shirq =3D &xnshirqs[intr->irq];
+	xnintr_irq_t *shirq =3D &xnirqs[intr->irq];
 	xnintr_t *e, **p =3D &shirq->handlers;
 	int err =3D 0;
=20
@@ -406,6 +431,7 @@ static inline int xnintr_irq_detach(xnin
 			/* Remove the given interrupt object from the list. */
 			xnlock_get(&shirq->lock);
 			*p =3D e->next;
+			xnintr_sync_stat_references(intr);
 			xnlock_put(&shirq->lock);
=20
 			/* Release the IRQ line if this was the last user */
@@ -422,14 +448,6 @@ static inline int xnintr_irq_detach(xnin
 	return err;
 }
=20
-int xnintr_mount(void)
-{
-	int i;
-	for (i =3D 0; i < RTHAL_NR_IRQS; ++i)
-		xnlock_init(&xnshirqs[i].lock);
-	return 0;
-}
-
 #else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
=20
 static inline int xnintr_irq_attach(xnintr_t *intr)
@@ -439,13 +457,29 @@ static inline int xnintr_irq_attach(xnin
=20
 static inline int xnintr_irq_detach(xnintr_t *intr)
 {
-	return xnarch_release_irq(intr->irq);
-}
+	int irq =3D intr->irq;
+	int err;
+
+	xnlock_get(&xnirqs[irq].lock);
=20
-int xnintr_mount(void) { return 0; }
+	err =3D xnarch_release_irq(intr->irq);
+	xnintr_sync_stat_references(intr);
+
+	xnlock_put(&xnirqs[irq].lock);
+
+	return err;
+}
=20
 #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
=20
+int xnintr_mount(void)
+{
+	int i;
+	for (i =3D 0; i < RTHAL_NR_IRQS; ++i)
+		xnlock_init(&xnirqs[i].lock);
+	return 0;
+}
+
 /*!
  * \fn int xnintr_init (xnintr_t *intr,const char *name,unsigned irq,xni=
sr_t isr,xniack_t iack,xnflags_t flags)
  * \brief Initialize an interrupt object.
@@ -809,7 +843,7 @@ int xnintr_irq_proc(unsigned int irq, ch
 	xnlock_get_irqsave(&intrlock, s);
=20
 #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIR=
Q_EDGE)
-	intr =3D xnshirqs[irq].handlers;
+	intr =3D xnirqs[irq].handlers;
 	if (intr) {
 		strcpy(p, "        "); p +=3D 8;
=20
@@ -862,7 +896,7 @@ int xnintr_query(int irq, int *cpu, xnin
 	else if (irq =3D=3D XNARCH_TIMER_IRQ)
 		intr =3D &nkclock;
 	else
-		intr =3D xnshirqs[irq].handlers;
+		intr =3D xnirqs[irq].handlers;
 #else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
 	if (*prev)
 		intr =3D NULL;

--------------000802080007060309030304--

--------------enig77E431FC389964AA9490A1D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGe7gzniDOoMHTA+kRAqv+AKCAFDCDLSQxF/K+bPpnFWE7GLI59wCdHbZD
7Z3KznO7MxS8vDudChwJ7rQ=
=MjgV
-----END PGP SIGNATURE-----

--------------enig77E431FC389964AA9490A1D6--

