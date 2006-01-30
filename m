Message-ID: <43DE386A.60106@domain.hid>
Date: Mon, 30 Jan 2006 17:01:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
References: <43D21144.8040005@domain.hid>	<b647ffbd0601220010x3cc023an@domain.hid>	<fd6a47a90601220819n3f4cd382t@domain.hid>	<E1F16LA-0001ku-C4@domain.hid>	<43D52BA3.6020005@domain.hid>
	<43DE27E5.3010206@domain.hid> <43DE31B8.3070002@domain.hid>
In-Reply-To: <43DE31B8.3070002@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2FE5F2AD8BB41DA575B90451"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2FE5F2AD8BB41DA575B90451
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>
>>> Gilles Chanteperdrix wrote:
>>>
>>>> Jeroen Van den Keybus wrote:
>>>> > Hello,
>>>> > > > I'm currently not at a level to participate in your
>>>> discussion. Although I'm
>>>> > willing to supply you with stresstests, I would nevertheless like
>>>> to learn
>>>> > more from task migration as this debugging session proceeds. In
>>>> order to do
>>>> > so, please confirm the following statements or indicate where I
>>>> went wrong.
>>>> > I hope others may learn from this as well.
>>>> > > xn_shadow_harden(): This is called whenever a Xenomai thread
>>>> performs a
>>>> > Linux (root domain) system call (notified by Adeos ?).
>>>> xnshadow_harden() is called whenever a thread running in secondary
>>>> mode (that is, running as a regular Linux thread, handled by Linux
>>>> scheduler) is switching to primary mode (where it will run as a Xeno=
mai
>>>> thread, handled by Xenomai scheduler). Migrations occur for some sys=
tem
>>>> calls. More precisely, Xenomai skin system calls tables associates a=

>>>> few
>>>> flags with each system call, and some of these flags cause migration=
 of
>>>> the caller when it issues the system call.
>>>>
>>>> Each Xenomai user-space thread has two contexts, a regular Linux
>>>> thread context, and a Xenomai thread called "shadow" thread. Both
>>>> contexts share the same stack and program counter, so that at any ti=
me,
>>>> at least one of the two contexts is seen as suspended by the schedul=
er
>>>> which handles it.
>>>>
>>>> Before xnshadow_harden is called, the Linux thread is running, and i=
ts
>>>> shadow is seen in suspended state with XNRELAX bit by Xenomai
>>>> scheduler. After xnshadow_harden, the Linux context is seen suspende=
d
>>>> with INTERRUPTIBLE state by Linux scheduler, and its shadow is seen =
as
>>>> running by Xenomai scheduler.
>>>>
>>>> The migrating thread
>>>> > (nRT) is marked INTERRUPTIBLE and run by the Linux kernel
>>>> > wake_up_interruptible_sync() call. Is this thread actually run or
>>>> does it
>>>> > merely put the thread in some Linux to-do list (I assumed the
>>>> first case) ?
>>>>
>>>> Here, I am not sure, but it seems that when calling
>>>> wake_up_interruptible_sync the woken up task is put in the current C=
PU
>>>> runqueue, and this task (i.e. the gatekeeper), will not run until th=
e
>>>> current thread (i.e. the thread running xnshadow_harden) marks
>>>> itself as
>>>> suspended and calls schedule(). Maybe, marking the running thread as=

>>>
>>>
>>>
>>> Depends on CONFIG_PREEMPT. If set, we get a preempt_schedule already
>>> here - and a switch if the prio of the woken up task is higher.
>>>
>>> BTW, an easy way to enforce the current trouble is to remove the "_sy=
nc"
>>> from wake_up_interruptible. As I understand it this _sync is just an
>>> optimisation hint for Linux to avoid needless scheduler runs.
>>>
>>
>> You could not guarantee the following execution sequence doing so
>> either, i.e.
>>
>> 1- current wakes up the gatekeeper
>> 2- current goes sleeping to exit the Linux runqueue in schedule()
>> 3- the gatekeeper resumes the shadow-side of the old current
>>
>> The point is all about making 100% sure that current is going to be
>> unlinked from the Linux runqueue before the gatekeeper processes the
>> resumption request, whatever event the kernel is processing
>> asynchronously in the meantime. This is the reason why, as you already=

>> noticed, preempt_schedule_irq() nicely breaks our toy by stealing the
>> CPU from the hardening thread whilst keeping it linked to the
>> runqueue: upon return from such preemption, the gatekeeper might have
>> run already,  hence the newly hardened thread ends up being seen as
>> runnable by both the Linux and Xeno schedulers. Rainy day indeed.
>>
>> We could rely on giving "current" the highest SCHED_FIFO priority in
>> xnshadow_harden() before waking up the gk, until the gk eventually
>> promotes it to the Xenomai scheduling mode and downgrades this
>> priority back to normal, but we would pay additional latencies induced=

>> by each aborted rescheduling attempt that may occur during the atomic
>> path we want to enforce.
>>
>> The other way is to make sure that no in-kernel preemption of the
>> hardening task could occur after step 1) and until step 2) is
>> performed, given that we cannot currently call schedule() with
>> interrupts or preemption off. I'm on it.
>>
>=20
> Could anyone interested in this issue test the following couple of patc=
hes?
>=20
> atomic-switch-state.patch is to be applied against Adeos-1.1-03/x86 for=

> 2.6.15
> atomic-wakeup-and-schedule.patch is to be applied against Xeno 2.1-rc2
>=20
> Both patches are needed to fix the issue.
>=20
> TIA,
>=20

Looks good. I tried Jeroen's test-case and I was not able to reproduce
the crash anymore. I think it's time for a new ipipe-release. ;)

At this chance: any comments on the panic-freeze extension for the
tracer? I need to rework the Xenomai patch, but the ipipe side should be
ready for merge.

Jan


--------------enig2FE5F2AD8BB41DA575B90451
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD3jhqniDOoMHTA+kRAgvdAJ4xpWQEsZ9U6I9Q7rHN7AM8dn8jiQCeNXKr
rfLo/Diu6WLuLP9LFS/MfRY=
=895n
-----END PGP SIGNATURE-----

--------------enig2FE5F2AD8BB41DA575B90451--

