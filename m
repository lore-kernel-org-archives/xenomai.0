Message-ID: <48AB2E7A.4050606@domain.hid>
Date: Tue, 19 Aug 2008 22:35:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48AAF7DB.1080603@domain.hid> <48AB1B29.4040001@domain.hid>
	<48AB1EE6.8070003@domain.hid> <48AB241D.9000308@domain.hid>
	<48AB2560.5060804@domain.hid> <48AB2948.1060209@domain.hid>
In-Reply-To: <48AB2948.1060209@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA24325B6AA09496966645236"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] Lock stealing is borken
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA24325B6AA09496966645236
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Hi,
>>>>>>
>>>>>> bad news, everyone :(. According to the result of some lengthy deb=
ug
>>>>>> session with a customer and several ad-hoc lttng instrumentations,=
 we
>>>>>> have a fatal bug in the nucleus' implementation of the lock steali=
ng
>>>>>> algorithm. Consider this scenario:
>>>>>>
>>>>>> 1. Thread A acquires Mutex X successfully, ie. it leaves the (in t=
his
>>>>>>    case) rt_mutex_acquire service, and its XNWAKEN flag is therefo=
re
>>>>>>    cleared.
>>>>>>
>>>>>> 2. Thread A blocks on some further Mutex Y (in our case it was a
>>>>>>    semaphore, but that doesn't matter).
>>>>>>
>>>>>> 3. Thread B signals the availability of Mutex Y to Thread A, thus =
it
>>>>>>    also set XNWAKEN in Thread A. But Thread A is not yet scheduled=
 on
>>>>>>    its CPU.
>>>>>>
>>>>>> 4. Thread C tries to acquire Mutex X, finds it assigned to Thread =
A, but
>>>>>>    also notices that the XNWAKEN flag of Thread A is set. Thus it =
steals
>>>>>>    the mutex although Thread A already entered the critical sectio=
n -
>>>>>>    and hell breaks loose...
>>>>>>
>>>>> See commit #3795, and change log entry from 2008-05-15. Unless I mi=
sunderstood
>>>>> your description, this bug was fixed in 2.4.4.
>>>> Oh, fatally missed that fix.
>>>>
>>>> Anyway, the patch looks a bit unclean to me. Either you are lacking
>>>> wwake =3D NULL in xnpod_suspend_thread, or the whole information enc=
oded
>>>> in XNWAKEN can already be covered by wwake directly.
>>>>
>>> Clearing wwake has to be done when returning from xnsynch_sleep_on, o=
nly when
>>> the code knows that ownership is eventually granted to the caller; ma=
king such a
>>> decision in xnpod_suspend_thread() would be wrong.
>> What about
>>
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#1=
411
>>
>> then?
>>
>=20
> That portion of code applies _before_ the thread enters suspended state=
=2E We
> bother for the other side, i.e. when it resumes from actual suspension,=
 until it
> has been decided whether it should be allowed to keep running, or redo =
the wait
> due to the resource being stolen away.

Then clearing XNWAKEN here is useless - it comes for free, but it has no
practical effect. For code clarity reasons, this should be remove IMHO.

>=20
>>> The awake bit has been kept mainly because the nucleus commonly uses =
bitmasks to
>>> get fast access to thread status & information. It's not mandatory to=
 have this
>>> one in, it's just conforming to the rest of the implementation.
>> I see, but redundancy come with some ugliness as well. And we add more=

>> code to hot paths.
>>
>=20
> The hot path barely involves facing a stolen resource situation. Most o=
f the
> time, the XNWAKEN test will be false, or this would mean that the appli=
cation
> exhibits a high priority thread that routinely and frequently competes =
with a
> low priority one for gaining access to such resource. I would rather fi=
x the
> latter code first.

Besides that the lock-stealing path (with two instead of only one
conditional jumps) is relevant for the WCET in some cases (but that is
nitpicking), I was more referring to setting the bit + setting wwake in
the wakeup paths.

>=20
> Regarding the perceived ugliness, I guess this is a matter of taste her=
e. I like
> the idea of always testing a given information the same way, like:
>=20
> if (test_bits(thread, foobar))
>=20
> and avoid things like:
>=20
> if (test_bits(thread, foo) || thread->field =3D=3D bar)

The latter is what we see now with XNWAKEN (while plain "thread->field
=3D=3D bar" would be possible in this case). We don't gain anything here =
by
using a bit (no combined tests with other bits e.g.).

Jan

---
 include/nucleus/thread.h |    1 -
 ksrc/nucleus/pod.c       |    2 +-
 ksrc/nucleus/synch.c     |    5 +----
 3 files changed, 2 insertions(+), 6 deletions(-)

Index: b/include/nucleus/thread.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/nucleus/thread.h
+++ b/include/nucleus/thread.h
@@ -112,7 +112,6 @@
 #define XNRMID    0x00000002 /**< Pending on a removed resource */
 #define XNBREAK   0x00000004 /**< Forcibly awaken from a wait state */
 #define XNKICKED  0x00000008 /**< Kicked upon Linux signal (shadow only)=
 */
-#define XNWAKEN   0x00000010 /**< Thread waken up upon resource availabi=
lity */
 #define XNROBBED  0x00000020 /**< Robbed from resource ownership */
 #define XNATOMIC  0x00000040 /**< In atomic switch from secondary to pri=
mary mode */
 #define XNAFFSET  0x00000080 /**< CPU affinity changed from primary mode=
 */
Index: b/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -1406,7 +1406,7 @@ void xnpod_suspend_thread(xnthread_t *th
 		}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
=20
-		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK | XNWAKEN | XNR=
OBBED);
+		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK | XNROBBED);
 	}
