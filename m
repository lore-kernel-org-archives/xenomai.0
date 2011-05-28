Message-ID: <4DE1078D.3090503@domain.hid>
Date: Sat, 28 May 2011 16:32:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4DDE8DC9.2020905@domain.hid>	<4DDF475A.5080504@domain.hid>	<4DDFB30F.8000003@domain.hid>	<4DDFB780.4010009@domain.hid>
	<4DDFBDCD.4040809@domain.hid>	<4DDFEDA2.40206@domain.hid>
	<4DDFF74E.2000400@domain.hid>
In-Reply-To: <4DDFF74E.2000400@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB21159599B1FBEE81479B02C"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jonas Witt <jonas.witt@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB21159599B1FBEE81479B02C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-05-27 21:11, Gilles Chanteperdrix wrote:
> On 05/27/2011 08:29 PM, Jonas Witt wrote:
>> Sorry, I missed the NTP-part. I am not using NTP. Just plain timer=20
>> queries on a single system.
>>
>> My clock source is tsc which is the same for Xenomai I suppose.
>>
>> I wonder how a Xenomai task, even if it occupies 50% or even 90% of a =
4=20
>> milliseconds time slice can interfere with the tsc. The tsc is not=20
>> incremented via an interrupt, is it? But I do not know much about the =

>> inner workings of these functions.
>=20
> The problem is not the clocksource, the problem is the timer interrupt.=

> The kernel expects 1 timer tick every millisecond.

Not on archs that are CONFIG_NO_HZ capable.

> When you run a
> real-time task during 2 milliseconds and prevent the kernel from
> receiving the timer interrupts, you certainly disrupt its timekeeping.
> If you want to do this, switch the Linux kernel frequency (CONFIG_HZ) t=
o
> 100.

Time keeping can perfectly bridge a lot of missing ticks as far as the
underlying clocksource allows. And that's quite a bit with the x86 TSC.

I wonder if the TSC is sufficiently stable here. Forgot to disable
CONFIG_CPU_FREQ? How does your .config look like?

Jan


--------------enigB21159599B1FBEE81479B02C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk3hB5EACgkQitSsb3rl5xSiaACfTOBIieZcs9yAbuiH+ym6cfU3
BYkAniUEn1/YOVFQgJDFNYmjFD2TC8qK
=lDFR
-----END PGP SIGNATURE-----

--------------enigB21159599B1FBEE81479B02C--

