Message-ID: <43831F22.5000105@domain.hid>
Date: Tue, 22 Nov 2005 14:37:38 +0100
From: Luotao Fu <devtty0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Linking failure while compiling POSIX skin as
	built-in module
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

Hi folks,
I detected a minor problem while compiling 2.6.14.2 with the most recent
xenomai code from svn. The Compilation would quit at linking if one
tries to build the posix skin as built-in module. Abort message:

ipc/built-in.o: In function `sem_init':
: multiple definition of `sem_init'
kernel/built-in.o:: first defined here
ld: Warning: size of symbol `sem_init' changed from 296 in
kernel/built-in.o to 55 in ipc/built-in.o

The problem is the sem_init() method of the SysV IPC routine in the
linux kernel, which is unluckily called excactly the same as the posix
sem_init() but differently declared. It's declared as

void __init sem_init (void)

in SysV IPC and

int sem_init(sem_t *sem, int pshared, unsigned value);

in POSIX. Thus the linker get confused trying to link the two symbols in
one kernel image. Workaround coulb be deactivating the SysV IPC routine
in the kernel or compile Posix skin as a loadable module.

Cheers
Luotao Fu

