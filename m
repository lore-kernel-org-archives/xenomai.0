Message-ID: <48B5B9FC.2050900@domain.hid>
Date: Wed, 27 Aug 2008 22:33:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid>
	<48B55F7C.5030901@domain.hid>	<48B56685.4060500@domain.hid>
	<48B570AF.4090900@domain.hid>	<48B57281.2090109@domain.hid>
	<48B57626.8070404@domain.hid>	<48B576F2.5010409@domain.hid>
	<48B57BE0.8000701@domain.hid> <48B57D32.60504@domain.hid>
	<48B599DD.6070306@domain.hid> <48B5A4AB.3030909@domain.hid>
In-Reply-To: <48B5A4AB.3030909@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigED6CD39D9B129C5CB27FAA45"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC][PATCH 2/3] Switch to handle-based fast
	mutex owners
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
--------------enigED6CD39D9B129C5CB27FAA45
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
=2E..
>> I think I'm getting closer to the issue. Our actual problem comes from=

>> the fact that the xnsynch_owner is easily out of sync with the real
>> owner, it even sometimes points to a former owner:
>>
>> Thread A releases a mutex on which thread B pends. It wakes up B,
>> causing it to become the new xnsynch owner, and clears the claimed bit=

>> as there are no further sleepers. B returns, and when it wants to
>> release the mutex, it does this happily in user space because claimed =
is
>> not set. Now the fast lock variable is 'unlocked', while xnsynch still=

>> reports B being the owner. This is no problem as the next time two
>> threads fight over this lock the waiter will simply overwrite the
>> xnsynch_owner before it falls asleep. But this "trick" doesn't work fo=
r
>> waiters that have been robbed. They will spin inside xnsynch_sleep_on
>> and stumble over this inconsistency.
>>
>> I have two approaches in mind now: First one is something like
>> XNSYNCH_STEALNOINFORM, i.e. causing xnsynch_sleep_on to not set XNROBB=
ED
>> so that the robbed thread spins one level higher in the skin code -
>> which would have to be extended a bit.
>=20
> No, the stealing is the xnsynch job.
>=20
>> Option two is to clear xnsynch_owner once a new owner is about to retu=
rn
>> from kernel with the lock held while there are no more xnsynch_sleeper=
s.
>> That should work with even less changes and save us one syscall in the=

>> robbed case. Need to think about it more, though.
>=20
> In fact the only time when the owner is required to be in sync is when
> PIP occurs, and this is guaranteed to work, because when PIP is needed =
a
> syscall is emitted anyway. To the extent that xnsynch does not even
> track the owner on non PIP synch (which is why the posix skin originall=
y
>  forcibly set the synch owner, and it was simply kept to get the fastse=
m
> stuff working).
>=20
> Ok. And what about the idea of the xnsynch bit to tell him "hey, the
> owner is tracked in the upper layer, go there to find it".

I'm yet having difficulties to imagine how this should look like when
it's implemented. Would it be simpler than my second idea?

Anyway, here is a patch (on top of my handle-based lock series) for the
approach that clears xnsynch_owner when there are no waiters. At least
it causes no regression based on your test, but I haven't checked lock
stealing yet. In theory, everything still appears to be fine to me. This
approach basically restores the state we find when some thread just
acquired the lock in user space.

Jan

---
 ksrc/skins/posix/mutex.c |   10 +++++++---
 ksrc/skins/posix/mutex.h |   17 +++++++++++------
 2 files changed, 18 insertions(+), 9 deletions(-)

