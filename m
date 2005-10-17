Message-ID: <435419B0.8030004@domain.hid>
Date: Mon, 17 Oct 2005 23:37:52 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
References: <4353F109.7000707@domain.hid>	<4353F411.4000500@domain.hid>	<4353F896.1040508@domain.hid>	<435402B4.5060004@domain.hid>
	<435403C8.80400@domain.hid>	<43540531.8050304@domain.hid>
	<435406E0.8020405@domain.hid> <435408E5.8020007@domain.hid>
In-Reply-To: <435408E5.8020007@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8E782A336EA86F297BEE8B42"
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
--------------enig8E782A336EA86F297BEE8B42
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Philippe Gerum wrote:
> 
>> Jan Kiszka wrote:
>>
>>> Philippe Gerum wrote:
>>>
>>>> Heikki Lindholm wrote:
>>>>
>>>>
>>>>> Jan Kiszka kirjoitti:
>>>>>
>>>>>
>>>>>> Heikki Lindholm wrote:
>>>>>>
>>>>>>
>>>>>>> Jan Kiszka kirjoitti:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I'm dumb x86 user who unfortunately just seem to have tumbled in
>>>>>>>> the
>>>>>>>> cross-compilation trap: I'm trying to generate i586 code on a fancy
>>>>>>>> new
>>>>>>>> and fast x86_64 compilation host. I got the kernel compiled with
>>>>>>>> ARCH=i386, using only the pre-installed compiler (i.e. no dedicated
>>>>>>>> cross tool chain), but I failed to compile xenomai against that
>>>>>>>> kernel
>>>>>>>> in the following. Which magic switch do I have to apply and where?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> As dumb a guess: -m32 compiler switch?
>>>>>>>
>>>>>>
>>>>>>
>>>>>> Yes, I know, that would help. But where to feed this argument into
>>>>>> the
>>>>>> build system?
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> I would try makefile (and perhaps config/kconfig/Makefile*) and
>>>>> command line 'CC="gcc -m32" CXX="gcc -m32" make menuconfig/install' to
>>>>> be sure.
>>>>>
>>>>
>>>> You should be able to do that just by reconfiguring:
>>>>
>>>> cd build && make reconfig CC="gcc -m32"
>>>>
>>>
>>>
>>> ... would have been too easy: :-/
>>>
>>> [after "make menuconfig ARCH=i386"]
>>> gcchost2:/tmp/xenomai/build # make reconfig CC="gcc -m32"
>>> make[1]: Entering directory `/tmp/xenomai/build'
>>> configure: error: unrecognized option: -m32
>>> Try `/tmp/xenomai/configure --help' for more information.
>>> make[1]: *** [config.status] Error 1
>>> make[1]: Leaving directory `/tmp/xenomai/build'
>>> make: *** [reconfig] Error 2
>>>
>>
>> make reconfig CC="\"gcc -m32\""
>>
> 
> Please resync from the SVN head too; I've added the necessary quoting
> hackery for the above to fully work.
> 

Great, thanks.

Now I likely run into some gcc-4 issue:

make[3]: Entering directory `/tmp/xenomai/build/skins/native/lib'
if /bin/sh ../../../libtool --mode=compile --tag=CC gcc -m32
-DHAVE_CONFIG_H -I. -I/tmp/xenomai/skins/native/lib -I../../../include
-O2 -I/tmp/linux-2.6.13.1/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__
 -march=i586 -Wall -pipe -fstrict-aliasing -Wno-strict-aliasing
-D__IN_XENO__ -Wstrict-prototypes -I../../../include
-I/tmp/xenomai/include -I/tmp/xenomai/skins/native/lib/../..    -MT
libnative_la-task.lo -MD -MP -MF ".deps/libnative_la-task.Tpo" -c -o
libnative_la-task.lo `test -f 'task.c' || echo
'/tmp/xenomai/skins/native/lib/'`task.c; \
then mv -f ".deps/libnative_la-task.Tpo" ".deps/libnative_la-task.Plo";
else rm -f ".deps/libnative_la-task.Tpo"; exit 1; fi
 gcc -m32 -DHAVE_CONFIG_H -I. -I/tmp/xenomai/skins/native/lib
-I../../../include -O2 -I/tmp/linux-2.6.13.1/include -D_GNU_SOURCE
-D_REENTRANT -D__XENO__ -march=i586 -Wall -pipe -fstrict-aliasing
-Wno-strict-aliasing -D__IN_XENO__ -Wstrict-prototypes
-I../../../include -I/tmp/xenomai/include
-I/tmp/xenomai/skins/native/lib/../.. -MT libnative_la-task.lo -MD -MP
-MF .deps/libnative_la-task.Tpo -c /tmp/xenomai/skins/native/lib/task.c
 -fPIC -DPIC -o .libs/libnative_la-task.o
In file included from /tmp/linux-2.6.13.1/include/asm/math_emu.h:4,
                 from /tmp/linux-2.6.13.1/include/asm/processor.h:11,
                 from /tmp/linux-2.6.13.1/include/asm/atomic.h:6,
                 from ../../../include/nucleus/asm/atomic.h:44,
                 from /tmp/xenomai/include/nucleus/system.h:33,
                 from /tmp/xenomai/include/nucleus/asm-generic/system.h:560,
                 from ../../../include/nucleus/asm/system.h:25,
                 from /tmp/xenomai/include/nucleus/types.h:40,
                 from /tmp/xenomai/include/nucleus/queue.h:23,
                 from /tmp/xenomai/include/nucleus/timer.h:23,
                 from /tmp/xenomai/include/nucleus/thread.h:23,
                 from /tmp/xenomai/skins/native/lib/../../native/task.h:26,
                 from /tmp/xenomai/skins/native/lib/task.c:28:
/tmp/linux-2.6.13.1/include/asm/sigcontext.h:20: error: redefinition of
struct _fpreg
/tmp/linux-2.6.13.1/include/asm/sigcontext.h:25: error: redefinition of
struct _fpxreg
/tmp/linux-2.6.13.1/include/asm/sigcontext.h:31: error: redefinition of
struct _xmmreg
/tmp/linux-2.6.13.1/include/asm/sigcontext.h:35: error: redefinition of
struct _fpstate
/tmp/linux-2.6.13.1/include/asm/sigcontext.h:59: error: redefinition of
struct sigcontext

Any idea where this comes from? If not, I will dig deeper.

Jan

--------------enig8E782A336EA86F297BEE8B42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDVBmwncNeS9Q0k+IRApLGAKDiQGc6UKJXfIpe118pXpEXCi/xMACeMZhX
GdDWyRDf9YBPoq8Ka8BjISs=
=vOaz
-----END PGP SIGNATURE-----

--------------enig8E782A336EA86F297BEE8B42--

