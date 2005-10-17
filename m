Message-ID: <43540531.8050304@domain.hid>
Date: Mon, 17 Oct 2005 22:10:25 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
References: <4353F109.7000707@domain.hid>	<4353F411.4000500@domain.hid>	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid> <435403C8.80400@domain.hid>
In-Reply-To: <435403C8.80400@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig51CC5B1E34C6C41BD0746D42"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig51CC5B1E34C6C41BD0746D42
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Heikki Lindholm wrote:
> 
>> Jan Kiszka kirjoitti:
>>
>>> Heikki Lindholm wrote:
>>>
>>>> Jan Kiszka kirjoitti:
>>>>
>>>>
>>>>> Hi,
>>>>>
>>>>> I'm dumb x86 user who unfortunately just seem to have tumbled in the
>>>>> cross-compilation trap: I'm trying to generate i586 code on a fancy
>>>>> new
>>>>> and fast x86_64 compilation host. I got the kernel compiled with
>>>>> ARCH=i386, using only the pre-installed compiler (i.e. no dedicated
>>>>> cross tool chain), but I failed to compile xenomai against that kernel
>>>>> in the following. Which magic switch do I have to apply and where?
>>>>
>>>>
>>>>
>>>>
>>>> As dumb a guess: -m32 compiler switch?
>>>>
>>>
>>>
>>> Yes, I know, that would help. But where to feed this argument into the
>>> build system?
>>
>>
>>
>> I would try makefile (and perhaps config/kconfig/Makefile*) and
>> command line 'CC="gcc -m32" CXX="gcc -m32" make menuconfig/install' to
>> be sure.
>>
> 
> You should be able to do that just by reconfiguring:
> 
> cd build && make reconfig CC="gcc -m32"
> 

... would have been too easy: :-/

[after "make menuconfig ARCH=i386"]
gcchost2:/tmp/xenomai/build # make reconfig CC="gcc -m32"
make[1]: Entering directory `/tmp/xenomai/build'
configure: error: unrecognized option: -m32
Try `/tmp/xenomai/configure --help' for more information.
make[1]: *** [config.status] Error 1
make[1]: Leaving directory `/tmp/xenomai/build'
make: *** [reconfig] Error 2

Jan

--------------enig51CC5B1E34C6C41BD0746D42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDVAUyncNeS9Q0k+IRAiQFAJ9E7u3JGU6nfxOxZZx6/l8aDMaS5gCePTDE
Um6TSOTYP9CImR/XUaT85gs=
=5Upg
-----END PGP SIGNATURE-----

--------------enig51CC5B1E34C6C41BD0746D42--

