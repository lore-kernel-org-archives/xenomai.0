Message-ID: <467FD25B.1040607@domain.hid>
Date: Mon, 25 Jun 2007 16:34:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <467CD519.1060802@domain.hid>	<1182594345.6000.9.camel@domain.hid>	<467D0684.7030604@domain.hid>	<1182623858.6000.139.camel@domain.hid>	<467E2E9C.90905@domain.hid>	<1182708919.7044.201.camel@domain.hid>	<467F5CBF.9040108@domain.hid>
	<18047.40395.671989.328415@domain.hid>
	<467F9FE5.1070205@domain.hid>
In-Reply-To: <467F9FE5.1070205@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig781F033D8E8BF215587E6BFA"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Monotonic, realtime, and other timers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig781F033D8E8BF215587E6BFA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>  > Ok, I think it's time to summarise some results of this thread:
>>  >=20
>>  >  - xntimers will be of three kinds: real-time absolute, monotonic
>>  >    absolute, and monotonic relative ones (ie. all POSIX). I'm curre=
ntly
>>  >    in favour of passing this property on timer start and not pushin=
g
>>  >    parts or more of it into timer init.
>>
>> The posix skin can live without monotonic absolute timers: monotonic
>> timeout could simply be converted to relative timeouts.
>>
>=20
> The POSIX skin will not be the only user, and I rather see disadvantage=
s
> /wrt the hot-path (multiple timer readouts + conversions) when moving
> over emulation mode again.
>=20
> Anyway, I hope I can come up with some patches over the next days,
> clarifying what we actually need to change (not much I think).

Here is a first draft of a (hopefully final) xntimer_start API change.
Well, it does have some impact on this new interface and its users (but
those will need individual review anyway). So please let me know if you
think I'm on the right track -- before I generate useless changes.

Note: This snippet does not yet address isolated time bases or
re-adjustments of running timers with XNTIMER_REALTIME set. But that
will be straightforward then. Likely...

Jan


Index: xenomai/include/nucleus/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/timer.h
+++ xenomai/include/nucleus/timer.h
@@ -35,7 +35,9 @@
 #define XNTIMER_DEQUEUED  0x00000001
 #define XNTIMER_KILLED    0x00000002
 #define XNTIMER_PERIODIC  0x00000004
-#define XNTIMER_MONOTONIC 0x00000008
+#define XNTIMER_REALTIME  0x00000008
+
+#define XNTIMER_ABSOLUTE  0x00000010 /* only used for timer start */
=20
 /* These flags are available to the real-time interfaces */
 #define XNTIMER_SPARE0  0x01000000
@@ -47,6 +49,14 @@
 #define XNTIMER_SPARE6  0x40000000
 #define XNTIMER_SPARE7  0x80000000
=20
+/* Timer operation modes */
+typedef enum xntimer_mode {
+	XNTM_MONOREL =3D 0,
+	XNTM_MONOABS =3D XNTIMER_ABSOLUTE,
+	XNTM_REALABS =3D XNTIMER_REALTIME | XNTIMER_ABSOLUTE
+} xntimer_mode_t;
+
+/* Timer priorities */
 #define XNTIMER_LOPRIO  (-999999999)
 #define XNTIMER_STDPRIO 0
 #define XNTIMER_HIPRIO  999999999
@@ -284,10 +294,6 @@ typedef struct xntimed_slave {
 #endif /* !CONFIG_SMP */
 #define xntimer_interval(t)	((t)->interval)
 #define xntimer_set_cookie(t,c)	((t)->cookie =3D (c))
-#define xntimer_set_monotonic(t) \
-	__setbits((t)->status, XNTIMER_MONOTONIC)
-#define xntimer_set_realtime(t) \
-	__clrbits((t)->status, XNTIMER_MONOTONIC)
=20
 #ifdef CONFIG_XENO_OPT_TIMING_PERIODIC
 #define xntimer_base(t)		((t)->base)
@@ -409,7 +415,7 @@ static inline void xntimer_set_name(xnti
=20
 static inline int xntimer_start(xntimer_t *timer,
 				xnticks_t value, xnticks_t interval,
-				int mode)
+				xntimer_mode_t mode)
 {
 	return timer->base->ops->start_timer(timer, value, interval, mode);
 }
@@ -590,7 +596,7 @@ void xntslave_stop(xntslave_t *slave);
 int xntimer_start_aperiodic(xntimer_t *timer,
 			    xnticks_t value,
 			    xnticks_t interval,
-			    int mode);
+			    xntimer_mode_t mode);
=20
 void xntimer_stop_aperiodic(xntimer_t *timer);
