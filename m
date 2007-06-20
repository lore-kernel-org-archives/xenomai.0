Message-ID: <4679A302.2060403@domain.hid>
Date: Wed, 20 Jun 2007 23:58:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46782305.4080501@domain.hid>
	<b647ffbd0706201404r256038b7sbb9318cdc1746b7c@domain.hid>
In-Reply-To: <b647ffbd0706201404r256038b7sbb9318cdc1746b7c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig408CA125402A2C98EC5076C0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC][PATCH] shirq locking rework
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
--------------enig408CA125402A2C98EC5076C0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> Hello Jan,
>=20
>> Well, I hate nested locks when it comes to real-time, but in this case=
 I
>> really found no simpler approach. There is the risk of deadlocks via
>>
>> IRQ:            xnintr_shirq::lock -> handler -> nklock vs.
>> Application:    nklock -> xnintr_attach/detach -> xnintr_shirq::lock,
>=20
> it's also relevant for the current code - xnintr_attach/detach() must
> not be called while holding the 'nklock'.

That's good, no new restriction (the existing one will be documented now)=
=2E

>=20
> I think, your approach should work as well.. provided we have only a
> single reader vs. a single writter contention case, which seems to be
> the case here ('intrlock' is responsible for synchronization between

Single writer is ensured by intrlock, single reader comes from the
per-IRQ scope of the inner lock.

> xnintr_attach/detach()).. your approach does increase a worst case
> length of the lock(&intrlock) --> unlock(&intrlock) section... but
> that's unlikely to be critical.
>=20
> I think, the patch I sent before addresses a reported earlier case
> with xnintr_edge_shirq_handler().. but your approach does make code
> shorter (and likely simpler), right? I don't see any problems it would
> possibly cause (maybe I'm missing smth yet :)

I must confess I didn't get your idea immediately. Later on (cough,
after hacking my own patch, cough) I had a closer look, and it first
appeared fairly nice, despite the additional "ifs". But then I realised
that "end =3D=3D old_end" may produce false positives in case we have
several times the same (and only the same) IRQ in a row. So, I'm afraid
we have to live with only one candidate. :->

OK, will point our bug reporter to that patch now and ask for testing.

Jan


--------------enig408CA125402A2C98EC5076C0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGeaMCniDOoMHTA+kRAui/AJ9MqpUSTSk50UWEiXdWJgXGShEJSgCeOpMt
Pje+/Cj6WaAjwIADLyUglgo=
=3SqZ
-----END PGP SIGNATURE-----

--------------enig408CA125402A2C98EC5076C0--

