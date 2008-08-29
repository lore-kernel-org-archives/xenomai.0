Message-ID: <48B79A05.7060203@domain.hid>
Date: Fri, 29 Aug 2008 08:41:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid>	<48B55F7C.5030901@domain.hid>	<48B56685.4060500@domain.hid>	<48B570AF.4090900@domain.hid>	<48B57281.2090109@domain.hid>	<48B57626.8070404@domain.hid>	<48B576F2.5010409@domain.hid>	<48B57BE0.8000701@domain.hid>	<48B57D32.60504@domain.hid>	<48B599DD.6070306@domain.hid>	<48B5A4AB.3030909@domain.hid>	<48B5B9FC.2050900@domain.hid>	<48B5D8EC.90009@domain.hid>
	<48B6776E.6030502@domain.hid> <48B6984B.80804@domain.hid>
In-Reply-To: <48B6984B.80804@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig443DF0420B17F084C3AA3053"
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
--------------enig443DF0420B17F084C3AA3053
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>> ...
>>>>>> I think I'm getting closer to the issue. Our actual problem comes =
from
>>>>>> the fact that the xnsynch_owner is easily out of sync with the rea=
l
>>>>>> owner, it even sometimes points to a former owner:
>>>>>>
>>>>>> Thread A releases a mutex on which thread B pends. It wakes up B,
>>>>>> causing it to become the new xnsynch owner, and clears the claimed=
 bit
>>>>>> as there are no further sleepers. B returns, and when it wants to
>>>>>> release the mutex, it does this happily in user space because clai=
med is
>>>>>> not set. Now the fast lock variable is 'unlocked', while xnsynch s=
till
>>>>>> reports B being the owner. This is no problem as the next time two=

>>>>>> threads fight over this lock the waiter will simply overwrite the
>>>>>> xnsynch_owner before it falls asleep. But this "trick" doesn't wor=
k for
>>>>>> waiters that have been robbed. They will spin inside xnsynch_sleep=
_on
>>>>>> and stumble over this inconsistency.
>>>>>>
>>>>>> I have two approaches in mind now: First one is something like
>>>>>> XNSYNCH_STEALNOINFORM, i.e. causing xnsynch_sleep_on to not set XN=
ROBBED
>>>>>> so that the robbed thread spins one level higher in the skin code =
-
>>>>>> which would have to be extended a bit.
>>>>> No, the stealing is the xnsynch job.
>>>>>
>>>>>> Option two is to clear xnsynch_owner once a new owner is about to =
return
>>>>>> from kernel with the lock held while there are no more xnsynch_sle=
epers.
>>>>>> That should work with even less changes and save us one syscall in=
 the
>>>>>> robbed case. Need to think about it more, though.
>>>>> In fact the only time when the owner is required to be in sync is w=
hen
>>>>> PIP occurs, and this is guaranteed to work, because when PIP is nee=
ded a
>>>>> syscall is emitted anyway. To the extent that xnsynch does not even=

>>>>> track the owner on non PIP synch (which is why the posix skin origi=
nally
>>>>>  forcibly set the synch owner, and it was simply kept to get the fa=
stsem
>>>>> stuff working).
>>>>>
>>>>> Ok. And what about the idea of the xnsynch bit to tell him "hey, th=
e
>>>>> owner is tracked in the upper layer, go there to find it".
>>>> I'm yet having difficulties to imagine how this should look like whe=
n
>>>> it's implemented. Would it be simpler than my second idea?
>>>>
>>>> Anyway, here is a patch (on top of my handle-based lock series) for =
the
>>>> approach that clears xnsynch_owner when there are no waiters. At lea=
st
>>>> it causes no regression based on your test, but I haven't checked lo=
ck
>>>> stealing yet. In theory, everything still appears to be fine to me. =
This
>>>> approach basically restores the state we find when some thread just
>>>> acquired the lock in user space.
>>> Yes, I did not think about the stealing when writing my test, but I
>>> think it could be a good idea to add it to the test, especially if yo=
u
>>> want to port the test to the native API.
>>>
>>> I let Philippe decide here. He is the one who did the stealing stuff =
and
>>> probably knows better.
>>>
>> Currently, the xnsynch strongly couples PIP and ownership, which seems=
 to impede
>> your various proposals. I would suggest to decouple that: the basic pr=
operty of
>> some xnsynch that we may want to handle is exclusiveness, then dynamic=
 priority
>> inheritance is another property, that could stack its own semantics on=
 top of
>> exclusiveness.
>>
>> XNSYNCH_EXCLUSIVE would cover all ownership-related actions, XNSYNCH_P=
IP would
>> simply add dynamic priority management. Non exclusive object would not=
 require
>> any xnsynch_set_owner() handling.
>>
>> Just to give a clear signal here: I will happily consider any change t=
o the
>> xnsynch object that may ease the implementation of fast ownership hand=
ling (i.e.
>> userland-to-userland transfer). The only thing is that such code is ve=
ry much
>> prone to regressions, so a testsuite must come with core changes in th=
at area,
>> but I guess you know that already.
>=20
> Ok. I think unit_mutex.c is a good start. It only lacks testing
> XNROBBED.

My colleague sent me an extension. It's native-only so far, but it
already pointed out a bug in my try-acquire implementation that should
be present in posix as well (trylock must go through the slow path).

> And well, cases of more than two waiters are not tested as
> well, but I would not think it really matters. It could be extended as
> well to allow switching at start time between the posix api and the
> native api, after all we do not care much about the overhead of calling=

> function pointers in a a test application.

For now we have two files already, but maybe we can merge them later
based on your proposal.

>=20
> As for evolution of xnsynch, I am all for it, but it would break
> anything implemented before, so it will probably be on Jan's critical p=
ath.

I have some intermediate version here that breaks up the
retry-on-XNROBBED loop, doing it at skin level instead. This is
targeting the first customer delivery.

I also have two implementations of fast locking now, native and posix,
and they don't look that bad /wrt moving quite a few bits into xnsynch -
later.

Jan

PS: The test cases + my /proc/xenomai/registry/usage probably unveiled
another pending bug: Native user space tasks are leaking handles, even
on vanilla Xenomai SVN (didn't test 2.4.x yet). Will look into this later=
=2E


--------------enig443DF0420B17F084C3AA3053
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAki3mgUACgkQniDOoMHTA+lnjQCeKXCdrRAIv5gBnwimtFX1+GGo
iYgAoITqXnK9a/XnVe7ZytUm6iJbGqlB
=3LD4
-----END PGP SIGNATURE-----

--------------enig443DF0420B17F084C3AA3053--

