Message-ID: <4BAB72F0.9090500@domain.hid>
Date: Thu, 25 Mar 2010 15:28:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BAB1709.9000601@domain.hid>
	<4BA9E7E0.6040206@domain.hid>	<4BA8F900.5000602@domain.hid>
	<4BA39C3D.1040802@domain.hid>	<4BA4EF75.7010202@domain.hid>
	<4BA74820.2090401@domain.hid>	<4BA8752E.8090407@domain.hid>
	<4BA8C15E.5050707@domain.hid>	<4BA8F517.3060705@domain.hid>
	<4BA8F732.10206@domain.hid>	<2d0b8e.10245.1278e1771a8.Coremail.robert165@domain.hid>	<63e73d99.3c71.127933ea91c.Coremail.robert165@domain.hid>	<1a51bc0.b6de.127955f4dc7.Coremail.robert165@domain.hid>
	<4BAB69F9.7070105@domain.hid>
In-Reply-To: <4BAB69F9.7070105@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF0A877EB98B5A43E4776B031"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Problem in irq_handle
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
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF0A877EB98B5A43E4776B031
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> robert165 wrote:
>>
>>
>> =E5=9C=A82010-03-25 15:55:53=EF=BC=8C"Gilles Chanteperdrix"
>> <gilles.chanteperdrix@xenomai.org> =E5=86=99=E9=81=93=EF=BC=9A
>>> robert165 wrote:
>>>> =E5=9C=A82010-03-24 18:22:24=EF=BC=8C"Gilles Chanteperdrix"
>>>> <gilles.chanteperdrix@xenomai.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>> robert165 wrote:
>>>>>> Hi Jan, I am new to xenomai, I am writing a gpio driver based
>>>>>> on your "RTDM skeleton v1.1". There is a problem that when I
>>>>>> complied and run your skeleton in a at91rm9200 broad with
>>>>>> TIMERINT, the output is not show one line one second but very
>>>>>> fast. The problem is still whenever I changed the following
>>>>>> codes in demo_interrupt()
>>>>>>
>>>>>> #ifdef TIMERINT if (events > XXX){=20
>>>>>> rtdm_event_signal(&ctx->irq_event); event=3D0; } ... events++;
>>>>>>
>>>>>> And, it seems likely in my own irq_handle of a gpio irq. When
>>>>>> the irq arrive, the irq_handle repeats many times. Should I
>>>>>> mask the same irq in irq_handle? I did it by write the PIO
>>>>>> interrupt mask register, but no effect.
>>>>> Which interrupt is TIMERINT?
>>>> TIMERINT is timer interrupt.
>>>>
>>>> It is in the demo of rtdm driver, the sourse is:
>>>>
>>>> http://www.captain.at/xenomai-real-time-driver-example.php
>>>>
>>>> Best wishes,
>>> Yes, but I was wondering which timer interrupt: - if you are
>>> talking about the AT91 "system interrupt", it is shared between
>>> several peripherals, including the DBGU serial port, and can not be
>>> used in a real-time driver for this reason; - if you are talking
>>> about the TC interrupt, it is handled by the I-pipe, and you can
>>> not register a handler for your own driver either.
>>>
>>> IOW, what value of TIMERINT do you use?
>> What I said is  the the original codes of Jan, I just compiled and
>> run it without any modification. The value of TIMERINT is 0.
>=20
> Ok. In fact, I am afraid Jan's code is for x86, not AT91. Since that
> driver was written, RTDM gained support for timers, so, hooking into th=
e
> timer interrupt is no longer needed if you want a handler to be
> triggered periodically.

I have to reject any credits for suggesting to hook into the timer IRQ
(or I would suffer from serious dementia). That example on captain.at is
not suited for tutorial purposes without further explanations.
Unfortunately, there is more stuff on that site. I tried to contact
Hannes on that some time ago but did not receive any reply.

Jan


--------------enigF0A877EB98B5A43E4776B031
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkurcvUACgkQitSsb3rl5xSV0gCeL6a2lXAFNEZLBk/73vFjyfqy
Y90AniluybQ4eSEGA0/tIbXef/yP9wU/
=QIwV
-----END PGP SIGNATURE-----

--------------enigF0A877EB98B5A43E4776B031--

