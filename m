Message-ID: <4354AD5A.7010305@domain.hid>
Date: Tue, 18 Oct 2005 10:07:54 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
References: <4353F109.7000707@domain.hid>	<4353F411.4000500@domain.hid>	<4353F896.1040508@domain.hid>	<435402B4.5060004@domain.hid>
	<435403C8.80400@domain.hid>	<43540531.8050304@domain.hid>
	<435406E0.8020405@domain.hid> <435408E5.8020007@domain.hid>
	<435419B0.8030004@domain.hid>
In-Reply-To: <435419B0.8030004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigABB44D8F1260E43EEE53B606"
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
--------------enigABB44D8F1260E43EEE53B606
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> ...
> make[3]: Entering directory `/tmp/xenomai/build/skins/native/lib'
> if /bin/sh ../../../libtool --mode=compile --tag=CC gcc -m32
> -DHAVE_CONFIG_H -I. -I/tmp/xenomai/skins/native/lib -I../../../include
> -O2 -I/tmp/linux-2.6.13.1/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__
>  -march=i586 -Wall -pipe -fstrict-aliasing -Wno-strict-aliasing
> -D__IN_XENO__ -Wstrict-prototypes -I../../../include
> -I/tmp/xenomai/include -I/tmp/xenomai/skins/native/lib/../..    -MT
> libnative_la-task.lo -MD -MP -MF ".deps/libnative_la-task.Tpo" -c -o
> libnative_la-task.lo `test -f 'task.c' || echo
> '/tmp/xenomai/skins/native/lib/'`task.c; \
> then mv -f ".deps/libnative_la-task.Tpo" ".deps/libnative_la-task.Plo";
> else rm -f ".deps/libnative_la-task.Tpo"; exit 1; fi
>  gcc -m32 -DHAVE_CONFIG_H -I. -I/tmp/xenomai/skins/native/lib
> -I../../../include -O2 -I/tmp/linux-2.6.13.1/include -D_GNU_SOURCE
> -D_REENTRANT -D__XENO__ -march=i586 -Wall -pipe -fstrict-aliasing
> -Wno-strict-aliasing -D__IN_XENO__ -Wstrict-prototypes
> -I../../../include -I/tmp/xenomai/include
> -I/tmp/xenomai/skins/native/lib/../.. -MT libnative_la-task.lo -MD -MP
> -MF .deps/libnative_la-task.Tpo -c /tmp/xenomai/skins/native/lib/task.c
>  -fPIC -DPIC -o .libs/libnative_la-task.o
> In file included from /tmp/linux-2.6.13.1/include/asm/math_emu.h:4,
>                  from /tmp/linux-2.6.13.1/include/asm/processor.h:11,
>                  from /tmp/linux-2.6.13.1/include/asm/atomic.h:6,
>                  from ../../../include/nucleus/asm/atomic.h:44,
>                  from /tmp/xenomai/include/nucleus/system.h:33,
>                  from /tmp/xenomai/include/nucleus/asm-generic/system.h:560,
>                  from ../../../include/nucleus/asm/system.h:25,
>                  from /tmp/xenomai/include/nucleus/types.h:40,
>                  from /tmp/xenomai/include/nucleus/queue.h:23,
>                  from /tmp/xenomai/include/nucleus/timer.h:23,
>                  from /tmp/xenomai/include/nucleus/thread.h:23,
>                  from /tmp/xenomai/skins/native/lib/../../native/task.h:26,
>                  from /tmp/xenomai/skins/native/lib/task.c:28:
> /tmp/linux-2.6.13.1/include/asm/sigcontext.h:20: error: redefinition of
> struct _fpreg
> /tmp/linux-2.6.13.1/include/asm/sigcontext.h:25: error: redefinition of
> struct _fpxreg
> /tmp/linux-2.6.13.1/include/asm/sigcontext.h:31: error: redefinition of
> struct _xmmreg
> /tmp/linux-2.6.13.1/include/asm/sigcontext.h:35: error: redefinition of
> struct _fpstate
> /tmp/linux-2.6.13.1/include/asm/sigcontext.h:59: error: redefinition of
> struct sigcontext
> 
> Any idea where this comes from? If not, I will dig deeper.
> 

I just analysed this further: the problem disappears when I manually
remove any "-I<path-to-kernel-includes>" from the makefiles. Seems to be
the well-known user space include issue again... ;)

Jan

--------------enigABB44D8F1260E43EEE53B606
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDVK1ancNeS9Q0k+IRAqMuAJ0T4BKD4soBP29DFaWciT5QZykWewCgv2VR
S37mSmb7aLYBbcF/WJO7aeY=
=wyA8
-----END PGP SIGNATURE-----

--------------enigABB44D8F1260E43EEE53B606--

