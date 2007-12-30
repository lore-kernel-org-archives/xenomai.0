Message-ID: <4777D22A.1090805@domain.hid>
Date: Sun, 30 Dec 2007 18:15:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4776D48E.7050002@domain.hid> <4777785F.2030903@domain.hid>
In-Reply-To: <4777785F.2030903@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3799C191B9242E63380D7E88"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH 4/5] remove legacy code
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3799C191B9242E63380D7E88
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> This patch gets rid of code that is no longer needed or valid:
>>
>>  - x86_64 APIC frequency is now delivered via ipipe_request_tickdev
>=20
> Ack.
>=20
>>  - __ipipe_tick_irq is maintained via ipipe_update_tick_evtdev also on=

>>    x86_64
>=20
> Client RTOS may/do assume that timing is always delivered through the
> local APIC timer on x86_64. We could merge that and allow the 8253 to b=
e
> used as the timer device, but this would not work in practice.

For forget HPET. There is no wiring of the timer IRQ to the APIC
anymore. The result is that there is no difference between x86_32 and
x86_64 anymore, and that's what the code reflects.

If the client RTOS is not yet fully prepared for this, this has to be
fixed. And only if there is no valid Linux configuration (e.g. HPET off)
that results in the same timer assignment as with 2.6.23, we need a
workaround at I-pipe level IMHO.

Jan


--------------enig3799C191B9242E63380D7E88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHd9IqniDOoMHTA+kRAnO5AJ0bp7OtUgXw8mzWRP6UdO+8Pp14VwCgg/xw
vEBQIYxpQRWyBQ9meSOuI08=
=IxPY
-----END PGP SIGNATURE-----

--------------enig3799C191B9242E63380D7E88--

