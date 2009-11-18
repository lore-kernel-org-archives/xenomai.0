From: Andreas Glatz <AndreasGlatz@domain.hid>
Date: Wed, 18 Nov 2009 09:46:17 -0500
Message-ID: <245373446233674495BCA5CA2FC1EB173017033105@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-core] Patch to prevent loss of initial thread priority
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

We had the problem that one of our threads, which we initially assigned pri=
ority 29, ended up having priority 89.
I know that PI is the reason why the priority of the thread was first bumpe=
d up to 89 and then to 90 because
two higher priority threads started blocking on two different mutexes owned=
 by the thread (initial priority 29).
I expected that the priority would be reset to the initial value (29) after=
 leaving the critical section but that was=20
not the case. The thread seemed to have forgotten its initial priority and =
the priority of the thread just dropped to 89.

After some investigation with lttng, I think, I found the reason for that e=
rratic behaviour (see patch below). the=20
second change of thread priority was done with xnsynch_renice_sleeper(). Th=
e thread already had the XNBOOST
flag set and its initial priority saved to bprio which got overwritten.

Andreas

diff -ruN linux/kernel/xenomai/nucleus/synch.c linux-lttng/kernel/xenomai/n=
ucleus/synch.c
--- linux/kernel/xenomai/nucleus/synch.c    2009-10-30 14:21:34.000000000 -=
0400
+++ linux-lttng/kernel/xenomai/nucleus/synch.c  2009-11-18 09:24:17.0000000=
00 -0500
@@ -323,11 +341,14 @@
            insertpqf(&owner->claimq, &synch->link, thread->cprio);
        } else {
            /* The resource was NOT claimed, claim it now
-            * and boost the owner. */
+            * and boost the owner if it hasn't already=20
+            * been boosted. */
            __setbits(synch->status, XNSYNCH_CLAIMED);
            insertpqf(&owner->claimq, &synch->link, thread->cprio);
-           owner->bprio =3D owner->cprio;
-           xnthread_set_state(owner, XNBOOST);
+           if (!xnthread_test_state(owner, XNBOOST)) {
+               owner->bprio =3D owner->cprio;
+               xnthread_set_state(owner, XNBOOST);
+           }
        }
        /* Renice the owner thread, progressing in the PI
           chain as needed. */=

