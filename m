Message-ID: <44F5CBE5.9090908@domain.hid>
Date: Wed, 30 Aug 2006 19:33:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>	
	<44F49A6C.5050603@domain.hid>	
	<b647ffbd0608291334u4182e78bub6d874e252abbbc9@domain.hid>	
	<44F592AD.2000900@domain.hid>
	<b647ffbd0608301010m52b024fbibc444e10f4a42958@domain.hid>
In-Reply-To: <b647ffbd0608301010m52b024fbibc444e10f4a42958@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig06245AB793538648E3985927"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [patch, RFC] detect unhandled interrupts
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig06245AB793538648E3985927
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 30/08/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>
>>
>> Mmh, considering this and also the existing code I wonder if we could
>> optimise this a bit. I'm only looking at xnintr_irq_handler now (shari=
ng
>> is slow anyway): currently the intr object is touched both before
>> (naturally...) and after the call to the ISR handler. Maybe we can pus=
h
>> all accesses before the handler for the fast path. E.g.:
>>
>> int unhandled =3D intr->unhandled;
>>
> intr->unhandled =3D 0;
>> ++intr->hits;
>> s =3D intr->isr(...);
>>
>> if (s =3D=3D XN_ISR_NONE) {
>>         intr->unhandled =3D ++unhandled;
>>         if (unhandled =3D=3D XNINTR_MAX_UNHANDLED)
>>                 ALARM!
>> }
>=20
>=20
> so the idea is that we touch all intr members while they are hopefully =
in
> the same cache line (if it's 128 bits long) as the cache may be
> disturbed by
> ISR afterwards.
>=20
> But OTOH, we do an additional write "int unhandled =3D intr->unhandled;=
"
>=20
> (write-through cache) ---> put in cache + syncing with memory immediate=
ly
>=20
> (write-back cache) ---> put in cache + delay syncing (but will it still=

> happen?)
>=20
> So while we avoid one possible read from the main memory into the cache=

> when
> intr->unhandled and ->hits (ok, this one can be moved for sure) are cal=
led
> after ISR (and they are not in the cache), we introduce another one (at=

> least for write-through it's 100%) that takes place before ISR and that=
's
> actually a "+" component to the IRQ latency.
>=20
> or I can be wrong though.
>=20

That also depends on what information the compiler keeps on the stack
and what in registers. On x86, sched of our xnintr_irq_handler remains
in some register while the ISR executes. The same may happen to
unhandled, but it's hard to predict. It's also the question what we want
to improve, ISR latencies or the final user latency (the latter includes
the post ISR part).

Ok, such stuff makes sense if we can say that for most cases (archs),
specifically low-end scenarios, there is some gain. Guess this would
need testing... :-/

Jan


--------------enig06245AB793538648E3985927
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE9cvlniDOoMHTA+kRAg1kAJ0WpWnT2rQYQLcyLdxuN8pduEaoZgCfdiaW
xYuAlIerpTfdx1T8zCoJsLE=
=y2CX
-----END PGP SIGNATURE-----

--------------enig06245AB793538648E3985927--

