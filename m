MIME-Version: 1.0
Date: Sun, 3 Jun 2012 22:19:24 +0530
Message-ID: <CACPB503JOt6DV1GP_gt0xcR_fz2owgiQow1O2uYKRpn_udDghA@mail.gmail.com>
From: Parthasarathy S <ask.partha@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] error while compiling trivial-periodic.c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

Recently I installed xenomai on a board with Intel Atom D525 processor.
After completing the installation, as suggested by the Quick Install Guide,
I ran 'make' from the xenomai-2.6.0/examples/native folder. I see the
following error message. Can any one help.

--xeno-cflags is deprecated, use --skin=3Dname --cflags instead
--xeno-ldflags is deprecated, use --skin=3Dname --ldflags instead
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall
-Werror-implicit-function-declaration -pipe -D__XENO__   -L/usr/xenomai/lib
-lxenomai -lpthread -lrt  -lnative -Xlinker -rpath -Xlinker
/usr/xenomai/lib  trivial-periodic.c   -o trivial-periodic
trivial-periodic.c: In function =91main=92:
trivial-periodic.c:72:1: warning: control reaches end of non-void function
[-Wreturn-type]
/tmp/ccvb7ii0.o: In function `demo':
trivial-periodic.c:(.text+0x2f): undefined reference to
`rt_task_set_periodic'
trivial-periodic.c:(.text+0x34): undefined reference to `rt_timer_read'
trivial-periodic.c:(.text+0x46): undefined reference to
`rt_task_wait_period'
trivial-periodic.c:(.text+0x4b): undefined reference to `rt_timer_read'
/tmp/ccvb7ii0.o: In function `main':
trivial-periodic.c:(.text+0x133): undefined reference to `rt_task_create'
trivial-periodic.c:(.text+0x14f): undefined reference to `rt_task_start'
trivial-periodic.c:(.text+0x160): undefined reference to `rt_task_delete'
collect2: ld returned 1 exit status
make: *** [trivial-periodic] Error 1

--=20
Parthasarathy S
C612 Sena Vihar
Kammanahalli Main Road
Bangalore 560043 India
