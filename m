Message-ID: <45E48E50.1030502@domain.hid>
Date: Tue, 27 Feb 2007 21:02:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45E4646A.10205@domain.hid> <45E46D67.9030600@domain.hid>
	<45E48543.8030800@domain.hid>
In-Reply-To: <45E48543.8030800@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFEEF3F15AE425CBC088BB83E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: high latency every 8 seconds
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Theo Veenker <Theo.Veenker@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFEEF3F15AE425CBC088BB83E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Theo Veenker wrote:
> Jan Kiszka wrote:
>> Theo Veenker wrote:
>>> Hi all,
>>>
>>> I'm installing xenomai 2.2.5 (kernel 2.6.17.14) on a number of
>>
>> When starting new, pick something new, i.e. 2.3 right now. Only if you=

>> have good reasons, staying at older versions is recommended.
>=20
> I would love to, but I couldn't get my software running with 2.3.
> I had to convert (a month ago) my software from RTLinux to Xenomai
> having only a few days for it. I have a kernel module and an app
> that talks to it. I use the posix skin. But with 2.3 apparently
> I had to load posixio and something (forgot) manually, but I just
> couldn't get these loaded. Since time was running out I decided
> to stay with 2.2.5 for the time being (unfortunately).

I do understand. But once your time constraints relaxed a bit, please
don't forget to post remaining issues here. Maybe they reveal some real b=
ug.

>=20
>>
>>> systems (MSI 945P, Intel P4 3Ghz). My kernel runs fine on several
>>> other/older systems, but on the new systems there is something going
>>> on every 8 seconds. See output of latency test below. What could
>>> this be? Is this an SMI effect?
>>
>> Is CONFIG_XENO_HW_SMI_WORKAROUND selected? What does the kernel output=

>> tell you about if it's working? Do you have an ICH7 chipset on your
>> board? Would be another reason to update Xenomai (2.3 takes care of it=
,
>> 2.2.x doesn't)... :)
>>
>> If this all doesn't help, have a look at this tool:
>>
>> http://www.xenomai.org/index.php/I-pipe:Tracer
>>
>> In any case, please give a feedback on the outcome.
>=20
> Thanks. I will.
>=20
> Theo
>=20

Jan


--------------enigFEEF3F15AE425CBC088BB83E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5I5QniDOoMHTA+kRAr7zAJ9eKoJU9Yim7aQKpBUbu9nH+pc+rgCdG+Vv
JLLY4OSUPX2HUvxHK87uBs0=
=McnT
-----END PGP SIGNATURE-----

--------------enigFEEF3F15AE425CBC088BB83E--

