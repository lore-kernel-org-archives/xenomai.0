Message-ID: <46D30203.9070001@domain.hid>
Date: Mon, 27 Aug 2007 18:55:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <10837d740708262338w2def2f9er8fd2ca589e681992@domain.hid>	
	<46D2A840.8040301@domain.hid>
	<10837d740708270654j3bf3849aq3eef304a7cf502a5@domain.hid>
In-Reply-To: <10837d740708270654j3bf3849aq3eef304a7cf502a5@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC009678F7EEF8CD5CCE06779"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] RT ISR re-entrance
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: =?GB2312?B?1cW+pw==?= <2hang.j1ng.home@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC009678F7EEF8CD5CCE06779
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

=D5=C5=BE=A7 wrote:
> hi,
>=20
> Thank you for your reply!
>=20
> 2007/8/27, Jan Kiszka <jan.kiszka@domain.hid>:
>> ?? wrote:
>>> hi all,
>>>
>>> In SMP system, an edge triggerred interrupt may be dispatched to
>> multiple
>>> cpus, so the RT ISR of this interrupt may be involved on multiple cpu=
s
>> at
>>> the same time. The question comes: is RT ISR need to be reentrant as
>>> designed or do I miss something?
>> Good question. I would say: yes, it's the I-pipe user's job to take ca=
re
>> of re-entrance safety.
>>
>> Vanilla Linux prevents this via the IRQ_INPROGRESS flag. Xenomai 2.4 a=
nd
>> since 2.3.2 achieves re-entrance protection for the registered driver
>> handler by holding the IRQ-related spinlock while calling into that
>> handler.
>=20
>=20
> AFAIK, Xenomai 2.3.3 simply uses the IRQ dispatcher of i-pipe and do no=
t
> supply its own dispatcher.

The Xenomai nucleus does dispatch - to the registered handler(s).

>=20
> Still, this isn't something the user should build his system
>> upon. It is rather recommended for determinism and efficiency reasons =
to
>> assign RT IRQs to a specific CPU.
>=20
>=20
> Good suggestion=A3=A1Thanks again!
>=20
> HTH,
>> Jan
>>
>>
>>

Jan


--------------enigC009678F7EEF8CD5CCE06779
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG0wIDniDOoMHTA+kRAni0AJ99QWlQVVJbKtL5Tnua9Oy26BF3gACfXN6z
9S4949JNOKTUo1SPpkkjzoc=
=2ro/
-----END PGP SIGNATURE-----

--------------enigC009678F7EEF8CD5CCE06779--

