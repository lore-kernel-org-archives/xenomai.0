Message-ID: <4DE34223.8030505@domain.hid>
Date: Mon, 30 May 2011 09:07:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4DDE8DC9.2020905@domain.hid> <4DDF475A.5080504@domain.hid>
	<4DDFB30F.8000003@domain.hid> <4DDFB780.4010009@domain.hid>
	<4DDFBDCD.4040809@domain.hid> <4DDFEDA2.40206@domain.hid>
	<4DDFF74E.2000400@domain.hid> <4DE1078D.3090503@domain.hid>
	<20110530070322.GA3248@domain.hid>
In-Reply-To: <20110530070322.GA3248@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig676EC402474E42B5D4FCAF48"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Huge clock drift
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Pavel Machek <pma@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig676EC402474E42B5D4FCAF48
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-05-30 09:03, Pavel Machek wrote:
> On Sat 2011-05-28 16:32:45, Jan Kiszka wrote:
>> On 2011-05-27 21:11, Gilles Chanteperdrix wrote:
>>> On 05/27/2011 08:29 PM, Jonas Witt wrote:
>>>> Sorry, I missed the NTP-part. I am not using NTP. Just plain timer=20
>>>> queries on a single system.
>>>>
>>>> My clock source is tsc which is the same for Xenomai I suppose.
>>>>
>>>> I wonder how a Xenomai task, even if it occupies 50% or even 90% of =
a 4=20
>>>> milliseconds time slice can interfere with the tsc. The tsc is not=20
>>>> incremented via an interrupt, is it? But I do not know much about th=
e=20
>>>> inner workings of these functions.
>>>
>>> The problem is not the clocksource, the problem is the timer interrup=
t.
>>> The kernel expects 1 timer tick every millisecond.
>>
>> Not on archs that are CONFIG_NO_HZ capable.
>=20
> Umm. NO_HZ is only active while system is idle. Kernel will still
> expect the periodic ticks when CPU is busy....
>=20
> (I'm not sure how the compensation works; perhaps it can compensate
> even while busy..)

See update_wall_time, the !CONFIG_ARCH_USES_GETTIMEOFFSET includes no
fixed tick length.

Again, this is also important for Linux when running over hypervisors
which tend to miss ticks on overcommitment as well.

Jan


--------------enig676EC402474E42B5D4FCAF48
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk3jQiUACgkQitSsb3rl5xRZNgCfdox9QGXKR5Gv7kHbFaNywPDf
JWMAn3WlvRay9NvYG4inZtFt63VxI5GN
=aggQ
-----END PGP SIGNATURE-----

--------------enig676EC402474E42B5D4FCAF48--

