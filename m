Message-ID: <48B5BA80.40108@domain.hid>
Date: Wed, 27 Aug 2008 22:35:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid>	<48B55F7C.5030901@domain.hid>	<48B56685.4060500@domain.hid>	<48B570AF.4090900@domain.hid>	<48B57281.2090109@domain.hid>	<48B57626.8070404@domain.hid>	<48B576F2.5010409@domain.hid>	<48B57BE0.8000701@domain.hid>	<48B57D32.60504@domain.hid>	<48B599DD.6070306@domain.hid>	<48B5A4AB.3030909@domain.hid>
	<48B5A546.2060703@domain.hid>
In-Reply-To: <48B5A546.2060703@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFA3E5F89A5B7CB8ED6D23316"
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
--------------enigFA3E5F89A5B7CB8ED6D23316
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>>> Jan Kiszka wrote:
>>>>>>>>>>> +	xnarch_atomic_set(mutex->owner,
>>>>>>>>>>> +		 	  set_claimed(xnthread_handle(owner),
>>>>>>>>>>> +				      xnsynch_nsleepers(&mutex->synchbase)));
>>>>>>>>>> Ok. I think you have spotted a bug here. This should be mutex-=
>sleepers
>>>>>>>>>> instead of xnsynch_nsleepers.
>>>>>>>>> BTW, why do you need to track sleepers separately in POSIX? Nat=
ive
>>>>>>>>> doesn't do so, e.g.
>>>>>>>> Because of the "syscall-needed-when-unlocking-stolen-mutex" issu=
e I
>>>>>>>> already explained (sleepers - xnsynch_nsleepers is precisely the=
 count
>>>>>>>> of pending threads which have been awake then robbed the mutex).=

>>>>>>> Hmm, sounds like the new lock owner should better clear the 'clai=
med'
>>>>>>> bit then, not the old one on return from unlock. Or where is the
>>>>>>> pitfall? How does the futex algorithm handle this scenario?
>>>>>> Ok. Please read my explanation again, I have already explained thi=
s in
>>>>>> another mail.
>>>>> I did this, but I'm unable to derive the answer for my question fro=
m it.
>>>>> Let's go through it in more details:
>>>>>
>>>>> When we pass a mutex to a new owner, we set its reference in the fa=
st
>>>>> lock variable + set the claimed bit if there are more waiters. Inst=
ead,
>>>>> I would simple set that bit if there is a new owner. That owner wil=
l
>>>>> then pick up the mutex eventually and clear 'claimed' on exit from =
it
>>>>> lock service (if there are no further waiters then). If the new own=
er is
>>>>> not able to run and we steal the lock, we simple keep the 'claimed'=
 bit
>>>>> as is. On exit from the stolen lock we find it set, thus we are for=
ced
>>>>> to issue a syscall as it should be.
>>>>>
>>>>> OK, what happens if some waiter wants to leave the party while we a=
re
>>>>> holding the stolen lock? Then the sleeper number must be correct - =
that
>>>>> is one pitfall!
>>>>>
>>>>> I will have to dig into this more deeply, considering more cases. B=
ut
>>>>> the additional "sleepers" field remains at least misplaced IMHO.
>>>>> xnsynch_sleepers should better be fixed to respect lock stealing, a=
s
>>>>> lock stealing is an xnsynch property, nothing POSIX-specific.
>>>> Ok. I have read this but did not get what you mean. I will read it a=
gain
>>>>  quietly from home.
>>> I think I'm getting closer to the issue. Our actual problem comes fro=
m
>>> the fact that the xnsynch_owner is easily out of sync with the real
>>> owner, it even sometimes points to a former owner:
>>>
>>> Thread A releases a mutex on which thread B pends. It wakes up B,
>>> causing it to become the new xnsynch owner, and clears the claimed bi=
t
>>> as there are no further sleepers. B returns, and when it wants to
>>> release the mutex, it does this happily in user space because claimed=
 is
>>> not set. Now the fast lock variable is 'unlocked', while xnsynch stil=
l
>>> reports B being the owner. This is no problem as the next time two
>>> threads fight over this lock the waiter will simply overwrite the
>>> xnsynch_owner before it falls asleep. But this "trick" doesn't work f=
or
>>> waiters that have been robbed. They will spin inside xnsynch_sleep_on=

>>> and stumble over this inconsistency.
>>>
>>> I have two approaches in mind now: First one is something like
>>> XNSYNCH_STEALNOINFORM, i.e. causing xnsynch_sleep_on to not set XNROB=
BED
>>> so that the robbed thread spins one level higher in the skin code -
>>> which would have to be extended a bit.
>> No, the stealing is the xnsynch job.
>>
>>> Option two is to clear xnsynch_owner once a new owner is about to ret=
urn
>>> from kernel with the lock held while there are no more xnsynch_sleepe=
rs.
>>> That should work with even less changes and save us one syscall in th=
e
>>> robbed case. Need to think about it more, though.
>> In fact the only time when the owner is required to be in sync is when=

>> PIP occurs, and this is guaranteed to work, because when PIP is needed=
 a
>> syscall is emitted anyway. To the extent that xnsynch does not even
>> track the owner on non PIP synch (which is why the posix skin original=
ly
>>  forcibly set the synch owner, and it was simply kept to get the fasts=
em
>> stuff working).
>>
>> Ok. And what about the idea of the xnsynch bit to tell him "hey, the
>> owner is tracked in the upper layer, go there to find it".
>=20
> By the way, I think we should stop sending mails to our personal
> addresses in addition to the mailing list, because this results in
> mailing list mails being received out of orders, which make the threads=

> hard to follow.

That's common practice on most mailing lists I know of, and I personally
don't want to change this. IMO, it would only make replying more
complicated, and it would bear the risk to drop CCs to non-subscribers.

I think the problem was only temporarily, maybe caused by some weird
interaction of gna.org and the Siemens mailserver (we were too fast for
them). Meanwhile, archives and inboxes should contain all messages.
Gmane, e.g., lists them in the correct order now.

Jan


--------------enigFA3E5F89A5B7CB8ED6D23316
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAki1uoAACgkQniDOoMHTA+k9gQCfc0Gc2NIGLlKFOCTQwLJL/AUL
UpYAnjw7nag8rvTlkVvDEZr6WQp0NshN
=sBz0
-----END PGP SIGNATURE-----

--------------enigFA3E5F89A5B7CB8ED6D23316--