Index: b/ksrc/skins/posix/mutex.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/posix/mutex.c
+++ b/ksrc/skins/posix/mutex.c
@@ -117,7 +117,6 @@ int pse51_mutex_init_internal(struct __s
 	mutex->attr =3D *attr;
 	mutex->owner =3D ownerp;
 	mutex->owningq =3D kq;
-	mutex->sleepers =3D 0;
 	xnarch_atomic_set(ownerp, XN_NO_HANDLE);
=20
 	xnlock_get_irqsave(&nklock, s);
@@ -305,14 +304,12 @@ int pse51_mutex_timedlock_break(struct _
 		/* Attempting to relock a normal mutex, deadlock. */
 		xnlock_get_irqsave(&nklock, s);
 		for (;;) {
-			++mutex->sleepers;
 			if (timed)
 				xnsynch_sleep_on(&mutex->synchbase,
 						 abs_to, XN_REALTIME);
 			else
 				xnsynch_sleep_on(&mutex->synchbase,
 						 XN_INFINITE, XN_RELATIVE);
-			--mutex->sleepers;
=20
 			if (xnthread_test_info(cur, XNBREAK)) {
 				err =3D -EINTR;
@@ -329,6 +326,13 @@ int pse51_mutex_timedlock_break(struct _
 				break;
 			}
 		}
+		if (!xnsynch_nsleepers(&mutex->synchbase)) {
+			xnarch_atomic_set
+				(mutex->owner,
+				 clear_claimed
+					(xnarch_atomic_get(mutex->owner)));
+			xnsynch_set_owner(&mutex->synchbase, NULL);
+		}
 		xnlock_put_irqrestore(&nklock, s);
=20
 		break;
Index: b/ksrc/skins/posix/mutex.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/skins/posix/mutex.h
+++ b/ksrc/skins/posix/mutex.h
@@ -57,7 +57,6 @@ typedef struct pse51_mutex {
=20
 	xnarch_atomic_t *owner;
 	pthread_mutexattr_t attr;
-	unsigned sleepers;
 	pse51_kqueues_t *owningq;
 } pse51_mutex_t;
=20
@@ -172,12 +171,10 @@ static inline int pse51_mutex_timedlock_
 	}
=20
 	xnsynch_set_owner(&mutex->synchbase, owner);
-	++mutex->sleepers;
 	if (timed)
 		xnsynch_sleep_on(&mutex->synchbase, abs_to, XN_REALTIME);
 	else
 		xnsynch_sleep_on(&mutex->synchbase, XN_INFINITE, XN_RELATIVE);
-	--mutex->sleepers;
=20
 	if (xnthread_test_info(cur, XNBREAK)) {
 		err =3D -EINTR;
@@ -192,7 +189,11 @@ static inline int pse51_mutex_timedlock_
 		goto error;
 	}
=20
-	ownerh =3D set_claimed(xnthread_handle(cur), mutex->sleepers);
+	ownerh =3D xnthread_handle(cur);
+	if (xnsynch_nsleepers(&mutex->synchbase))
+		ownerh =3D set_claimed(ownerh, 1);
+	else
+		xnsynch_set_owner(&mutex->synchbase, NULL);
 	xnarch_atomic_set(mutex->owner, ownerh);
 	shadow->lockcnt =3D count;
 	xnlock_put_irqrestore(&nklock, s);
@@ -200,10 +201,12 @@ static inline int pse51_mutex_timedlock_
 	return 0;
=20
   error:
-	if (!mutex->sleepers)
+	if (!xnsynch_nsleepers(&mutex->synchbase)) {
 		xnarch_atomic_set
 			(mutex->owner,
 			 clear_claimed(xnarch_atomic_get(mutex->owner)));
+		xnsynch_set_owner(&mutex->synchbase, NULL);
+	}
 	xnlock_put_irqrestore(&nklock, s);
 	return err;
 }
@@ -221,7 +224,9 @@ static inline void pse51_mutex_unlock_in
=20
 	xnlock_get_irqsave(&nklock, s);
 	owner =3D xnsynch_wakeup_one_sleeper(&mutex->synchbase);
-	ownerh =3D set_claimed(xnthread_handle(owner), mutex->sleepers);
+	ownerh =3D
+	    set_claimed(xnthread_handle(owner),
+			xnsynch_nsleepers(&mutex->synchbase));
 	xnarch_atomic_set(mutex->owner, ownerh);
 	if (owner)
 		xnpod_schedule();


--------------enigED6CD39D9B129C5CB27FAA45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAki1ugYACgkQniDOoMHTA+kHkACggStmiO8JJU4SfyKoU9KuU1HS
/NQAn2apNemLgV6CAb5vubbGf2N4zkhJ
=p8T9
-----END PGP SIGNATURE-----

--------------enigED6CD39D9B129C5CB27FAA45--

