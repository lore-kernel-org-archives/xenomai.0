Message-ID: <4DE2685D.5010807@domain.hid>
Date: Sun, 29 May 2011 17:38:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4DDE8DC9.2020905@domain.hid>	<4DDF475A.5080504@domain.hid>	<4DDFB30F.8000003@domain.hid>	<4DDFB780.4010009@domain.hid>
	<4DDFBDCD.4040809@domain.hid>	<4DDFEDA2.40206@domain.hid>
	<4DDFF74E.2000400@domain.hid> <4DE1078D.3090503@domain.hid>
	<4DE1724A.2040400@domain.hid>
In-Reply-To: <4DE1724A.2040400@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE995261FB95ACE3ABB02936C"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE995261FB95ACE3ABB02936C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-05-29 00:08, Gilles Chanteperdrix wrote:
> On 05/28/2011 04:32 PM, Jan Kiszka wrote:
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
> Last time I looked at CONFIG_NO_HZ, it did not look as Xenomai one-shot=

> timer at all. The system still had a periodic timer ticking HZ times by=

> second, in order to handle the non-high resolution timers. And this
> timing was entirely disabled only when the system was idle. So, in othe=
r
> word, the Linux kernel still needed a periodic timer interrupt.

Linux (with some architectural exceptions) no longer needs high-rate
timer ticks for time keeping. Of course, if you miss timer events due to
high Xenomai activity (or overload of the host machine when running as a
VM), that's not good for reactivity and may have other side effects.

>=20
>>
>>> When you run a
>>> real-time task during 2 milliseconds and prevent the kernel from
>>> receiving the timer interrupts, you certainly disrupt its timekeeping=
=2E
>>> If you want to do this, switch the Linux kernel frequency (CONFIG_HZ)=
 to
>>> 100.
>>
>> Time keeping can perfectly bridge a lot of missing ticks as far as the=

>> underlying clocksource allows. And that's quite a bit with the x86 TSC=
=2E
>=20
> Here, we are asking it to only receive one interrupt over two. I have t=
o
> admit that I talked without testing, but as long as we do not test the
> kernel behaviour in order to test whether it allows such disruption, I
> find it safer to advise people not to disrupt it.

I'm not suggesting people can now safely write RT hogs. But I don't
think the overload scenario here should be responsible for the clock drif=
t.

Jan


--------------enigE995261FB95ACE3ABB02936C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk3iaF0ACgkQitSsb3rl5xTMHQCgx8vMvOM0z5H9HiXeekV1w0hR
RJoAn0pqOw3CPFLuR2BXpVWgOoG+TFAh
=fxrP
-----END PGP SIGNATURE-----

--------------enigE995261FB95ACE3ABB02936C--

