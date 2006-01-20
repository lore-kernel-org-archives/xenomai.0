Message-ID: <43D0AD9C.1030000@domain.hid>
Date: Fri, 20 Jan 2006 10:30:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Meassage Queue c++
References: <43CFC6B5.8080308@domain.hid>	<200601200914.37506.s.zimmermann@domain.hid>	<43D0A13C.10603@domain.hid>
	<200601200948.09127.s.zimmermann@domain.hid>
In-Reply-To: <200601200948.09127.s.zimmermann@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2CED2289F1CF20E2307935AE"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2CED2289F1CF20E2307935AE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Stephan Zimmermann wrote:
> Jan Kiszka wrote:
>=20
>> Some further things to try before giving C++ up - and maybe stumbling
>> over the same issue with C:
> I tryed out xenomai queues in plain C, works perfekt.
>=20
>>  o Did you mlockall() your program? If not, lazy-mapped pages may caus=
e
>>    SEGFAULTS in the RT domain which will kill your program.
> I call "mlockall(MCL_CURRENT | MCL_FUTURE);" as one of the first things=
 in=20
> main();
>>  o Does your kernel log contain any hints of Xenomai about what's goin=
g
>>    on?
> No, ist does not contain anything
>=20
>>  o Try running your program inside a debugger to catch the fault and i=
ts
>>    location. When your system is head-less, use gdbserver.
> I tryed debugging, I singlestepped through it and learned that it crash=
es when=20
> calling rt_queue_recv(), but I can not tell why.
>=20
> maybe it is because I do the "bind-thing" in the constructor, resulting=
 in=20
> multiple objects of RT_QUEUE referring to the same queue.

But this is the idea of a queue: two users are referring to the same
object in order to communicate with each other!?

Would you mind to break out a demonstration code of your problem? Just
to check if there is some subtle Xenomai issue hidden or if it's an ugly
pitfall when using C++ in hard-RT context.

Jan


--------------enig2CED2289F1CF20E2307935AE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD0K2gniDOoMHTA+kRAgibAJ0bw5j8jpaFqR6mtAPdYgjeWPHlyQCfS0VF
HiLxuvnHhdDVrjXTQlmN/C4=
=jYaH
-----END PGP SIGNATURE-----

--------------enig2CED2289F1CF20E2307935AE--

