Message-ID: <48B7A3AF.6010802@domain.hid>
Date: Fri, 29 Aug 2008 09:22:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid>	<48B55F7C.5030901@domain.hid>	<48B56685.4060500@domain.hid>	<48B570AF.4090900@domain.hid>	<48B57281.2090109@domain.hid>	<48B57626.8070404@domain.hid>	<48B576F2.5010409@domain.hid>	<48B57BE0.8000701@domain.hid>	<48B57D32.60504@domain.hid>	<48B599DD.6070306@domain.hid>	<48B5A4AB.3030909@domain.hid>	<48B5B9FC.2050900@domain.hid>	<48B5D8EC.90009@domain.hid>
	<48B6776E.6030502@domain.hid> <48B6984B.80804@domain.hid>
	<48B79A05.7060203@domain.hid> <48B79EAB.8000109@domain.hid>
In-Reply-To: <48B79EAB.8000109@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig711C15AB16439F5391BAC67B"
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
--------------enig711C15AB16439F5391BAC67B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Philippe Gerum wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>> ...
>>>>>>>> I think I'm getting closer to the issue. Our actual problem come=
s from
>>>>>>>> the fact that the xnsynch_owner is easily out of sync with the r=
eal
>>>>>>>> owner, it even sometimes points to a former owner:
>>>>>>>>
>>>>>>>> Thread A releases a mutex on which thread B pends. It wakes up B=
,
>>>>>>>> causing it to become the new xnsynch owner, and clears the claim=
ed bit
>>>>>>>> as there are no further sleepers. B returns, and when it wants t=
o
>>>>>>>> release the mutex, it does this happily in user space because cl=
aimed is
>>>>>>>> not set. Now the fast lock variable is 'unlocked', while xnsynch=
 still
>>>>>>>> reports B being the owner. This is no problem as the next time t=
wo
>>>>>>>> threads fight over this lock the waiter will simply overwrite th=
e
>>>>>>>> xnsynch_owner before it falls asleep. But this "trick" doesn't w=
ork for
>>>>>>>> waiters that have been robbed. They will spin inside xnsynch_sle=
ep_on
>>>>>>>> and stumble over this inconsistency.
>>>>>>>>
>>>>>>>> I have two approaches in mind now: First one is something like
>>>>>>>> XNSYNCH_STEALNOINFORM, i.e. causing xnsynch_sleep_on to not set =
XNROBBED
>>>>>>>> so that the robbed thread spins one level higher in the skin cod=
e -
>>>>>>>> which would have to be extended a bit.
>>>>>>> No, the stealing is the xnsynch job.
>>>>>>>
>>>>>>>> Option two is to clear xnsynch_owner once a new owner is about t=
o return
>>>>>>>> from kernel with the lock held while there are no more xnsynch_s=
leepers.
>>>>>>>> That should work with even less changes and save us one syscall =
in the
>>>>>>>> robbed case. Need to think about it more, though.
>>>>>>> In fact the only time when the owner is required to be in sync is=
 when
>>>>>>> PIP occurs, and this is guaranteed to work, because when PIP is n=
eeded a
>>>>>>> syscall is emitted anyway. To the extent that xnsynch does not ev=
en
>>>>>>> track the owner on non PIP synch (which is why the posix skin ori=
ginally
>>>>>>>  forcibly set the synch owner, and it was simply kept to get the =
fastsem
>>>>>>> stuff working).
>>>>>>>
>>>>>>> Ok. And what about the idea of the xnsynch bit to tell him "hey, =
the
>>>>>>> owner is tracked in the upper layer, go there to find it".
>>>>>> I'm yet having difficulties to imagine how this should look like w=
hen
>>>>>> it's implemented. Would it be simpler than my second idea?
>>>>>>
>>>>>> Anyway, here is a patch (on top of my handle-based lock series) fo=
r the
>>>>>> approach that clears xnsynch_owner when there are no waiters. At l=
east
>>>>>> it causes no regression based on your test, but I haven't checked =
lock
>>>>>> stealing yet. In theory, everything still appears to be fine to me=
=2E This
>>>>>> approach basically restores the state we find when some thread jus=
t
>>>>>> acquired the lock in user space.
>>>>> Yes, I did not think about the stealing when writing my test, but I=

>>>>> think it could be a good idea to add it to the test, especially if =
you
>>>>> want to port the test to the native API.
>>>>>
>>>>> I let Philippe decide here. He is the one who did the stealing stuf=
f and
>>>>> probably knows better.
>>>>>
>>>> Currently, the xnsynch strongly couples PIP and ownership, which see=
ms to impede
>>>> your various proposals. I would suggest to decouple that: the basic =
property of
>>>> some xnsynch that we may want to handle is exclusiveness, then dynam=
ic priority
>>>> inheritance is another property, that could stack its own semantics =
on top of
>>>> exclusiveness.
>>>>
>>>> XNSYNCH_EXCLUSIVE would cover all ownership-related actions, XNSYNCH=
_PIP would
>>>> simply add dynamic priority management. Non exclusive object would n=
ot require
>>>> any xnsynch_set_owner() handling.
>>>>
>>>> Just to give a clear signal here: I will happily consider any change=
 to the
>>>> xnsynch object that may ease the implementation of fast ownership ha=
ndling (i.e.
>>>> userland-to-userland transfer). The only thing is that such code is =
very much
>>>> prone to regressions, so a testsuite must come with core changes in =
that area,
>>>> but I guess you know that already.
>>> Ok. I think unit_mutex.c is a good start. It only lacks testing
>>> XNROBBED.
>> My colleague sent me an extension. It's native-only so far, but it
>> already pointed out a bug in my try-acquire implementation that should=

>> be present in posix as well (trylock must go through the slow path).
>=20
> I do not see why. If mutex lock can lock without a syscall, the same
> goes for trylock.

Lock stealing requires the slow path.

Jan



--------------enig711C15AB16439F5391BAC67B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAki3o68ACgkQniDOoMHTA+mW+wCfTLJJ286oQawhZ95/xq2mqHcv
XogAmgPKZS+RsC9w/ceSPJbgsEn0SB3s
=h9se
-----END PGP SIGNATURE-----

--------------enig711C15AB16439F5391BAC67B--

