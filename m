Message-ID: <4E1C302A.8050309@domain.hid>
Date: Tue, 12 Jul 2011 13:29:46 +0200
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
	<4E1C2B44.5060907@domain.hid> <4E1C2B8F.5080700@domain.hid>
	<4E1C2F56.8020103@domain.hid>
In-Reply-To: <4E1C2F56.8020103@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5D589D1C82C72DBE3E4B45DE"
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
--------------enig5D589D1C82C72DBE3E4B45DE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-07-12 13:26, Gilles Chanteperdrix wrote:
> On 07/12/2011 01:10 PM, Jan Kiszka wrote:
>> On 2011-07-12 13:08, Gilles Chanteperdrix wrote:
>>> On 07/12/2011 01:06 PM, Jan Kiszka wrote:
>>>> On 2011-07-12 13:04, Gilles Chanteperdrix wrote:
>>>>> On 07/12/2011 01:00 PM, Jan Kiszka wrote:
>>>>>> On 2011-07-12 12:59, Gilles Chanteperdrix wrote:
>>>>>>> On 07/12/2011 09:22 AM, Jan Kiszka wrote:
>>>>>>>> On 2011-07-12 08:41, Gilles Chanteperdrix wrote:
>>>>>>>>> On 07/11/2011 10:12 PM, Jan Kiszka wrote:
>>>>>>>>>> On 2011-07-11 22:09, Gilles Chanteperdrix wrote:
>>>>>>>>>>> On 07/11/2011 10:06 PM, Jan Kiszka wrote:
>>>>>>>>>>>> On 2011-07-11 22:02, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>> On 07/11/2011 09:59 PM, Jan Kiszka wrote:
>>>>>>>>>>>>>> On 2011-07-11 21:51, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>>>> On 07/11/2011 09:16 PM, Jan Kiszka wrote:
>>>>>>>>>>>>>>>> On 2011-07-11 21:10, Jan Kiszka wrote:
>>>>>>>>>>>>>>>>> On 2011-07-11 20:53, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>>>>>>> On 07/08/2011 06:29 PM, GIT version control wrote:
>>>>>>>>>>>>>>>>>>> @@ -2528,6 +2534,22 @@ static inline void do_taskexit=
_event(struct task_struct *p)
>>>>>>>>>>>>>>>>>>>  	magic =3D xnthread_get_magic(thread);
>>>>>>>>>>>>>>>>>>> =20
>>>>>>>>>>>>>>>>>>>  	xnlock_get_irqsave(&nklock, s);
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +	gksched =3D thread->gksched;
>>>>>>>>>>>>>>>>>>> +	if (gksched) {
>>>>>>>>>>>>>>>>>>> +		xnlock_put_irqrestore(&nklock, s);
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Are we sure irqs are on here? Are you sure that what i=
s needed is not an
>>>>>>>>>>>>>>>>>> xnlock_clear_irqon?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> We are in the context of do_exit. Not only IRQs are on,=
 also preemption.
>>>>>>>>>>>>>>>>> And surely no nklock is held.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Furthermore, I do not understand how we
>>>>>>>>>>>>>>>>>> "synchronize" with the gatekeeper, how is the gatekeep=
er garanteed to
>>>>>>>>>>>>>>>>>> wait for this assignment?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> The gatekeeper holds the gksync token while it's active=
=2E We request it,
>>>>>>>>>>>>>>>>> thus we wait for the gatekeeper to become idle again. W=
hile it is idle,
>>>>>>>>>>>>>>>>> we reset the queued reference - but I just realized tha=
t this may tramp
>>>>>>>>>>>>>>>>> on other tasks' values. I need to add a check that the =
value to be
>>>>>>>>>>>>>>>>> null'ified is actually still ours.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Thinking again, that's actually not a problem: gktarget =
is only needed
>>>>>>>>>>>>>>>> while gksync is zero - but then we won't get hold of it =
anyway and,
>>>>>>>>>>>>>>>> thus, can't cause any damage.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Well, you make it look like it does not work. From what I=
 understand,
>>>>>>>>>>>>>>> what you want is to set gktarget to null if a task being =
hardened is
>>>>>>>>>>>>>>> destroyed. But by waiting for the semaphore, you actually=
 wait for the
>>>>>>>>>>>>>>> harden to be complete, so setting to NULL is useless. Or =
am I missing
>>>>>>>>>>>>>>> something else?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Setting to NULL is probably unneeded but still better than=
 rely on the
>>>>>>>>>>>>>> gatekeeper never waking up spuriously and then dereferenci=
ng a stale
>>>>>>>>>>>>>> pointer.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The key element of this fix is waitng on gksync, thus on t=
he completion
>>>>>>>>>>>>>> of the non-RT part of the hardening. Actually, this part u=
sually fails
>>>>>>>>>>>>>> as the target task received a termination signal at this p=
oint.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Yes, but since you wait on the completion of the hardening,=
 the test
>>>>>>>>>>>>> if (target &&...) in the gatekeeper code will always be tru=
e, because at
>>>>>>>>>>>>> this point the cleanup code will still be waiting for the s=
emaphore.
>>>>>>>>>>>>
>>>>>>>>>>>> Yes, except we will ever wake up the gatekeeper later on wit=
hout an
>>>>>>>>>>>> updated gktarget, ie. spuriously. Better safe than sorry, th=
is is hairy
>>>>>>>>>>>> code anyway (hopefully obsolete one day).
>>>>>>>>>>>
>>>>>>>>>>> The gatekeeper is not woken up by posting the semaphore, the =
gatekeeper
>>>>>>>>>>> is woken up by the thread which is going to be hardened (and =
this thread
>>>>>>>>>>> is the one which waits for the semaphore).
>>>>>>>>>>
>>>>>>>>>> All true. And what is the point?
>>>>>>>>>
>>>>>>>>> The point being, would not something like this patch be suffici=
ent?
>>>>>>>>>
>>>>>>>>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>>>>>>>>> index 01f4200..4742c02 100644
>>>>>>>>> --- a/ksrc/nucleus/shadow.c
>>>>>>>>> +++ b/ksrc/nucleus/shadow.c
>>>>>>>>> @@ -2527,6 +2527,18 @@ static inline void do_taskexit_event(str=
uct
>>>>>>>>> task_struct *p)
>>>>>>>>>  	magic =3D xnthread_get_magic(thread);
>>>>>>>>>
>>>>>>>>>  	xnlock_get_irqsave(&nklock, s);
>>>>>>>>> +	if (xnthread_test_info(thread, XNATOMIC)) {
>>>>>>>>> +		struct xnsched *gksched =3D xnpod_sched_slot(task_cpu(p));
>>>>>>>>
>>>>>>>> That's not reliable, the task might have been migrated by Linux =
in the
>>>>>>>> meantime. We must use the stored gksched.
>>>>>>>>
>>>>>>>>> +		xnlock_put_irqrestore(&nklock, s);
>>>>>>>>> +
>>>>>>>>> +		/* Thread is in flight to primary mode, wait for the
>>>>>>>>> +		   gatekeeper to be done with it. */
>>>>>>>>> +		down(&gksched->gksync);
>>>>>>>>> +		up(&gksched->gksync);
>>>>>>>>> +
>>>>>>>>> +		xnlock_get_irqsave(&nklock, s);
>>>>>>>>> +	}
>>>>>>>>> +
>>>>>>>>>  	/* Prevent wakeup call from xnshadow_unmap(). */
>>>>>>>>>  	xnshadow_thrptd(p) =3D NULL;
>>>>>>>>>  	xnthread_archtcb(thread)->user_task =3D NULL;
>>>>>>>>>
>>>>>>>>
>>>>>>>> Again, setting gktarget to NULL and testing for NULL is simply s=
afer,
>>>>>>>> and I see no gain in skipping that. But if you prefer the
>>>>>>>> micro-optimization, I'll drop it.
>>>>>>>
>>>>>>> Could not we use an info bit instead of adding a pointer?
>>>>>>>
>>>>>>
>>>>>> "That's not reliable, the task might have been migrated by Linux i=
n the
>>>>>> meantime. We must use the stored gksched."
>>>>>
>>>>> I mean add another info bit to mean that the task is queued for wak=
eup
>>>>> by the gatekeeper.
>>>>>
>>>>> XNGKQ, or something.
>>>>
>>>> What additional value does it provide to gksched !=3D NULL? We need =
that
>>>> pointer anyway to identify the gatekeeper that holds a reference.
>>>
>>> No, the scheduler which holds the reference is xnpod_sched_slot(task_=
cpu(p))
>>
>> And that is still not reliable, the task may have been pushed to a
>> different CPU in the meantime.
>=20
> I find all this complicated for a very small corner-case, so, I keep
> looking for a simpler solution. Let us try something else.

It's rather the contrary: this solution is straightforward IMHO.

>=20
> If the thread is woken up for whatever reason before the gatekeeper,
> then we will hit the following "if" in xnshadow_harden, can we set the
> target to NULL at this point if it is the current thread? With a cmpxch=
g
> perhaps?

Gatekeeper and target task aren't synchronized, are they?

Jan


--------------enig5D589D1C82C72DBE3E4B45DE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4cMCoACgkQitSsb3rl5xQd4ACdG6NdzwolXR42W1k3/YLO3R3A
+tsAoM6NGAg3QQtmA2Ye0396oyZWLjd4
=sJw5
-----END PGP SIGNATURE-----

--------------enig5D589D1C82C72DBE3E4B45DE--