=20
@@ -604,7 +610,7 @@ xnticks_t xntimer_get_raw_expiry_aperiod
=20
 static inline int xntimer_start(xntimer_t *timer,
 				xnticks_t value, xnticks_t interval,
-				int mode)
+				xntimer_mode_t mode)
 {
 	return xntimer_start_aperiodic(timer, value, interval, mode);
 }
Index: xenomai/include/nucleus/types.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/types.h
+++ xenomai/include/nucleus/types.h
@@ -62,8 +62,6 @@ typedef int (*xniack_t)(unsigned irq);
=20
 #define XN_INFINITE   (0)
 #define XN_NONBLOCK   ((xnticks_t)-1)
-#define XN_RELATIVE   0
-#define XN_ABSOLUTE   1
=20
 #define XN_APERIODIC_TICK  0
 #define XN_NO_TICK         ((xnticks_t)-1)
Index: xenomai/ksrc/nucleus/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/timer.c
+++ xenomai/ksrc/nucleus/timer.c
@@ -91,7 +91,7 @@ static inline void xntimer_next_remote_s
=20
 int xntimer_start_aperiodic(xntimer_t *timer,
 			    xnticks_t value, xnticks_t interval,
-			    int mode)
+			    xntimer_mode_t mode)
 {
 	xnticks_t date, now;
=20
@@ -100,14 +100,20 @@ int xntimer_start_aperiodic(xntimer_t *t
=20
 	now =3D xnarch_get_cpu_tsc();
=20
-	if (mode =3D=3D XN_RELATIVE)
+	switch (mode) {
+	case XNTM_MONOREL:
 		date =3D xnarch_ns_to_tsc(value) + now;
-	else {
-		if (!testbits(timer->status, XNTIMER_MONOTONIC))
-			value -=3D nktbase.wallclock_offset;
+		__clrbits(timer->status, XNTIMER_REALTIME);
+		break;
+	case XNTM_REALABS:
+		value -=3D nktbase.wallclock_offset;
+		/* fall through */
+	default: /* XNTM_MONOABS || XNTM_REALABS */
 		date =3D xnarch_ns_to_tsc(value);
 		if (date <=3D now)
 			return -ETIMEDOUT;
+		__setbits(timer->status, XNTIMER_REALTIME);
+		break;
 	}
=20
 	xntimerh_date(&timer->aplink) =3D date;
@@ -282,18 +288,24 @@ static inline void xntimer_dequeue_perio
=20
 static int xntimer_start_periodic(xntimer_t *timer,
 				  xnticks_t value, xnticks_t interval,
-				  int mode)
+				  xntimer_mode_t mode)
 {
 	if (!testbits(timer->status, XNTIMER_DEQUEUED))
 		xntimer_dequeue_periodic(timer);
=20
-	if (mode =3D=3D XN_RELATIVE)
+	switch (mode) {
+	case XNTM_MONOREL:
 		value +=3D timer->base->jiffies;
-	else {
-		if (!testbits(timer->status, XNTIMER_MONOTONIC))
-			value -=3D timer->base->wallclock_offset;
+		__clrbits(timer->status, XNTIMER_REALTIME);
+		break;
+	case XNTM_REALABS:
+		value -=3D timer->base->wallclock_offset;
+		/* fall through */
+	default: /* XNTM_MONOABS || XNTM_REALABS */
 		if (value <=3D timer->base->jiffies)
 			return -ETIMEDOUT;
+		__setbits(timer->status, XNTIMER_REALTIME);
+		break;
 	}
=20
 	xntlholder_date(&timer->plink) =3D value;
@@ -479,7 +491,7 @@ void xntslave_start(xntslave_t *slave, x
 		/* Spread ticks by timer latency to avoid too much nklock
 		   contention and impose some servicing order. */
 		xntimer_start(&pc->timer, start + cpu * nklatency,
-			      interval, XN_ABSOLUTE);
+			      interval, XNTM_MONOABS);
 		xnlock_put_irqrestore(&nklock, s);
 	}
 }


--------------enig781F033D8E8BF215587E6BFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGf9JbniDOoMHTA+kRAncyAJ9XRG0r6rU62xd9vLVUn3XxeWGqZgCdEhQB
g/B9GT8/QGoGaWAjLTIPh9c=
=U/ql
-----END PGP SIGNATURE-----

--------------enig781F033D8E8BF215587E6BFA--

