Message-ID: <4AB232BC.2080800@domain.hid>
Date: Thu, 17 Sep 2009 14:59:40 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4303dd240909110600tf787b85td93b46086953a0d9@domain.hid>	<4AAA4AE9.5070101@domain.hid>	<4303dd240909160555l5f53839g6bf917a17370bb09@domain.hid>
	<4AB22A6C.5030801@domain.hid>
In-Reply-To: <4AB22A6C.5030801@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA8787B87D48DB5B017CD1C4C"
Subject: Re: [Xenomai-help] Problems with instalation of xenomai in ubuntu
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
--------------enigA8787B87D48DB5B017CD1C4C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Gilles Chanteperdrix schrieb:
> Flavio de Castro Alves Filho wrote:
>> Hello,
>> Sorry for the delay in the response.
>>
>> In fact, I believe it is not really a kernel panic,=20
>=20
> And you believe wrong. The keyboard leds blinking are the sign of a
> kernel panic. Without any doubt.

True, but Flavio has written "...starts to blink the display...",
nothing about blinking keyboard leds.

So, I guess X is trying different screen resolutions.
For me this sounds more like a problem with the graphic driver.

Try to reconfigure X and select another graphic driver, like framebuffer.=


kisda

> because the login
>> message appears at the screen just before the screen is cleared (and t=
he
>> computer is blocked). Sometimes I can see the mouse pointer for X, but=
 the
>> computer is also blocked.
>>
>> The boot behavior is something like this:
>>
>> - normal boot, which the messages on the screen (I suppose the message=
s are
>> correct)
>> - login message (terminal mode)
>> - switch to X mode
>> - system block
>>
>> Build information:
>> - Linux kernel 2.6.30
>> - Xenomai version 2.4.9.1 (I have tried also with xenomai 2.4.9 and I =
had
>> similar results)
>> - GCC version 4.3.2
>> - Ubuntu 8.10
>>
>> Which information can I send to you in order to be more specific?
>=20
> I already answered this question: send us the console output up to the
> panic. Using serial console or network console and a second computer.
>=20



--------------enigA8787B87D48DB5B017CD1C4C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFKsjLCIPTw9rIdn6oRAgRLAJ97XzIF8X21/K2oN0qdihZQjhGpzACfbScX
FxMisMNFfLFpWwwGDgN/0oI=
=kzGP
-----END PGP SIGNATURE-----

--------------enigA8787B87D48DB5B017CD1C4C--

