Message-ID: <4BA74820.2090401@domain.hid>
Date: Mon, 22 Mar 2010 11:36:16 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4BA39C3D.1040802@domain.hid> <4BA4EF75.7010202@domain.hid>
In-Reply-To: <4BA4EF75.7010202@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCA6217EB41BB095D5680F42C"
Subject: Re: [Xenomai-help] crash after termination
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCA6217EB41BB095D5680F42C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 20.03.2010 16:53, schrieb Jan Kiszka:
> Stefan Kisdaroczi wrote:
>> hi all,
>>
>> after termination of my xenomai applications, my box crashed often (3 =
of 4 times) with xenomai 2.5.1.
>> Today I updated to current git-2.5, rebuilt xenomai and the kernel. St=
ill crashes.
>> I have captured two traces over a serial connection. I have attached t=
he kernel config, the two
>> traces and the cpuinfo (UP x86 Pentium III). Help is welcome. Thank yo=
u.
>=20
> Both crashes seem to be caused by corrupted skbs. There are (at least)
> two uncommon network component in your kernel: ARCNET and ISDN. Do you
> make use of them or are they just passively loaded? If the former: Can

Just passively loaded.

> you retry without them? >(The Kernel's ISDN stuff is of, well, mixed
> quality, and ARCNET is so old and uncommon that the code /may/ have
> bit-rotted -

I disable them.

> just an attempt to detract the attention from Xenomai. :) )

I think the problem is in my apps, but I had some hope that
some changes for 2.5.2 (about thread cleanup,fork) would help.

> What other network components are actively involved in your scenario?

Only TCP/IP (non-realtime). Currently a dozen xenomai native tasks are
doing standard socket calls. If everything works, there will be about
60 tasks using socket calls, but its still a long way.

I focus now first on another problem I have in my apps with a shared heap=
,
so one question about that: There was no H_NONCACHED flag at the time I
did write some library code. I use a rt_heap as shared memory between 8
processes on x86. According to the documentation H_NONCACHED is only
relevant for ARM, is that true?

Thanks for the help Jan.
Stefan


--------------enigCA6217EB41BB095D5680F42C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLp0glIPTw9rIdn6oRApCeAJ9szaQsxvTnUT0tVDKd8m3sm2lEcQCfbwAe
wnr0dc+wXVPB/XfTOjmfNKQ=
=QL1+
-----END PGP SIGNATURE-----

--------------enigCA6217EB41BB095D5680F42C--

