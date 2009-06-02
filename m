Message-ID: <4A258866.1040205@domain.hid>
Date: Tue, 02 Jun 2009 22:15:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A2452CB.2030909@domain.hid> <4A2580C5.4000806@domain.hid>
In-Reply-To: <4A2580C5.4000806@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF1C9A522B914B6C67F128D75"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] How to chose between xenomai and preempt RT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Angielski <jeff@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF1C9A522B914B6C67F128D75
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Angielski wrote:
> Adrien LECOINTRE wrote:
>> Hi,
>>
>> I've been testing for a while, Xenomai and Linux preempt RT latencies =

>> under different loads and I couldn't find any big differences. Latenci=
es=20
>> are almost the same.
>> So my question is, do you know any case where Xenomai is really better=
=20
>> than a simple preempt RT?
>> Or which specification in a real time application should make me chose=
=20
>> Xenomai instead of preempt RT?
>=20
> I suspect your loads are not sufficiently exercising your system.

I may. But the question is also if the test is sufficiently close to the
final RT use case. One may think that running cyclictest alone gives the
full picture of -rt's determinism, but it only stresses one simple use
case of the kernel.

>=20
> To answer your question, though, it all depends on your requirements,=20
> whether you need hard or soft realtime.  In other words, is it ok to=20
> miss your deadline every so often?  If so, CONFIG_PREEMPT would be fine=
=20
> for you. If you can't miss any deadlines, use Xenomai.
>=20
> Of course, just by choosing to use Xenomai, you don't get hard realtime=
=2E=20
>   You still need to design your system and software correctly.
>=20
> As time marches on, the CONFIG_PREEMPT is getting closer to hard=20
> realtime, especially with the interrupt threading, but I don't think=20
> that time is now.
>=20

Theoretically, -rt/CONFIG_PREEMPT_RT can provide this already - if you
do not hit implementation problems with the particular use case, or the
application uses services which do not provide real-time qualities on -rt=
=2E

Jan


--------------enigF1C9A522B914B6C67F128D75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkoliKIACgkQniDOoMHTA+l5qQCcC7CK2o+IpQeVih6nPSTVojAX
WMMAniWcsPp5O3WvTIfaxPRLy/2VosSM
=pQpS
-----END PGP SIGNATURE-----

--------------enigF1C9A522B914B6C67F128D75--

