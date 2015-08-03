MIME-Version: 1.0
Date: Mon, 3 Aug 2015 16:23:09 +0300
Message-ID: <CAOLO654B2E5+oXt4X8pAoWEUmn+kCup60UQrx-WoyCHzqvhmOg@mail.gmail.com>
From: =?UTF-8?Q?Ahmet_Soyyi=C4=9Fit?= <ahmedius2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Compilation error because of macros __KERNEL__ or
	_XENO_SIM__
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

i am trying wrap posix skin of xenoai for C++. My problem is, some of the
functions in prhread.h (xenomai posix skin)  are causing me compillation
errors like this:

g++ -c -fpermissive -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-D__XENO__ -I/usr/xenomai/include/posix  ThreadXp.cpp
ThreadXp.cpp: In constructor =E2=80=98ThreadXp::ThreadXp(int, size_t, int, =
int,
int, char*, int)=E2=80=99:
ThreadXp.cpp:47:53: error: =E2=80=98pthread_attr_setschedparam_ex=E2=80=99 =
was not declared
in this scope
  pthread_attr_setschedparam_ex (&d_attr, &schedParam);
                                                     ^
ThreadXp.cpp:48:40: error: =E2=80=98pthread_attr_setname_np=E2=80=99 was no=
t declared in
this scope
  pthread_attr_setname_np(&d_attr, name );
                                        ^
ThreadXp.cpp:49:46: error: =E2=80=98pthread_attr_setfp_np=E2=80=99 was not =
declared in this
scope
  pthread_attr_setfp_np(&d_attr, floatingPoint);
                                              ^
ThreadXp.cpp: In static member function =E2=80=98static void*
ThreadXp::threadEntry(void*)=E2=80=99:
ThreadXp.cpp:198:17: warning: cast to pointer from integer of different
size [-Wint-to-pointer-cast]
  return((void *)code);
                 ^
make: *** [all] Error 1

but most of the pthread functions compile with no problem. I tried to
compile with -v option and i am including the headers of xenomai posix
skin. Inside pthread.h, the error giving functions are encapsulated like
this:

#if defined(__KERNEL__) || defined(__XENO_SIM__)

...

#else /* !(__KERNEL__ || __XENO_SIM__) */

but i my code doesnt define any of these macros. When I try to define them
with -D option, or in file, anohter compilation errors came out.

Can u help me with that?

Ahmet
Gebze Technical University
Computer Engineering Student
