Message-ID: <4353F896.1040508@domain.hid>
Date: Mon, 17 Oct 2005 21:16:38 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
References: <4353F109.7000707@domain.hid>
	<4353F411.4000500@domain.hid>
In-Reply-To: <4353F411.4000500@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig205BB01472A751E61D835C21"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig205BB01472A751E61D835C21
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Heikki Lindholm wrote:
> Jan Kiszka kirjoitti:
> 
>> Hi,
>>
>> I'm dumb x86 user who unfortunately just seem to have tumbled in the
>> cross-compilation trap: I'm trying to generate i586 code on a fancy new
>> and fast x86_64 compilation host. I got the kernel compiled with
>> ARCH=i386, using only the pre-installed compiler (i.e. no dedicated
>> cross tool chain), but I failed to compile xenomai against that kernel
>> in the following. Which magic switch do I have to apply and where?
> 
> 
> As dumb a guess: -m32 compiler switch?
> 

Yes, I know, that would help. But where to feed this argument into the
build system?

Jan

--------------enig205BB01472A751E61D835C21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDU/iWncNeS9Q0k+IRAt5eAJ4yBWkZWaEBZxPzkAUMudnHvXuO5gCcD4/f
TYU016eaPplE6dB9ww7Cz6M=
=29hn
-----END PGP SIGNATURE-----

--------------enig205BB01472A751E61D835C21--

