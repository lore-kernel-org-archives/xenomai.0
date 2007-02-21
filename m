Message-ID: <45DC1773.1080803@domain.hid>
Date: Wed, 21 Feb 2007 10:57:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Enhanced RTDM device closure
References: <45DC0623.3080706@domain.hid> <45DC0939.6070207@domain.hid>
	<45DC0CAA.2050001@domain.hid> <45DC139A.6020302@domain.hid>
In-Reply-To: <45DC139A.6020302@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig79053804A42B11DD346CBEC9"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig79053804A42B11DD346CBEC9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Hi,
>>>>
>>>> a few changes of the RTDM layer were committed to trunk recently. Th=
ey
>>>> make handling of RTDM file descriptors more handy:
>>>>
>>>> o rt_dev_close/POSIX-close now polls as long as the underlying devic=
e
>>>>   reports -EAGAIN. No more looping inside the application is require=
d.
>>>>   This applies to the usual non-RT invocation of close, the corner
>>>>   case "close from RT context" can still return EAGAIN.
>>>>
>>>> o Automatic cleanup of open file descriptors has been implemented. T=
his
>>>>   is not yet the perfect design (*), but a straightforward approach =
to
>>>>   ease the cleanup after application crashes or other unexpected
>>>>   terminations.
>>>>
>>>> The code is still young, so testers are welcome.
>>>>
>>>> Jan
>>>>
>>>>
>>>> (*) Actually, I would like to see generic per-process file descripto=
r
>>>> tables one day, used by both the POSIX and the RTDM skin. The FD tab=
le
>>>> should be obtained via xnshadow_ppd_get().
>>> I agree for the file descriptor table, but I do not see why it should=
 be
>>> bound to xnshadow_ppd_get. The file descriptor table could be
>>> implemented in an object like fashion, where the caller is responsibl=
e
>>> to pass the same pointer to the creation, use and desctruction routin=
es.
>>
>> But where to get this pointer from when I enter, say, rtdm_ioctl on
>> behalf of some process? The caller just passes an integer, the file
>> descriptor.
>=20
> Yes, the pointer would be obtained via xnshadow_ppd_get, but it does no=
t
> have to be built-in the nucleus, this can be done by the skins.
>=20
>>
>>> This would allow, for example, to have a descriptor table for
>>> kernel-space threads. Another feature that would be interesting for t=
he
>>
>> I don't see the need to offer kernel threads private fd tables. They c=
an
>> perfectly continue to use a common, then kernel-only table. There are
>> too few of those threads, and there is no clear concept of a process
>> boundary in kernel space.
>=20
> I mean having one descriptor table for the kernel space as a whole, but=

> the kernel space descriptor table does not have to be of a different
> type from the user-space descriptor tables.
>=20
>>
>>> posix skin would be to have a callback called at process fork time in=

>>> order to duplicate the fd table.
>>
>> Ack. IIRC, this callback could also serve to solve the only consistenc=
y
>> issue of the ipipe_get_ptd() approach.
>>
>>
>>> But first this requires
>>>
>>>> lock-less xnshadow_ppd_get() based on ipipe_get_ptd() to keep the
>>>> overhead limited. Yet another story.
>>> xnshadow_ppd_get is already lockless, usual callers have to hold the
>>> nklock for other reasons anyway.
>>>
>>
>> OK, depends on the POV :). Mine is that the related RTDM services do n=
ot
>> hold nklock and will never have to. Moreover, there is no need for
>> locking design-wise, because per-process data cannot vanish under the
>> caller unless the caller vanishes. The need currently only comes from
>> the hashing-based lookup (reminds me of the WCET issues kernel futexes=

>> have...).
>=20
> I have to have a closer look at the code. But you are right, since the
> ppd cannot vanish under our feet, maybe is it possible to call
> xnshadow_ppd_get without holding the nklock at all. We "only" have to
> suppose that the lists manipulation routines will never set the list to=

> an inconsistent state.

As long as process A's ppd can take a place in the same list as process
B's one, you need locking (or RCU :-/). That's my point about the hash
chain approach.

I can only advertise the idea again to maintain the ppd pointers as an
I-pipe task_struct key. On fork/clone, you just have to make sure that
the child either gets a copy of the parent's pointer when it will share
the mm, or its key is NULL'ified, or automatic Xenomai skin binding is
triggered to generate in a new ppd.

>=20
> Something else that I would like is that the fd table be bound to the
> nucleus registry. This would allow to factor the registry implementatio=
n.
>=20

Ack, that's what I had in mind as well. We need to make this fd table
stuff a generic service, maybe even the foundation of any object
descriptor in user-space.

Jan


--------------enig79053804A42B11DD346CBEC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3BdzniDOoMHTA+kRArobAJ90/T5+xvqwXL8JhQjhI4Nt1EC3DQCeKPNG
3jslq7gomAu5rMMrJZ6nGYk=
=WRof
-----END PGP SIGNATURE-----

--------------enig79053804A42B11DD346CBEC9--

