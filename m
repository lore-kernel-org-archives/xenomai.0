Message-ID: <48B599DD.6070306@domain.hid>
Date: Wed, 27 Aug 2008 20:15:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid>
	<48B55F7C.5030901@domain.hid>	<48B56685.4060500@domain.hid>
	<48B570AF.4090900@domain.hid>	<48B57281.2090109@domain.hid>
	<48B57626.8070404@domain.hid>	<48B576F2.5010409@domain.hid>
	<48B57BE0.8000701@domain.hid> <48B57D32.60504@domain.hid>
In-Reply-To: <48B57D32.60504@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2BAE1349B382C6C5BB2228CC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC][PATCH 2/3] Switch to handle-based
 fast	mutex owners
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
--------------enig2BAE1349B382C6C5BB2228CC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>>>> +	xnarch_atomic_set(mutex->owner,
>>>>>>>> +		 	  set_claimed(xnthread_handle(owner),
>>>>>>>> +				      xnsynch_nsleepers(&mutex->synchbase)));
>>>>>>> Ok. I think you have spotted a bug here. This should be mutex->sl=
eepers
>>>>>>> instead of xnsynch_nsleepers.
>>>>>> BTW, why do you need to track sleepers separately in POSIX? Native=

>>>>>> doesn't do so, e.g.
>>>>> Because of the "syscall-needed-when-unlocking-stolen-mutex" issue I=

>>>>> already explained (sleepers - xnsynch_nsleepers is precisely the co=
unt
>>>>> of pending threads which have been awake then robbed the mutex).
>>>> Hmm, sounds like the new lock owner should better clear the 'claimed=
'
>>>> bit then, not the old one on return from unlock. Or where is the
>>>> pitfall? How does the futex algorithm handle this scenario?
>>> Ok. Please read my explanation again, I have already explained this i=
n
>>> another mail.
>> I did this, but I'm unable to derive the answer for my question from i=
t.
>> Let's go through it in more details:
>>
>> When we pass a mutex to a new owner, we set its reference in the fast
>> lock variable + set the claimed bit if there are more waiters. Instead=
,
>> I would simple set that bit if there is a new owner. That owner will
>> then pick up the mutex eventually and clear 'claimed' on exit from it
>> lock service (if there are no further waiters then). If the new owner =
is
>> not able to run and we steal the lock, we simple keep the 'claimed' bi=
t
>> as is. On exit from the stolen lock we find it set, thus we are forced=

>> to issue a syscall as it should be.
>>
>> OK, what happens if some waiter wants to leave the party while we are
>> holding the stolen lock? Then the sleeper number must be correct - tha=
t
>> is one pitfall!
>>
>> I will have to dig into this more deeply, considering more cases. But
>> the additional "sleepers" field remains at least misplaced IMHO.
>> xnsynch_sleepers should better be fixed to respect lock stealing, as
>> lock stealing is an xnsynch property, nothing POSIX-specific.
>=20
> Ok. I have read this but did not get what you mean. I will read it agai=
n
>  quietly from home.

I think I'm getting closer to the issue. Our actual problem comes from
the fact that the xnsynch_owner is easily out of sync with the real
owner, it even sometimes points to a former owner:

Thread A releases a mutex on which thread B pends. It wakes up B,
causing it to become the new xnsynch owner, and clears the claimed bit
as there are no further sleepers. B returns, and when it wants to
release the mutex, it does this happily in user space because claimed is
not set. Now the fast lock variable is 'unlocked', while xnsynch still
reports B being the owner. This is no problem as the next time two
threads fight over this lock the waiter will simply overwrite the
xnsynch_owner before it falls asleep. But this "trick" doesn't work for
waiters that have been robbed. They will spin inside xnsynch_sleep_on
and stumble over this inconsistency.

I have two approaches in mind now: First one is something like
XNSYNCH_STEALNOINFORM, i.e. causing xnsynch_sleep_on to not set XNROBBED
so that the robbed thread spins one level higher in the skin code -
which would have to be extended a bit.

Option two is to clear xnsynch_owner once a new owner is about to return
from kernel with the lock held while there are no more xnsynch_sleepers.
That should work with even less changes and save us one syscall in the
robbed case. Need to think about it more, though.

Jan


--------------enig2BAE1349B382C6C5BB2228CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAki1meIACgkQniDOoMHTA+lfjwCeKewjpwdI/AHWkW4eW/5LV/uu
3OoAn3nscQJQ+VsTI6GBzsLhjV06k2yj
=j33R
-----END PGP SIGNATURE-----

--------------enig2BAE1349B382C6C5BB2228CC--

