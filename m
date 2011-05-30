Message-ID: <4DE34E02.6000206@domain.hid>
Date: Mon, 30 May 2011 09:57:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4DDE8DC9.2020905@domain.hid> <4DDF475A.5080504@domain.hid>
	<4DDFB30F.8000003@domain.hid> <4DDFB780.4010009@domain.hid>
	<4DDFBDCD.4040809@domain.hid> <4DDFEDA2.40206@domain.hid>
	<4DDFF74E.2000400@domain.hid> <4DE1078D.3090503@domain.hid>
	<20110530070322.GA3248@domain.hid> <4DE34223.8030505@domain.hid>
	<4DE34AA3.2090500@domain.hid>
In-Reply-To: <4DE34AA3.2090500@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCFE4B11EC8EBD43762A0610D"
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
To: Jonas Witt <jonas.witt@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCFE4B11EC8EBD43762A0610D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-05-30 09:43, Jonas Witt wrote:
> Am 30.05.2011 09:07, schrieb Jan Kiszka:
>> On 2011-05-30 09:03, Pavel Machek wrote:
>>> On Sat 2011-05-28 16:32:45, Jan Kiszka wrote:
>>>> On 2011-05-27 21:11, Gilles Chanteperdrix wrote:
>>>>> On 05/27/2011 08:29 PM, Jonas Witt wrote:
>>>>>> Sorry, I missed the NTP-part. I am not using NTP. Just plain timer=

>>>>>> queries on a single system.
>>>>>>
>>>>>> My clock source is tsc which is the same for Xenomai I suppose.
>>>>>>
>>>>>> I wonder how a Xenomai task, even if it occupies 50% or even 90%
>>>>>> of a 4
>>>>>> milliseconds time slice can interfere with the tsc. The tsc is not=

>>>>>> incremented via an interrupt, is it? But I do not know much about =
the
>>>>>> inner workings of these functions.
>>>>> The problem is not the clocksource, the problem is the timer
>>>>> interrupt.
>>>>> The kernel expects 1 timer tick every millisecond.
>>>> Not on archs that are CONFIG_NO_HZ capable.
>>> Umm. NO_HZ is only active while system is idle. Kernel will still
>>> expect the periodic ticks when CPU is busy....
>>>
>>> (I'm not sure how the compensation works; perhaps it can compensate
>>> even while busy..)
>> See update_wall_time, the !CONFIG_ARCH_USES_GETTIMEOFFSET includes no
>> fixed tick length.
>>
>> Again, this is also important for Linux when running over hypervisors
>> which tend to miss ticks on overcommitment as well.
>>
>> Jan
>=20
> Thanks for the active discussion of the issue. I attached my config.
> CONFIG_NO_HZ is activated and I think I disabled all power management
> and frequency scaling correctly. Do you think it is worth trying a
> kernel with fixed Hz as Gilles suggested? Actually the 1ms Xenomai load=

> seems to play at least some role in the issue.

For sure, I may also be proven wrong by plain reality.

In addition, enable CONFIG_PM and ACPI with the exception of
ACPI_PROCESSOR. Who knows what your BIOS is doing in the absence of OS
support for this.

Jan


--------------enigCFE4B11EC8EBD43762A0610D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk3jTgIACgkQitSsb3rl5xQEcACeMj/kMjKBUPfSTP2oAx2NwuTI
63sAn05+D1VBUO/n9/Yh2zk+ffu8Yrz8
=TSUO
-----END PGP SIGNATURE-----

--------------enigCFE4B11EC8EBD43762A0610D--

