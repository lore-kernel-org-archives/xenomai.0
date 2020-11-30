MIME-Version: 1.0
From: Mohamed Irfanulla Mohamed Abdulla <m.mohamedirfanulla@gmail.com>
Date: Mon, 30 Nov 2020 11:49:47 +0100
Message-ID: <CADx0-8DU+evLr-SduY9ru9zKBuhqjYOHPZ=5U4wFnMZAhE5irA@mail.gmail.com>
Subject: RE:[xenomai patch with kernel 5.4.77] Error building the kernel
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I performed the installation of xenomai 3.1 with kernel 5.4.77 and
ipipe-core-5.4.77-x86-2.patch on a ubuntu 20.04 machine.

I encounter this error during the build.

  GEN     usr/initramfs_data.cpio
  AS      usr/initramfs_data.o
  AR      usr/built-in.a
  CC      kernel/cgroup/cgroup.o
arch/x86/xenomai/thread.c: In function =E2=80=98xnarch_leave_root=E2=80=99:
arch/x86/xenomai/thread.c:475:2: error: too many arguments to function
=E2=80=98switch_fpu_finish=E2=80=99
  switch_fpu_finish(&current->thread.fpu, smp_processor_id());
  ^
In file included from arch/x86/xenomai/include/asm/xenomai/wrappers.h:44:0,
                 from include/xenomai/cobalt/kernel/timer.h:28,
                 from include/xenomai/cobalt/kernel/thread.h:27,
                 from arch/x86/xenomai/thread.c:25:
./arch/x86/include/asm/fpu/internal.h:594:20: note: declared here
 static inline void switch_fpu_finish(struct fpu *new_fpu)
                    ^
scripts/Makefile.build:265: recipe for target 'arch/x86/xenomai/thread.o'
failed
make[1]: *** [arch/x86/xenomai/thread.o] Error 1
make[1]: *** Waiting for unfinished jobs....
  CC      kernel/cgroup/rstat.o
Makefile:1729: recipe for target 'arch/x86/xenomai' failed
make: *** [arch/x86/xenomai] Error 2
make: *** Waiting for unfinished jobs....
  CC      init/do_mounts_md.o
  CC      kernel/debug/kdb/kdb_io.o

Thank you for your suggestions on the config and fix.

Irfan
