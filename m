Message-ID: <47E397AE.2010009@domain.hid>
Date: Fri, 21 Mar 2008 12:10:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <d6c8ef150803180527h71adc568o612fec284f8d096@domain.hid>	<2ff1a98a0803180723i17d6d6e1p619b9c8948b6e542@domain.hid>	<d6c8ef150803190410l48c36687odd494d3966407a8@domain.hid>	<18401.32383.382321.517340@domain.hid>	<d6c8ef150803210350o3daefc6ra0de77c72c7401b1@domain.hid>
	<2ff1a98a0803210354g40137eeds72eb742142856cd@domain.hid>
In-Reply-To: <2ff1a98a0803210354g40137eeds72eb742142856cd@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig22772BA851289C0955E839D9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Handling irq
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig22772BA851289C0955E839D9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> On Fri, Mar 21, 2008 at 11:50 AM, Bosko Radivojevic
> <bosko.radivojevic@domain.hid> wrote:
>> I have much better results using rtdm_lock_get_irqsave and
>>  rtdm_lock_put_irqrestore. I hope this is the "appropriate method" of
>>  doing it :)
>>
>>  Thanks!
>=20
> Shutting interrupts off for long periods of time is not a good idea:
> - it does not scale well, since it does not work for more than one task=
;
> - it kills the precision of timers by delaying the timer interrupt.
> And I am sure we can find many more drawbacks.

- it only reduces the probability of your problem, it doe not
   eliminate it completely

You can still be interrupted right after task wakeup, before=20
rtdm_lock_get_irqsave. And there is still the possibility to be delayed=20
by interrupts BEFORE your task is even triggered.

If you cannot live with this conceptual jitter (which you'll find on any =

RTOS with more than one job running), you have to do ahead-of-time=20
scheduling with busy waiting until the actual release date. That will=20
mean disabling IRQs for a really long time + burning a lot of CPU power. =

Kind of last resort, not generally recommended.

Jan


--------------enig22772BA851289C0955E839D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH45euniDOoMHTA+kRAuu/AJ42LSVP7WX9qQQnQkDx4IMB5U0cnwCggO36
xwpj0tE6xoIdSjIq1V6F7Wg=
=w+/d
-----END PGP SIGNATURE-----

--------------enig22772BA851289C0955E839D9--

