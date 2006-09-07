Message-ID: <45003003.7070507@domain.hid>
Date: Thu, 07 Sep 2006 16:43:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCF07C7BEDE616139DB62B380"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH] optimise wakeup order in xnsynch_flush
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
--------------enigCF07C7BEDE616139DB62B380
Content-Type: multipart/mixed; boundary="------------090706080807020404040503"

This is a multi-part message in MIME format.
--------------090706080807020404040503
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

this is so far a mind experiment combined with an untested patch:

[Assuming priority lists, the following is irrelevant for O(1) sched-queu=
es]

Consider we have some bulk of threads with varying priorities waiting on
a xnsynch object. Typically, they are queued in priority order, the
highest prio thread at the head. When we wake them up all at once via
xnsynch_flush, we iterate from high to low prio threads.

Waking up includes inserting those threads in the ready queue(s), again
the highest prio thread first. On wake up of the first waiting thread we
will only have to skip those threads in the ready queue that have higher
priorities. For the second thread we already have to skip the first one
as well on insert if it isn't of the same priority. One may continue
this workflow...

Suggestion: Wouldn't it be more efficient to iterate the waiter queue in
ascending order? Should come at no costs and save a few cycles once in a
while.

Jan

--------------090706080807020404040503
Content-Type: text/plain;
 name="reverse-xnsynch_flush.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="reverse-xnsynch_flush.patch"

Index: include/nucleus/queue.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/queue.h	(revision 1561)
+++ include/nucleus/queue.h	(working copy)
@@ -242,6 +242,19 @@ static inline xnholder_t *popq (xnqueue_
     return nextholder;
 }
=20
+static inline xnholder_t *lastq (xnqueue_t *qslot)
+{
+    xnholder_t *holder =3D qslot->head.last;
+    return holder =3D=3D &qslot->head ? NULL : holder;
+}
+
+static inline xnholder_t *getlastq (xnqueue_t *qslot)
+{
+    xnholder_t *holder =3D lastq(qslot);
+    if (holder) removeq(qslot,holder);
+    return holder;
+}
+
 static inline int countq (xnqueue_t *qslot)
 {
     return qslot->elems;
@@ -437,6 +450,11 @@ static inline xnpholder_t *poppq (xnpque
     return (xnpholder_t *)popq(&pqslot->pqueue,&holder->plink);
 }
=20
+static inline xnpholder_t *getlastpq (xnpqueue_t *pqslot)
+{
+    return (xnpholder_t *)getlastq(&pqslot->pqueue);
+}
+
 static inline int countpq (xnpqueue_t *pqslot)
 {
     return countq(&pqslot->pqueue);
Index: ksrc/nucleus/synch.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/synch.c	(revision 1561)
+++ ksrc/nucleus/synch.c	(working copy)
@@ -525,7 +525,7 @@ int xnsynch_flush(xnsynch_t *synch, xnfl
=20
 	status =3D emptypq_p(&synch->pendq) ? XNSYNCH_DONE : XNSYNCH_RESCHED;
=20
-	while ((holder =3D getpq(&synch->pendq)) !=3D NULL) {
+	while ((holder =3D getlastpq(&synch->pendq)) !=3D NULL) {
 		xnthread_t *sleeper =3D link2thread(holder, plink);
 		__setbits(sleeper->status, reason);
 		sleeper->wchan =3D NULL;

--------------090706080807020404040503--

--------------enigCF07C7BEDE616139DB62B380
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFADADniDOoMHTA+kRAgihAJ9q3jNNe6d8gDmqXTtmcJmLvSv9ywCdEQ1G
MAIA9d84SECSFe6l9wg/C9U=
=g5RB
-----END PGP SIGNATURE-----

--------------enigCF07C7BEDE616139DB62B380--

