Message-ID: <4BF5726E.1020503@domain.hid>
Date: Thu, 20 May 2010 19:33:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE8A305@domain.hid>
In-Reply-To: <2319761F7FA0D1479BA77EC2E0A8E7BCE8A305@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Vera Snowball <vera.snowball@domain.hid>
Cc: xenomai@xenomai.org, haknick@domain.hid

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
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/sche=
d.h:31,
>  from
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/pod.=
h:34,
>  from /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:23:=20
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/thre=
ad.h:
> In function =C3=A2xnthread* xnthread_lookup(xnhandle_t)=C3=A2:=20
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/thre=
ad.h:431:
> error: invalid conversion from =C3=A2void*=C3=A2 to =C3=A2xnthread*=C3=A2=
 In file
> included from
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../vm/manager.h:38, from
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:25:=20
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../vm/thread.h: At
> global scope:=20
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../vm/thread.h:52:
> warning: =C3=A2typedef=C3=A2 was ignored in this declaration=20
> /usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc: In function
> =C3=A2const char* mvm_get_thread_mode(void*)=C3=A2:=20
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


