Message-ID: <435409AD.6060705@domain.hid>
Date: Mon, 17 Oct 2005 22:29:33 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
References: <4353F109.7000707@domain.hid>	<4353F411.4000500@domain.hid>	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid> <435403C8.80400@domain.hid>
	<43540531.8050304@domain.hid>
	<435406E0.8020405@domain.hid>
In-Reply-To: <435406E0.8020405@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD5509AFBCB7557823D46AD67"
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
--------------enigD5509AFBCB7557823D46AD67
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> Philippe Gerum wrote:
>>
>>> Heikki Lindholm wrote:
>>>
>>>
>>>> Jan Kiszka kirjoitti:
>>>>
>>>>
>>>>> Heikki Lindholm wrote:
>>>>>
>>>>>
>>>>>> Jan Kiszka kirjoitti:
>>>>>>
>>>>>>
>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> I'm dumb x86 user who unfortunately just seem to have tumbled in the
>>>>>>> cross-compilation trap: I'm trying to generate i586 code on a fancy
>>>>>>> new
>>>>>>> and fast x86_64 compilation host. I got the kernel compiled with
>>>>>>> ARCH=i386, using only the pre-installed compiler (i.e. no dedicated
>>>>>>> cross tool chain), but I failed to compile xenomai against that
>>>>>>> kernel
>>>>>>> in the following. Which magic switch do I have to apply and where?
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> As dumb a guess: -m32 compiler switch?
>>>>>>
>>>>>
>>>>>
>>>>> Yes, I know, that would help. But where to feed this argument into the
>>>>> build system?
>>>>
>>>>
>>>>
>>>>
>>>> I would try makefile (and perhaps config/kconfig/Makefile*) and
>>>> command line 'CC="gcc -m32" CXX="gcc -m32" make menuconfig/install' to
>>>> be sure.
>>>>
>>>
>>> You should be able to do that just by reconfiguring:
>>>
>>> cd build && make reconfig CC="gcc -m32"
>>>
>>
>>
>> ... would have been too easy: :-/
>>
>> [after "make menuconfig ARCH=i386"]
>> gcchost2:/tmp/xenomai/build # make reconfig CC="gcc -m32"
>> make[1]: Entering directory `/tmp/xenomai/build'
>> configure: error: unrecognized option: -m32
>> Try `/tmp/xenomai/configure --help' for more information.
>> make[1]: *** [config.status] Error 1
>> make[1]: Leaving directory `/tmp/xenomai/build'
>> make: *** [reconfig] Error 2
>>
> 
> make reconfig CC="\"gcc -m32\""
> 

Quoting - I like it...

Ok, one step further. Now I get on "make":

[...]
make[3]: Entering directory `/tmp/xenomai/build/arch/i386/hal'
make: invalid option -- 3
make: invalid option -- 2
Usage: make [options] [target] ...
Options:
  -b, -m                      Ignored for compatibility.
[...]
This program built for x86_64-unknown-linux-gnu
Report bugs to <bug-make@domain.hid>
make[3]: *** [xeno_hal.ko] Error 2
make[3]: Leaving directory `/tmp/xenomai/build/arch/i386/hal'

> (Ok, ok, we'll get rid of autoconf for kernel modules in 2.1...)
> 

Might solve it. But meanwhile, isn't there a chance to do it as the
kernel already does within autoconf/automake?

Jan

--------------enigD5509AFBCB7557823D46AD67
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDVAmtncNeS9Q0k+IRAqepAJ408f423PBxVla1m3i7tXox/5y43gCgscWA
9hlCCWhyHhC9pN7kfFMruY0=
=sPG0
-----END PGP SIGNATURE-----

--------------enigD5509AFBCB7557823D46AD67--