=20
 	/* Don't start the timer for a thread indefinitely delayed by
Index: b/ksrc/nucleus/synch.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ksrc/nucleus/synch.c
+++ b/ksrc/nucleus/synch.c
@@ -199,7 +199,7 @@ redo:
 	}
=20
 	if (thread->cprio > owner->cprio) {
-		if (xnthread_test_info(owner, XNWAKEN) && owner->wwake =3D=3D synch) {=

+		if (owner->wwake =3D=3D synch) {
 			/* Ownership is still pending, steal the resource. */
 			synch->owner =3D thread;
 			xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK);
@@ -243,7 +243,6 @@ redo:
       unlock_and_exit:
=20
 	thread->wwake =3D NULL;
-	xnthread_clear_info(thread, XNWAKEN);
=20
 	xnlock_put_irqrestore(&nklock, s);
 }
@@ -389,7 +388,6 @@ xnthread_t *xnsynch_wakeup_one_sleeper(x
 		thread->wchan =3D NULL;
 		thread->wwake =3D synch;
 		synch->owner =3D thread;
-		xnthread_set_info(thread, XNWAKEN);
 		trace_mark(xn_nucleus_synch_wakeup_one,
 			   "thread %p thread_name %s synch %p",
 			   thread, xnthread_name(thread), synch);
@@ -503,7 +501,6 @@ xnpholder_t *xnsynch_wakeup_this_sleeper
 	thread->wchan =3D NULL;
 	thread->wwake =3D synch;
 	synch->owner =3D thread;
-	xnthread_set_info(thread, XNWAKEN);
 	trace_mark(xn_nucleus_synch_wakeup_all,
 		   "thread %p thread_name %s synch %p",
 		   thread, xnthread_name(thread), synch);


--------------enigA24325B6AA09496966645236
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkirLoEACgkQniDOoMHTA+mTtgCaAhk6/bT3eaPucp+7LYS4doNT
1HEAnR9AgFBKXXsgOUUFM0/YTlEScTMk
=V49D
-----END PGP SIGNATURE-----

--------------enigA24325B6AA09496966645236--

