Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 May 2010 10:07:53 -0700
Message-ID: <2319761F7FA0D1479BA77EC2E0A8E7BCE8A305@domain.hid>
In-Reply-To: <4BF519D8.5010302@domain.hid>
From: "Vera Snowball" <vera.snowball@domain.hid>
Subject: Re: [Xenomai-help] xenomai, skins, design and a practical approach
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, haknick@domain.hid

We do use native skin.
The reason I'm trying to compile xenosim simulator is because I found =
that this is the only way to test xenomai app with valgrind. Although =
I'm having an issue with the compilation during 'make install' (I posted =
this question as well):

make[1]: Leaving directory =
`/usr/src/xenomai-2.5.1/xenosim-2.4.7/Build_/vm'
Making install in adapter
make[1]: Entering directory =
`/usr/src/xenomai-2.5.1/xenosim-2.4.7/Build_/adapter'
g++ -DHAVE_CONFIG_H -I. -I/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter =
-I../include -D__XENO_SIM__ -fno-exceptions =
-I/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/.. =
-I/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include    -O2 -MT =
adapter.o -MD -MP -MF .deps/adapter.Tpo -c -o adapter.o =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc
In file included from =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/sched.=
h:31,
                 from =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/pod.h:=
34,
                 from =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:23:
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/thread=
.h: In function =E2xnthread* xnthread_lookup(xnhandle_t)=E2:
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/thread=
.h:431: error: invalid conversion from =E2void*=E2 to =E2xnthread*=E2
In file included from =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../vm/manager.h:38,
                 from =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:25:
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../vm/thread.h: At global =
scope:
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../vm/thread.h:52: warning: =
=E2typedef=E2 was ignored in this declaration
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc: In function =
=E2const char* mvm_get_thread_mode(void*)=E2:
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:65: error: too =
few arguments to function
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:67: error: too =
few arguments to function
make[1]: *** [adapter.o] Error 1
make[1]: Leaving directory =
`/usr/src/xenomai-2.5.1/xenosim-2.4.7/Build_/adapter'
make: *** [install-recursive] Error 1

If you have any suggestion on how to run the xenomai app with valgrind, =
it would be great to know it. I got syscall 555 error by trying to run =
our app with valgrind in a usual way (w/o xenosim).

Any help is much appreciated.


Best Regards,
Vera


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Thursday, May 20, 2010 4:16 AM
To: Vera Snowball
Cc: haknick@domain.hid; xenomai@xenomai.org
Subject: Re: [Xenomai-help] xenomai, skins, design and a practical =
approach

Vera Snowball wrote:
> Sounds good to me. Does it include by any chance a chapter on how to
> work with Xenosim simulator? Looks like it is the only simulator which
> can be used for debugging with valgrind. If you made it work, it would
> be great to know how.

Xenosim requires an old 32 bits installation to be compiled, so, it may
not be straightforward to use it.

If what you want to debug with valgrind is your application and not
Xenomai, you can arrange to compile your application for Linux pthreads,
and you will be able to debug it. If you are using the POSIX skin, it
should be easy. If you are using a legacy skin, such as vxworks, psos,
uitron, etc... we already have support for running them on plain linux
with the xenomai-solo package. Only if you are using the native skin it
will be a little harder.

--=20
					    Gilles.

