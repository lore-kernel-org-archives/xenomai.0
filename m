MIME-Version: 1.0
Date: Tue, 12 Apr 2016 11:55:15 +0200
Message-ID: <CABprWpketiup8jSBhmbhO3vJ2PzOtj0uuOG8J6_eFkMJiUUeDg@mail.gmail.com>
From: Varun Deshpande <varun9485@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] IPIPE_LOCK Problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Hello all,

I am trying to compile Xenomai 3.0.2 with Kernel 4.1.18. I am running a
32bit Ubuntu(14.04.04). I configured the kernel and changed the following
options

1) Enable loadable module support  =E2=86=92   Forced module loading (Press=
 Y)
2) Enable loadable module support  =E2=86=92   Forced module unloading (Pre=
ss Y)
3) Xenomai/cobalt   =E2=86=92  Drivers  =E2=86=92   RTnet  =E2=86=92   Prot=
ocol Stack  =E2=86=92  RTmac
Layer  =E2=86=92   NoMAC discipline for RTmac (Press M)
4) Xenomai/cobalt   =E2=86=92  Drivers  =E2=86=92   RTnet  =E2=86=92   Driv=
ers  =E2=86=92  (For All
requried Drivers Press M){Exclude Others by pressing N)
5) Xenomai/cobalt   =E2=86=92  Drivers  =E2=86=92   RTnet  =E2=86=92  Add=
=C2=ADOns  =E2=86=92 Real=C2=ADTime
Capturing Support (Press M)
6) Power management and ACPI options  =E2=86=92  ACPI (Advanced Configurati=
on &
Power Interface)Support  =E2=86=92  Processor(Press N)
7) Power management and ACPI options  =E2=86=92  APM (Advanced Power Manage=
ment)
BIOS support (Press N)
8) Power management and ACPI options  =E2=86=92   CPU Frequency scaling   =
=E2=86=92CPU
Frequency scaling (Press N)
9) Power management and ACPI options  =E2=86=92  CPU Idle  =E2=86=92  CPU i=
dle PM support
(Press N)
10) Networking support  =E2=86=92  Networking Options  =E2=86=92  Timestamp=
ing in
PHYdevices (Press Y)
11) Device Drivers  =E2=86=92  Input device support  =E2=86=92  Miscellaneo=
us devices=E2=86=92   PC
Speaker support (Press N)
12) Device Drivers  =E2=86=92  Staging Drivers  (Press N)
13) Processor type and features -->  Continuous Memory Allocator (Press N)
14) Processor type and features --> Transparent Huge Page Support (Press N)
15) Processor type and features --> Allow for memory compaction (Press N)
16) Processor type and features --> Page Migration (Press N)


After saving the file , when I start compiling the kernel, after 60 minutes
of compilation I get following error.
Note : I have also tried by only changing kernel options from point 1 to
point 12 in xenomai-stable (Before xenomai 3.0.2 was released) but I get
the same error.
Also I dont get any error of such error when I tried it on kernel 3.18.20.
Please guide me in this regard, Following is the Error :

In file included from include/linux/spinlock.h:92:0,
                 from include/linux/seqlock.h:35,
                 from include/linux/time.h:5,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from sound/soc/intel/atom/sst/sst.c:22:
sound/soc/intel/atom/sst/sst.c: In function =E2=80=98sst_restore_shim64=E2=
=80=99:
include/linux/ipipe_lock.h:83:2: error: expected expression before =E2=80=
=98do=E2=80=99
  do {        \
  ^
include/linux/spinlock.h:272:2: note: in expansion of macro
=E2=80=98PICK_SPINUNLOCK_IRQRESTORE=E2=80=99
  PICK_SPINUNLOCK_IRQRESTORE(lock, flags)
  ^
include/linux/spinlock.h:374:2: note: in expansion of macro
=E2=80=98raw_spin_unlock_irqrestore=E2=80=99
  raw_spin_unlock_irqrestore(lock, flags)
  ^
sound/soc/intel/atom/sst/sst.c:373:2: note: in expansion of macro
=E2=80=98spin_unlock_irqrestore=E2=80=99
  spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
  ^
make[5]: *** [sound/soc/intel/atom/sst/sst.o] Error 1
make[4]: *** [sound/soc/intel/atom/sst] Error 2
make[3]: *** [sound/soc/intel/atom] Error 2
make[2]: *** [sound/soc/intel] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Best Regards
Varun Deshpande
