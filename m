Message-ID: <44F5FC95.4030206@domain.hid>
Date: Wed, 30 Aug 2006 23:01:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [patch, RFC] detect unhandled interrupts
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>	
	<44F49A6C.5050603@domain.hid>	
	<b647ffbd0608291334u4182e78bub6d874e252abbbc9@domain.hid>	
	<44F592AD.2000900@domain.hid> <1156960547.4323.68.camel@domain.hid>	
	<44F5DDF1.3030006@domain.hid> <1156970880.4323.74.camel@domain.hid>	
	<44F5FB26.40700@domain.hid> <1156971559.4323.82.camel@domain.hid>
In-Reply-To: <1156971559.4323.82.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAE1DBCE12AA79D0A6FA5FBBD"
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE1DBCE12AA79D0A6FA5FBBD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2006-08-30 at 22:55 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Wed, 2006-08-30 at 20:50 +0200, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>
>>>>> On Wed, 2006-08-30 at 15:29 +0200, Jan Kiszka wrote:
>>>>>  =20
>>>>>> Dmitry Adamushko wrote:
>>>>>>    =20
>>>>>>> On 29/08/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>>>>>      =20
>>>>>>>> Dmitry Adamushko wrote:
>>>>>>>>
>>>>>>>> I think the additional costs of maintaining an error counter are=
 almost
>>>>>>>> negligible. The test is in the unlikely path, and the first cond=
ition
>>>>>>>> already keeps us away from touching the counter.
>>>>>>>>        =20
>>>>>>> But it's updated (unhandled =3D 0) any time the ISR(s) report som=
ething
>>>>>>> different from XN_ISR_NONE.  Hence, it's at the beginning of the =
xnintr_t
>>>>>>> structure, hopefully, at the same cache line with other highly-us=
ed members
>>>>>>> (i.e. isr, cookie and hits).
>>>>>>>      =20
>>>>>> Mmh, considering this and also the existing code I wonder if we co=
uld
>>>>>> optimise this a bit. I'm only looking at xnintr_irq_handler now (s=
haring
>>>>>> is slow anyway): currently the intr object is touched both before
>>>>>> (naturally...) and after the call to the ISR handler. Maybe we can=
 push
>>>>>> all accesses before the handler for the fast path. E.g.:
>>>>>>
>>>>>> int unhandled =3D intr->unhandled;
>>>>>>
>>>>>> intr->unhandled =3D 0;
>>>>>> ++intr->hits;
>>>>>> s =3D intr->isr(...);
>>>>>>
>>>>>> if (s =3D=3D XN_ISR_NONE) {
>>>>>> 	intr->unhandled =3D ++unhandled;
>>>>>> 	if (unhandled =3D=3D XNINTR_MAX_UNHANDLED)
>>>>>> 		ALARM!
>>>>>> }
>>>>>>
>>>>>>    =20
>>>>> Without speculating whether this could actually reduce cache misses=
 or
>>>>> not when the branch is taken, the main issue I see here is that we =
would
>>>>> optimize the error case, at the expense of an additional memory fet=
ching
>>>> No, it's the common path. Otherwise, I would have stopped already. I=
 don't
>>>> expect further memory access because the head of intr should be cach=
ed
>>>> already.
>>>>
>>> Sorry, my brain cells must be glued together, but then, I just don't =
get
>>> what your patch actually optimizes :o}
>> Cache misses when accessing intr AFTER the ISR has finished (not on
>> latest Pentium with 4 MB caches...) for the non-error case.
>=20
> What do you call the "error case"?
>=20

XN_ISR_NONE


--------------enigAE1DBCE12AA79D0A6FA5FBBD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE9fyVniDOoMHTA+kRAmYUAJ4raJh7UKO2mIJUNHcID/jO9V0/4wCeM72f
deFU/0ZuPgN5kS558NDYsug=
=IIWZ
-----END PGP SIGNATURE-----

--------------enigAE1DBCE12AA79D0A6FA5FBBD--

