Message-ID: <4B9236DD.2030900@domain.hid>
Date: Sat, 06 Mar 2010 12:05:01 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] xenomai/asm/xenomai/syscall.h is not c99 aware
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello. I'm compiling my programs with the -std=3Dc99 switch. However the
inclusion of pthread.h from xenomai distribution causes the compilation
to fail with syntax errors.

This simple program demonstrates the problem:

#include <pthread.h>

int main(int argc, char **argv)
{
     return 0;
}

If I compile it with 'gcc -std=3Dc99 $(xeno-config --posis-cflags)' i
obtain the following errors:

In file included from /usr/include/xenomai/nucleus/trace.h:52,
                 from /usr/include/xenomai/nucleus/system.h:27,
                 from /usr/include/xenomai/asm/xenomai/system_32.h:130,
                 from /usr/include/xenomai/asm/xenomai/system.h:2,
                 from /usr/include/xenomai/nucleus/types.h:40,
                 from /usr/include/xenomai/nucleus/thread.h:25,
                 from /usr/include/xenomai/posix/pthread.h:136,
                 from test-c99.c:1:
/usr/include/xenomai/asm/xenomai/syscall.h:130: error: expected
declaration specifiers or =91...=92 before string constant
/usr/include/xenomai/asm/xenomai/syscall.h:130: warning: data definition
has no type or storage class
/usr/include/xenomai/asm/xenomai/syscall.h:130: warning: type defaults
to =91int=92 in declaration of =91asm=92
/usr/include/xenomai/asm/xenomai/syscall.h: In function =91__xn_get_ebp=92=
:
/usr/include/xenomai/asm/xenomai/syscall.h:173: warning: statement with
no effect
/usr/include/xenomai/asm/xenomai/syscall.h:173: error: expected =91;=92
before =91volatile=92
/usr/include/xenomai/asm/xenomai/syscall.h: In function =91__xn_rdtsc=92:
/usr/include/xenomai/asm/xenomai/syscall.h:436: warning: statement with
no effect
/usr/include/xenomai/asm/xenomai/syscall.h:436: error: expected =91;=92
before =91volatile=92
In file included from /usr/include/xenomai/nucleus/system.h:27,
                 from /usr/include/xenomai/asm/xenomai/system_32.h:130,
                 from /usr/include/xenomai/asm/xenomai/system.h:2,
                 from /usr/include/xenomai/nucleus/types.h:40,
                 from /usr/include/xenomai/nucleus/thread.h:25,
                 from /usr/include/xenomai/posix/pthread.h:136,
                 from test-c99.c:1:
/usr/include/xenomai/nucleus/trace.h: In function =91xntrace_max_begin=92=
:
/usr/include/xenomai/nucleus/trace.h:56: error: expected =91;=92 before
=91volatile=92
/usr/include/xenomai/nucleus/trace.h:56: warning: statement with no effec=
t
/usr/include/xenomai/nucleus/trace.h: In function =91xntrace_max_end=92:
/usr/include/xenomai/nucleus/trace.h:61: error: expected =91;=92 before
=91volatile=92
/usr/include/xenomai/nucleus/trace.h:61: warning: statement with no effec=
t
/usr/include/xenomai/nucleus/trace.h: In function =91xntrace_max_reset=92=
:
/usr/include/xenomai/nucleus/trace.h:66: error: expected =91;=92 before
=91volatile=92
/usr/include/xenomai/nucleus/trace.h:66: warning: statement with no effec=
t
/usr/include/xenomai/nucleus/trace.h: In function =91xntrace_user_start=92=
:
/usr/include/xenomai/nucleus/trace.h:71: error: expected =91;=92 before
=91volatile=92
/usr/include/xenomai/nucleus/trace.h:71: warning: statement with no effec=
t
/usr/include/xenomai/nucleus/trace.h: In function =91xntrace_user_stop=92=
:
/usr/include/xenomai/nucleus/trace.h:76: error: expected =91;=92 before
=91volatile=92
/usr/include/xenomai/nucleus/trace.h:76: warning: statement with no effec=
t
/usr/include/xenomai/nucleus/trace.h: In function =91xntrace_user_freeze=92=
:
/usr/include/xenomai/nucleus/trace.h:81: error: expected =91;=92 before
=91volatile=92
/usr/include/xenomai/nucleus/trace.h:81: warning: statement with no effec=
t
/usr/include/xenomai/nucleus/trace.h: In function =91xntrace_special=92:
/usr/include/xenomai/nucleus/trace.h:87: error: expected =91;=92 before
=91volatile=92
/usr/include/xenomai/nucleus/trace.h:87: warning: statement with no effec=
t
/usr/include/xenomai/nucleus/trace.h: In function =91xntrace_special_u64=92=
:
/usr/include/xenomai/nucleus/trace.h:92: error: expected =91;=92 before
=91volatile=92
/usr/include/xenomai/nucleus/trace.h:92: warning: statement with no effec=
t

Of course i do not obtain any error it i remove the xenomai specific
include directories options from the gcc command line.

Can this problem be solved? Can I help somehow?

Thanks. Cheers,
--=20
Daniele

