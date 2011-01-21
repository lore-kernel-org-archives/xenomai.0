Date: Fri, 21 Jan 2011 14:09:02 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D38886F.7060802@domain.hid>
Message-ID: <alpine.DEB.1.10.1101211400260.3495@domain.hid>
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
	<alpine.DEB.1.10.1101200922440.1211@domain.hid>
	<4D384CC9.2040303@domain.hid>
	<alpine.DEB.1.10.1101201702340.1990@domain.hid>
	<4D386922.5080807@domain.hid>
	<alpine.DEB.1.10.1101201811090.1990@domain.hid>
	<4D387148.3030306@domain.hid>
	<alpine.DEB.2.00.1101201943440.2425@domain.hid>
	<4D38886F.7060802@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463809534-1439398198-1295615342=:3495"
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809534-1439398198-1295615342=:3495
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

>>> program, since you should be using #include <pthread.h>, instead of
>>> #include <posix/pthread.h>, and more importantly, this program is
>>
>> Yes. That's an artefact of another problem which seems more toolchain-re=
lated
>> in my case. Already noted in our issue tracking system. However, I tried=
 to
>
> As reminder, the correct way to compile a xenomai posix skin program is
> described here:
> http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Co=
mpilation_flags.


It is impossible for me to use -I$(PREFIX)/include/posix so that I could si=
mply
#include <pthread.h> when using bfin-linux-uclibc-g++(!). The result whenev=
er I
just try to do something like #include <stdio.h> would be the following. It
does work when using gcc instead of g++ (but that's obviously no option for=
 C++
code)


a.c: #include <stdio.h>

bfin-linux-uclibc-g++ -D_GNU_SOURCE -D_REENTRANT -D__XENO__ \
     -I$PREFIX/usr/include -I$PREFIX/usr/include/posix -c a.c


In file included from /opt/uClinux/blackfin-linux-dist/staging/usr/include/=
nucleus/thread.h:25,
                  from /opt/uClinux/blackfin-linux-dist/staging/usr/include=
/posix/pthread.h:136,
                  from /opt/uClinux-2010R1-RC5_tools-RC4/bfin-linux-uclibc/=
bin/../bfin-linux-uclibc/runtime/usr/include/bits/uClibc_mutex.h:15,
                  from /opt/uClinux-2010R1-RC5_tools-RC4/bfin-linux-uclibc/=
bin/../bfin-linux-uclibc/runtime/usr/include/bits/uClibc_stdio.h:107,
                  from /opt/uClinux-2010R1-RC5_tools-RC4/bfin-linux-uclibc/=
bin/../bfin-linux-uclibc/runtime/usr/include/stdio.h:72,
                  from a.c:1:
/opt/uClinux/blackfin-linux-dist/staging/usr/include/nucleus/types.h: In fu=
nction =E2=80=98void xnobject_copy_name(char*, const char*)=E2=80=99:
/opt/uClinux/blackfin-linux-dist/staging/usr/include/nucleus/types.h:113: e=
rror: =E2=80=98snprintf=E2=80=99 was not declared in this scope







---1463809534-1439398198-1295615342=:3495--

