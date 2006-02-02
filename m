Message-ID: <43E28991.80509@domain.hid>
Date: Thu, 02 Feb 2006 15:37:05 -0700
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] xenomai posix build errs
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


build error after selecting POSIX interface,
on svn-head - ie 515

[jimc@domain.hid linux-2.6.15.1-ipipe-103-sonyI]$ make
CHK include/linux/version.h
SPLIT include/linux/autoconf.h -> include/config/*
CHK include/linux/compile.h
CHK usr/initramfs_list
CC [M] kernel/xenomai/skins/posix/sched.o
In file included from kernel/xenomai/skins/posix/../posix/internal.h:24,
from kernel/xenomai/skins/posix/../posix/thread.h:23,
from kernel/xenomai/skins/posix/sched.c:19:
include/xenomai/posix/posix.h:43:19: error: errno.h: No such file or=20
directory
include/xenomai/posix/posix.h:44:21: error: pthread.h: No such file or=20
directory
include/xenomai/posix/posix.h:45:19: error: sched.h: No such file or=20
directory
include/xenomai/posix/posix.h:46:20: error: signal.h: No such file or=20
directory
include/xenomai/posix/posix.h:47:23: error: semaphore.h: No such file or=20
directory
include/xenomai/posix/posix.h:48:20: error: mqueue.h: No such file or=20
directory
include/xenomai/posix/posix.h:49:18: error: time.h: No such file or=20
directory
include/xenomai/posix/posix.h:50:19: error: fcntl.h: No such file or=20
directory
include/xenomai/posix/posix.h:51:20: error: unistd.h: No such file or=20
directory
include/xenomai/posix/posix.h:52:22: error: sys/mman.h: No such file or=20
directory
include/xenomai/posix/posix.h:53:23: error: sys/ioctl.h: No such file or=20
directory
include/xenomai/posix/posix.h:54:24: error: sys/socket.h: No such file=20
or directory
In file included from kernel/xenomai/skins/posix/sched.c:19:
kernel/xenomai/skins/posix/../posix/thread.h:61: error: syntax error=20
before =91pthread_attr_t=92
kernel/xenomai/skins/posix/../posix/thread.h:61: warning: no semicolon=20
at end of struct or union
kernel/xenomai/skins/posix/../posix/thread.h:72: error: syntax error=20
before =91:=92 token
kernel/xenomai/skins/posix/../posix/thread.h:73: error: syntax error=20
before =91:=92 token
kernel/xenomai/skins/posix/../posix/thread.h:74: error: syntax error=20
before =91:=92 token
kernel/xenomai/skins/posix/../posix/thread.h:86: error:=20
=91PTHREAD_KEYS_MAX=92 undeclared here (not in a function)
kernel/xenomai/skins/posix/../posix/thread.h:94: error: syntax error=20
before =91}=92 token
kernel/xenomai/skins/posix/../posix/thread.h:139: error: syntax error=20
before =91thread=92
kernel/xenomai/skins/posix/../posix/thread.h:139: warning: function=20
declaration isn=92t a prototype
kernel/xenomai/skins/posix/../posix/thread.h: In function=20
=91thread_cancellation_point=92:
kernel/xenomai/skins/posix/../posix/thread.h:143: error: =91pthread_t=92=20
undeclared (first use in this function)
kernel/xenomai/skins/posix/../posix/thread.h:143: error: (Each=20
undeclared identifier is reported only once
kernel/xenomai/skins/posix/../posix/thread.h:143: error: for each=20
function it appears in.)
kernel/xenomai/skins/posix/../posix/thread.h:143: error: syntax error=20
before =91cur=92
kernel/xenomai/skins/posix/../posix/thread.h:143: error: =91_taddr=92=20
undeclared (first use in this function)
kernel/xenomai/skins/posix/../posix/thread.h:143: error: invalid use of=20
undefined type =91struct pse51_thread=92
kernel/xenomai/skins/posix/../posix/thread.h: At top level:
kernel/xenomai/skins/posix/../posix/thread.h:143: error: syntax error=20
before =91)=92 token
kernel/xenomai/skins/posix/sched.c: In function =91sched_get_priority_min=
=92:
kernel/xenomai/skins/posix/sched.c:28: error: =91SCHED_OTHER=92 undeclared =

(first use in this function)
kernel/xenomai/skins/posix/sched.c: In function =91sched_get_priority_max=
=92:
kernel/xenomai/skins/posix/sched.c:46: error: =91SCHED_OTHER=92 undeclared =

(first use in this function)
kernel/xenomai/skins/posix/sched.c: At top level:
kernel/xenomai/skins/posix/sched.c:72: error: syntax error before =91tid=92
kernel/xenomai/skins/posix/sched.c:74: warning: function declaration=20
isn=92t a prototype
kernel/xenomai/skins/posix/sched.c: In function =91pthread_getschedparam=92:
kernel/xenomai/skins/posix/sched.c:79: error: =91tid=92 undeclared (first=20
use in this function)
kernel/xenomai/skins/posix/sched.c:85: error: =91pol=92 undeclared (first=20
use in this function)
kernel/xenomai/skins/posix/sched.c:86: error: =91par=92 undeclared (first=20
use in this function)
kernel/xenomai/skins/posix/sched.c: At top level:
kernel/xenomai/skins/posix/sched.c:93: error: syntax error before =91tid=92
kernel/xenomai/skins/posix/sched.c:95: warning: function declaration=20
isn=92t a prototype
kernel/xenomai/skins/posix/sched.c: In function =91pthread_setschedparam=92:
kernel/xenomai/skins/posix/sched.c:101: error: =91tid=92 undeclared (first =

use in this function)
kernel/xenomai/skins/posix/sched.c:107: error: =91pol=92 undeclared (first =

use in this function)
kernel/xenomai/skins/posix/sched.c:120: error: =91SCHED_OTHER=92 undeclared=
=20
(first use in this function)
kernel/xenomai/skins/posix/sched.c:131: error: =91par=92 undeclared (first =

use in this function)
make[4]: *** [kernel/xenomai/skins/posix/sched.o] Error 1
make[3]: *** [kernel/xenomai/skins/posix] Error 2
make[2]: *** [kernel/xenomai/skins] Error 2
make[1]: *** [kernel/xenomai] Error 2
make: *** [kernel] Error 2


xeno-info, xeno-config as in previous email.

