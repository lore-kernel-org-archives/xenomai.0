Message-ID: <4E1C2B8F.5080700@domain.hid>
Date: Tue, 12 Jul 2011 13:10:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QfDvt-0003TN-G7@domain.hid> <4E1B469A.8000703@domain.hid>
	<4E1B4AC0.80506@domain.hid> <4E1B4C19.2070205@domain.hid>
	<4E1B542B.2010906@domain.hid> <4E1B5638.1050005@domain.hid>
	<4E1B56E0.20109@domain.hid> <4E1B57D1.1070401@domain.hid>
	<4E1B5860.1000309@domain.hid> <4E1B5944.5030408@domain.hid>
	<4E1BEC9F.1020404@domain.hid> <4E1BF619.6010609@domain.hid>
	<4E1C2912.9050605@domain.hid> <4E1C2959.8080004@domain.hid>
	<4E1C2A2D.9090602@domain.hid> <4E1C2AA5.6060208@domain.hid>
	<4E1C2B44.5060907@domain.hid>
In-Reply-To: <4E1C2B44.5060907@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBBAC49324A3B47AC8C170DCD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix race
 between gatekeeper and	thread deletion
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBBAC49324A3B47AC8C170DCD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-07-12 13:08, Gilles Chanteperdrix wrote:
> On 07/12/2011 01:06 PM, Jan Kiszka wrote:
>> On 2011-07-12 13:04, Gilles Chanteperdrix wrote:
>>> On 07/12/2011 01:00 PM, Jan Kiszka wrote:
>>>> On 2011-07-12 12:59, Gilles Chanteperdrix wrote:
>>>>> On 07/12/2011 09:22 AM, Jan Kiszka wrote:
>>>>>> On 2011-07-12 08:41, Gilles Chanteperdrix wrote:
>>>>>>> On 07/11/2011 10:12 PM, Jan Kiszka wrote:
>>>>>>>> On 2011-07-11 22:09, Gilles Chanteperdrix wrote:
>>>>>>>>> On 07/11/2011 10:06 PM, Jan Kiszka wrote:
>>>>>>>>>> On 2011-07-11 22:02, Gilles Chanteperdrix wrote:
>>>>>>>>>>> On 07/11/2011 09:59 PM, Jan Kiszka wrote:
>>>>>>>>>>>> On 2011-07-11 21:51, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>> On 07/11/2011 09:16 PM, Jan Kiszka wrote:
>>>>>>>>>>>>>> On 2011-07-11 21:10, Jan Kiszka wrote:
>>>>>>>>>>>>>>> On 2011-07-11 20:53, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>>>>> On 07/08/2011 06:29 PM, GIT version control wrote:
>>>>>>>>>>>>>>>>> @@ -2528,6 +2534,22 @@ static inline void do_taskexit_e=
vent(struct task_struct *p)
>>>>>>>>>>>>>>>>>  	magic =3D xnthread_get_magic(thread);
>>>>>>>>>>>>>>>>> =20
>>>>>>>>>>>>>>>>>  	xnlock_get_irqsave(&nklock, s);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +	gksched =3D thread->gksched;
>>>>>>>>>>>>>>>>> +	if (gksched) {
>>>>>>>>>>>>>>>>> +		xnlock_put_irqrestore(&nklock, s);
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Are we sure irqs are on here? Are you sure that what is =
needed is not an
>>>>>>>>>>>>>>>> xnlock_clear_irqon?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> We are in the context of do_exit. Not only IRQs are on, a=
lso preemption.
>>>>>>>>>>>>>>> And surely no nklock is held.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Furthermore, I do not understand how we
>>>>>>>>>>>>>>>> "synchronize" with the gatekeeper, how is the gatekeeper=
 garanteed to
>>>>>>>>>>>>>>>> wait for this assignment?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The gatekeeper holds the gksync token while it's active. =
We request it,
>>>>>>>>>>>>>>> thus we wait for the gatekeeper to become idle again. Whi=
le it is idle,
>>>>>>>>>>>>>>> we reset the queued reference - but I just realized that =
this may tramp
>>>>>>>>>>>>>>> on other tasks' values. I need to add a check that the va=
lue to be
>>>>>>>>>>>>>>> null'ified is actually still ours.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thinking again, that's actually not a problem: gktarget is=
 only needed
>>>>>>>>>>>>>> while gksync is zero - but then we won't get hold of it an=
yway and,
>>>>>>>>>>>>>> thus, can't cause any damage.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Well, you make it look like it does not work. From what I u=
nderstand,
>>>>>>>>>>>>> what you want is to set gktarget to null if a task being ha=
rdened is
>>>>>>>>>>>>> destroyed. But by waiting for the semaphore, you actually w=
ait for the
>>>>>>>>>>>>> harden to be complete, so setting to NULL is useless. Or am=
 I missing
>>>>>>>>>>>>> something else?
>>>>>>>>>>>>
>>>>>>>>>>>> Setting to NULL is probably unneeded but still better than r=
ely on the
>>>>>>>>>>>> gatekeeper never waking up spuriously and then dereferencing=
 a stale
>>>>>>>>>>>> pointer.
>>>>>>>>>>>>
>>>>>>>>>>>> The key element of this fix is waitng on gksync, thus on the=
 completion
>>>>>>>>>>>> of the non-RT part of the hardening. Actually, this part usu=
ally fails
>>>>>>>>>>>> as the target task received a termination signal at this poi=
nt.
>>>>>>>>>>>
>>>>>>>>>>> Yes, but since you wait on the completion of the hardening, t=
he test
>>>>>>>>>>> if (target &&...) in the gatekeeper code will always be true,=
 because at
>>>>>>>>>>> this point the cleanup code will still be waiting for the sem=
aphore.
>>>>>>>>>>
>>>>>>>>>> Yes, except we will ever wake up the gatekeeper later on witho=
ut an
>>>>>>>>>> updated gktarget, ie. spuriously. Better safe than sorry, this=
 is hairy
>>>>>>>>>> code anyway (hopefully obsolete one day).
>>>>>>>>>
>>>>>>>>> The gatekeeper is not woken up by posting the semaphore, the ga=
tekeeper
>>>>>>>>> is woken up by the thread which is going to be hardened (and th=
is thread
>>>>>>>>> is the one which waits for the semaphore).
>>>>>>>>
>>>>>>>> All true. And what is the point?
>>>>>>>
>>>>>>> The point being, would not something like this patch be sufficien=
t?
>>>>>>>
>>>>>>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>>>>>>> index 01f4200..4742c02 100644
>>>>>>> --- a/ksrc/nucleus/shadow.c
>>>>>>> +++ b/ksrc/nucleus/shadow.c
>>>>>>> @@ -2527,6 +2527,18 @@ static inline void do_taskexit_event(struc=
t
>>>>>>> task_struct *p)
>>>>>>>  	magic =3D xnthread_get_magic(thread);
>>>>>>>
>>>>>>>  	xnlock_get_irqsave(&nklock, s);
>>>>>>> +	if (xnthread_test_info(thread, XNATOMIC)) {
>>>>>>> +		struct xnsched *gksched =3D xnpod_sched_slot(task_cpu(p));
>>>>>>
>>>>>> That's not reliable, the task might have been migrated by Linux in=
 the
>>>>>> meantime. We must use the stored gksched.
>>>>>>
>>>>>>> +		xnlock_put_irqrestore(&nklock, s);
>>>>>>> +
>>>>>>> +		/* Thread is in flight to primary mode, wait for the
>>>>>>> +		   gatekeeper to be done with it. */
>>>>>>> +		down(&gksched->gksync);
>>>>>>> +		up(&gksched->gksync);
>>>>>>> +
>>>>>>> +		xnlock_get_irqsave(&nklock, s);
>>>>>>> +	}
>>>>>>> +
>>>>>>>  	/* Prevent wakeup call from xnshadow_unmap(). */
>>>>>>>  	xnshadow_thrptd(p) =3D NULL;
>>>>>>>  	xnthread_archtcb(thread)->user_task =3D NULL;
>>>>>>>
>>>>>>
>>>>>> Again, setting gktarget to NULL and testing for NULL is simply saf=
er,
>>>>>> and I see no gain in skipping that. But if you prefer the
>>>>>> micro-optimization, I'll drop it.
>>>>>
>>>>> Could not we use an info bit instead of adding a pointer?
>>>>>
>>>>
>>>> "That's not reliable, the task might have been migrated by Linux in =
the
>>>> meantime. We must use the stored gksched."
>>>
>>> I mean add another info bit to mean that the task is queued for wakeu=
p
>>> by the gatekeeper.
>>>
>>> XNGKQ, or something.
>>
>> What additional value does it provide to gksched !=3D NULL? We need th=
at
>> pointer anyway to identify the gatekeeper that holds a reference.
>=20
> No, the scheduler which holds the reference is xnpod_sched_slot(task_cp=
u(p))

And that is still not reliable, the task may have been pushed to a
different CPU in the meantime.

Jan


--------------enigBBAC49324A3B47AC8C170DCD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4cK48ACgkQitSsb3rl5xSWmwCeLNbv4dJDLUiG3iqEG+TtiCdk
VnMAmwcs4B/9QO3AMq4499Uk8ZQf98Y/
=XUBd
-----END PGP SIGNATURE-----

--------------enigBBAC49324A3B47AC8C170DCD--

