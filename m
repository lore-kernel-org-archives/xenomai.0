Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 May 2010 17:25:47 -0700
Message-ID: <2319761F7FA0D1479BA77EC2E0A8E7BCE8A37A@alpine.pivotalsys.com>
In-Reply-To: <4BF5726E.1020503@domain.hid>
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

OK, finally got a change to come back to this.
I do use the proper version of gcc source code:

[root@domain.hid]# gcc --version
gcc (GCC) 4.3.0 20080428 (Red Hat 4.3.0-8)
Copyright (C) 2008 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is =
NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE.

[root@domain.hid]# ll ../gcc-src-4.3.0/
total 57996
-rwx------ 1 root root 59321957 2010-05-17 15:31 gcc-4.3.0.tar.bz2

Is anything else I can do/check/install to make xenosim to compile?


Thanks a lot in advance,
Vera



-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Thursday, May 20, 2010 10:34 AM
To: Vera Snowball
Cc: haknick@domain.hid; xenomai@xenomai.org
Subject: Re: [Xenomai-help] xenomai, skins, design and a practical =
approach

Vera Snowball wrote:
> We do use native skin. The reason I'm trying to compile xenosim
> simulator is because I found that this is the only way to test
> xenomai app with valgrind. Although I'm having an issue with the
> compilation during 'make install' (I posted this question as well):
>=20
> make[1]: Leaving directory
> `/usr/src/xenomai-2.5.1/xenosim-2.4.7/Build_/vm' Making install in
> adapter make[1]: Entering directory
> `/usr/src/xenomai-2.5.1/xenosim-2.4.7/Build_/adapter' g++
> -DHAVE_CONFIG_H -I. -I/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter
> -I../include -D__XENO_SIM__ -fno-exceptions
> -I/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/..
> -I/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include    -O2
> -MT adapter.o -MD -MP -MF .deps/adapter.Tpo -c -o adapter.o
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc In file
> included from
> =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/sched.=
h:31,
>  from
> =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/pod.h:=
34,
>  from /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:23:=20
> =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/thread=
.h:
> In function =E2xnthread* xnthread_lookup(xnhandle_t)=E2:=20
> =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/thread=
.h:431:
> error: invalid conversion from =E2void*=E2 to =E2xnthread*=E2 In file
> included from
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../vm/manager.h:38, from
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:25:=20
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../vm/thread.h: At
> global scope:=20
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../vm/thread.h:52:
> warning: =E2typedef=E2 was ignored in this declaration=20
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc: In function
> =E2const char* mvm_get_thread_mode(void*)=E2:=20
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:65: error:
> too few arguments to function=20
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:67: error:
> too few arguments to function make[1]: *** [adapter.o] Error 1=20
> make[1]: Leaving directory
> `/usr/src/xenomai-2.5.1/xenosim-2.4.7/Build_/adapter' make: ***
> [install-recursive] Error 1

You are probably using a too recent version of gcc.

>=20
> If you have any suggestion on how to run the xenomai app with
> valgrind, it would be great to know it. I got syscall 555 error by
> trying to run our app with valgrind in a usual way (w/o xenosim).

As I told you, the only practical way is to have a way to compile your
application for using plain Linux services. If you are using the posix
skin, it is easy, if you are using the native skin, it is a bit harder,
but not impossible.

--=20
					    Gilles.


