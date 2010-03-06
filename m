Message-ID: <4B923AC8.3070109@domain.hid>
Date: Sat, 06 Mar 2010 12:21:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B9236DD.2030900@domain.hid>
In-Reply-To: <4B9236DD.2030900@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai/asm/xenomai/syscall.h is not c99 aware
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Daniele Nicolodi wrote:
> Hello. I'm compiling my programs with the -std=3Dc99 switch. However th=
e
> inclusion of pthread.h from xenomai distribution causes the compilation=

> to fail with syntax errors.
>=20
> This simple program demonstrates the problem:
>=20
> #include <pthread.h>
>=20
> int main(int argc, char **argv)
> {
>      return 0;
> }
>=20
> If I compile it with 'gcc -std=3Dc99 $(xeno-config --posis-cflags)' i
> obtain the following errors:
>=20
> In file included from /usr/include/xenomai/nucleus/trace.h:52,
>                  from /usr/include/xenomai/nucleus/system.h:27,
>                  from /usr/include/xenomai/asm/xenomai/system_32.h:130,=

>                  from /usr/include/xenomai/asm/xenomai/system.h:2,
>                  from /usr/include/xenomai/nucleus/types.h:40,
>                  from /usr/include/xenomai/nucleus/thread.h:25,
>                  from /usr/include/xenomai/posix/pthread.h:136,
>                  from test-c99.c:1:
> /usr/include/xenomai/asm/xenomai/syscall.h:130: error: expected
> declaration specifiers or =E2=80=98...=E2=80=99 before string constant
> /usr/include/xenomai/asm/xenomai/syscall.h:130: warning: data definitio=
n
> has no type or storage class
> /usr/include/xenomai/asm/xenomai/syscall.h:130: warning: type defaults
> to =E2=80=98int=E2=80=99 in declaration of =E2=80=98asm=E2=80=99
> /usr/include/xenomai/asm/xenomai/syscall.h: In function =E2=80=98__xn_g=
et_ebp=E2=80=99:
> /usr/include/xenomai/asm/xenomai/syscall.h:173: warning: statement with=

> no effect
> /usr/include/xenomai/asm/xenomai/syscall.h:173: error: expected =E2=80=98=
;=E2=80=99
> before =E2=80=98volatile=E2=80=99
> /usr/include/xenomai/asm/xenomai/syscall.h: In function =E2=80=98__xn_r=
dtsc=E2=80=99:
> /usr/include/xenomai/asm/xenomai/syscall.h:436: warning: statement with=

> no effect
> /usr/include/xenomai/asm/xenomai/syscall.h:436: error: expected =E2=80=98=
;=E2=80=99
> before =E2=80=98volatile=E2=80=99
> In file included from /usr/include/xenomai/nucleus/system.h:27,
>                  from /usr/include/xenomai/asm/xenomai/system_32.h:130,=

>                  from /usr/include/xenomai/asm/xenomai/system.h:2,
>                  from /usr/include/xenomai/nucleus/types.h:40,
>                  from /usr/include/xenomai/nucleus/thread.h:25,
>                  from /usr/include/xenomai/posix/pthread.h:136,
>                  from test-c99.c:1:
> /usr/include/xenomai/nucleus/trace.h: In function =E2=80=98xntrace_max_=
begin=E2=80=99:
> /usr/include/xenomai/nucleus/trace.h:56: error: expected =E2=80=98;=E2=80=
=99 before
> =E2=80=98volatile=E2=80=99
> /usr/include/xenomai/nucleus/trace.h:56: warning: statement with no eff=
ect
> /usr/include/xenomai/nucleus/trace.h: In function =E2=80=98xntrace_max_=
end=E2=80=99:
> /usr/include/xenomai/nucleus/trace.h:61: error: expected =E2=80=98;=E2=80=
=99 before
> =E2=80=98volatile=E2=80=99
> /usr/include/xenomai/nucleus/trace.h:61: warning: statement with no eff=
ect
> /usr/include/xenomai/nucleus/trace.h: In function =E2=80=98xntrace_max_=
reset=E2=80=99:
> /usr/include/xenomai/nucleus/trace.h:66: error: expected =E2=80=98;=E2=80=
=99 before
> =E2=80=98volatile=E2=80=99
> /usr/include/xenomai/nucleus/trace.h:66: warning: statement with no eff=
ect
> /usr/include/xenomai/nucleus/trace.h: In function =E2=80=98xntrace_user=
_start=E2=80=99:
> /usr/include/xenomai/nucleus/trace.h:71: error: expected =E2=80=98;=E2=80=
=99 before
> =E2=80=98volatile=E2=80=99
> /usr/include/xenomai/nucleus/trace.h:71: warning: statement with no eff=
ect
> /usr/include/xenomai/nucleus/trace.h: In function =E2=80=98xntrace_user=
_stop=E2=80=99:
> /usr/include/xenomai/nucleus/trace.h:76: error: expected =E2=80=98;=E2=80=
=99 before
> =E2=80=98volatile=E2=80=99
> /usr/include/xenomai/nucleus/trace.h:76: warning: statement with no eff=
ect
> /usr/include/xenomai/nucleus/trace.h: In function =E2=80=98xntrace_user=
_freeze=E2=80=99:
> /usr/include/xenomai/nucleus/trace.h:81: error: expected =E2=80=98;=E2=80=
=99 before
> =E2=80=98volatile=E2=80=99
> /usr/include/xenomai/nucleus/trace.h:81: warning: statement with no eff=
ect
> /usr/include/xenomai/nucleus/trace.h: In function =E2=80=98xntrace_spec=
ial=E2=80=99:
> /usr/include/xenomai/nucleus/trace.h:87: error: expected =E2=80=98;=E2=80=
=99 before
> =E2=80=98volatile=E2=80=99
> /usr/include/xenomai/nucleus/trace.h:87: warning: statement with no eff=
ect
> /usr/include/xenomai/nucleus/trace.h: In function =E2=80=98xntrace_spec=
ial_u64=E2=80=99:
> /usr/include/xenomai/nucleus/trace.h:92: error: expected =E2=80=98;=E2=80=
=99 before
> =E2=80=98volatile=E2=80=99
> /usr/include/xenomai/nucleus/trace.h:92: warning: statement with no eff=
ect
>=20
> Of course i do not obtain any error it i remove the xenomai specific
> include directories options from the gcc command line.
>=20
> Can this problem be solved? Can I help somehow?

What version of Xenomai, what platforms? Chances are that Xenomai
headers contain inline assembly code and things like that which are
definitely not ansi, and we even use GNU extensions. I am afraid you
will have to compile with -std=3Dgnu99.

It probably can be made to work. But... do you realy need -std=3Dc99 ?

--=20
					    Gilles.


