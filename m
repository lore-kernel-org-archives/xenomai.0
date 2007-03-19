Message-ID: <45FEC957.3010509@domain.hid>
Date: Mon, 19 Mar 2007 18:33:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-Socket-CAN bus error handling (was CAN errors
	and real-time behaviour (IRQ raise forever and may lock system))
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<E1HTD6v-0004qo-QI@mailer.emlix.com> <45FEBEC5.8010608@domain.hid>
	<200703191756.23249.Sebastian.Smolorz@domain.hid>
In-Reply-To: <200703191756.23249.Sebastian.Smolorz@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig26944C09545E2EE289BD58D6"
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig26944C09545E2EE289BD58D6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> St=E9phane ANCELOT wrote:
>>> IIRC, there is no possibility to detect a "normal" bus error
>>> (acknowledge) appearing during normal operation from the one occuring=

>>> when the cable is plugged off. The best indication is a high number o=
f
>>> consecutive BEIs.
>> I do not agree :
>> case normal :
>> In normal bus error condition, if error repeats the chip will go to
>> busoff state (unfortunately I don't know how to simulate this...)
>>
>> case unplugged (easy to simulate):
>> when the cable is not plugged it will not go to busoff condition.
>=20
> I know that. Unfortunately, you took my above answer out of context. I =
replied=20
> to:
>=20
>> What about something like option 3: After the first error occurred tha=
t
>> may mark the beginning of a flood, disable that error interrupt until
>> the next stop/start cycle or the user has read the event?
>=20
> I was referring to *one* bus error. If one bus error occurs how will th=
e=20
> driver know it is the beginning of a flood due to an unplugged cable? I=
t can=20
> only tell after serveral consecutive ones.

As damn SJA1000 doesn't seem to help us here, I was suggesting to play
safe: disable that particular IRQ source until administrator reset or
some task reads the generated error frame AND (that's probably required
too) continues to ask for the next one.

The latter condition would allow the error frame reader to fully control
the IRQ rate. Note that this is not just about avoiding total lock-up.
Even a specific period of an abnormal IRQ load can kill an RT system.

Jan


--------------enig26944C09545E2EE289BD58D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF/slXniDOoMHTA+kRAkTrAJ9EQM/UuboHPUDvua6ASs39rl6U/ACdGDvm
ZA1rh3egGD1okKJo6i2nx3E=
=7bS0
-----END PGP SIGNATURE-----

--------------enig26944C09545E2EE289BD58D6--

