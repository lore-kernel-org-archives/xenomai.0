Message-ID: <4665ACB6.50009@domain.hid>
Date: Tue, 05 Jun 2007 20:34:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <465ABD99.1090301@domain.hid> <1180630376.5020.131.camel@domain.hid>	
	<465F3277.1080400@domain.hid> <1180651652.5020.197.camel@domain.hid>	
	<465FC2FC.1010902@domain.hid> <1181032041.32137.68.camel@domain.hid>	
	<46652976.4050309@domain.hid> <1181036642.32137.79.camel@domain.hid>
	<4665A8BB.4020605@domain.hid>
In-Reply-To: <4665A8BB.4020605@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA7A6E7199227D539B66F29F9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Less invasive usystrace
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA7A6E7199227D539B66F29F9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>>>> (*) You could avoid passing the function name in the systrace calls,=
 by
>>>> relying on the value of __FUNCTION__, with a small hack to trimm the=

>>>> __wrap_ prefix when needed. Making tracepoints less hairy would ease=
 my
>>>> pain reading this stuff.
>>> OK, but let's not spend brain cycles on this until we know if and how=
 we
>>> can separate the entry/exit tracing from the traced service. If we co=
uld
>>> leave existing lib code untouched, I would be happier as well.
>>>
>> It does matter because it reduce visual clutter, and that's a
>> prerequisite for merging, that's why I'm suggesting it.
>> We already have an automated instrumentation tool for the simulator, b=
ut
>> I'm not sure automatically inserted tracepoints would always be releva=
nt
>> in all cases.
>=20
> Doesn't it rely on a patched gcc? Here is a suggestion for an
> instrumentation procedure based on standard tools:
>=20
>=20
> lib.h:
> ------
> int my_lib_func(int arg1, const char *arg2);
>=20
> lib.c:
> ------
> int my_lib_func(int arg1, const char *arg2)
> {
> 	return 13;
> }
>=20
> main.c:
> -------
> #include <stdio.h>
> #include "lib.h"
> main()
> {
> 	printf("my_lib_func =3D %d\n",
> 	       my_lib_func(1, "hello"));
> }
>=20
>=20
> So far, so ordinary. Now we add entry/exit tracing for my_lib_func:
>=20
>=20
> trace.c
> -------
> #include <stdio.h>
> #include "lib.h"
> int __trace_my_lib_func(int arg1, const char *arg2)
> {
> 	int ret;
> 	printf("entry: arg1 =3D %d, arg2 =3D %s\n", arg1, arg2);
> 	ret =3D my_lib_func(arg1, arg2);
> 	printf("exit: ret =3D %d\n", ret);
> 	return ret;
> }
>=20
> Makefile:
> ---------
> ifneq (,$(TRACE))
> TRACELIB=3Dtrace.o
> endif
>=20
> main: main.c lib.o
>=20
> lib.o: lib.c $(TRACELIB)
> 	gcc -c -o $@ $<
> ifneq (,$(TRACE))
> 	ld -r -o $@.tmp $@ $(TRACELIB)
> 	objcopy --redefine-sym my_lib_func=3D__orig_my_lib_func \
> 		--redefine-sym __trace_my_lib_func=3Dmy_lib_func $@.tmp $@

We could even build this symbol list dynamically by looking for
everything that starts with "__trace_". That way, no one would have to
maintain lists of traced functions in separated files or so.

> 	rm -f $@.tmp
> endif
>=20
> clean:
> 	rm -f *.o main
>=20
>=20
> Build with "make TRACE=3D1" to get the traced variant, or call "make" f=
or
> non-traced mode.
>=20
> This means we have a switch in the build process, we don't need to touc=
h
> the library sources. We only have to add a __trace_xxx() version for
> every xxx() that can even use original headers to call into the origina=
l
> service. Converting the Makefile stuff into something more handy for
> autotools shouldn't be tricky.
>=20
> There is just one no-go: functions with variable argument lists.
> Fortunately, the only one that comes into my mind right now,
> [rtdm_]ioctl(), has a single well-known "unknown" argument and needs to=

> be unrolled unconditionally anyway.
>=20
> What do you think?
>=20
> Jan
>=20


--------------enigA7A6E7199227D539B66F29F9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZay2niDOoMHTA+kRAkv8AJ41IoC+dq64b6QW8r2Ph84jj5V1VwCggHt+
8wEKm32Vs30nL+NRQncnNzA=
=b2c8
-----END PGP SIGNATURE-----

--------------enigA7A6E7199227D539B66F29F9--

