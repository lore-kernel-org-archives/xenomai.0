Message-ID: <4BB5C2FC.30501@domain.hid>
Date: Fri, 02 Apr 2010 12:12:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20100401230843.GF3755@domain.hid>
	<4BB53566.3010601@domain.hid> <4BB53643.2080604@domain.hid>
	<4BB5AA44.6000006@domain.hid> <4BB5AACE.7020602@domain.hid>
	<4BB5B1BD.6020903@domain.hid> <4BB5B2D3.80708@domain.hid>
	<4BB5B7B1.3030601@domain.hid> <4BB5C0BD.7080208@domain.hid>
	<4BB5C167.6000609@domain.hid>
In-Reply-To: <4BB5C167.6000609@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF70375E63A35C76B31140B4D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF70375E63A35C76B31140B4D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>> Andreas Glatz wrote:
>>>>>>>>>> Hi Philippe,
>>>>>>>>>>
>>>>>>>>>> At the Xenomai Users Meeting last year I asked you if Xenomai =
would offer a possibility to lower the priority of certain Xenomai tasks =
below that of Linux. We need this feature since we have tasks in our RT a=
pplication which should only run when Linux is idle (A statistics collect=
ion task which part of the RT application and hard to isolate from this a=
pplication).
>>>>>>>>>>
>>>>>>>>> What prevents using a borderline thread (if you need to interac=
t with
>>>>>>>>> blocking Xenomai services) with SCHED_OTHER and a Linux nice le=
vel of 19?
>>>>>>>> Well, this does not really guarantee that the thread will run on=
ly when
>>>>>>>> linux is idle. The thread will eat some cpu time, the nice level=
 is not
>>>>>>>> a strict priority, as you know.
>>>>>>> Where do you really need anything stricter? It's the opposite of =
"I need
>>>>>>> true 100% CPU for my task, and that forever."
>>>>>>>
>>>>>>>> But in fact, I wonder why Andreas wants
>>>>>>>> a new scheduling policy for xenomai, what is needed, is simply a=

>>>>>>>> SCHED_IDLE (maybe it exists ?!) policy for Linux.
>>>>>>>>
>>>>>>> There is no such thing AFAIK. If you are concerned that some CPU
>>>>>>> intensive low prio job eats too much CPU, you normally reduce its=

>>>>>>> nice-level and/or confine its CPU bandwidth via cgroups.
>>>>>> SCHED_IDLE exists.
>>>>>>
>>>>> Ah, as "nice 20". Same mechanism, just another level.
>>>>>
>>>> ...and before trying something else:
>>>>
>>>> "SCHED_IDLE: This is even weaker than nice 19, but its not a true
>>>> idle timer scheduler in order to avoid to get into priority
>>>> inversion problems which would deadlock the machine."
>>> Mmmm, priority inversion? I thought the kernel had priority inheritan=
ce?
>>>
>> I do not recall the details, but I don't think non-RT priorities are
>> inherited. Moreover, user space locks without explicit inheritance set=

>> (ie. the majority of locks) would still cause deadlocks, though not fo=
r
>> the kernel.
>=20
> Well, of course. If a non real-time task shares a lock with a real-time=

> task, it has to have priority inheritance anyway. However
> SCHED_IDLE/SCHED_OTHER/whatever is implemented.

Yes, but the deadlock concerns are mostly about non-RT tasks sharing
locks (e.g. in-kernel mutexes).

Jan



--------------enigF70375E63A35C76B31140B4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAku1wvwACgkQitSsb3rl5xQA4ACdEWLON7MV++1IY9BMs682mXIQ
rRkAoNPmfp60+rNiVrfakQ5wExIo+GX/
=gtJL
-----END PGP SIGNATURE-----

--------------enigF70375E63A35C76B31140B4D--

