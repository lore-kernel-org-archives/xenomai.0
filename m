MIME-Version: 1.0
Sender: sink00@gmail.com
Date: Wed, 17 Oct 2012 16:22:55 -0300
Message-ID: <CAODUr7vXcUGmeN9dso5ENeAXWugR9ojj=P3oJOY+3Vr4+mJRiQ@mail.gmail.com>
From: Luis Rossi <luisf.rossi@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Error during kernel build
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi i am trying to build a kernel with xenomai for debian and i am following
all the instuctions.

The target PC will be an Intel Atom.

I am usign xenomai version 2.5.4 with kernel 2.6.34

When building i get the following error:

kernel/xenomai/arch/generic/hal.c:47:29: error: asm/xenomai/hal.h: No such
file or directory
kernel/xenomai/arch/generic/hal.c:77: error: =91RTHAL_NR_CPUS=92 undeclared
here (not in a function)
kernel/xenomai/arch/generic/hal.c:79: error: =91RTHAL_NR_APCS=92 undeclared
here (not in a function)
kernel/xenomai/arch/generic/hal.c:89: error: expected =91=3D=92, =91,=92, =
=91;=92, =91asm=92
or =91__attribute__=92 before =91rthal_apc_lock=92
kernel/xenomai/arch/generic/hal.c:93: error: expected =91=3D=92, =91,=92, =
=91;=92, =91asm=92
or =91__attribute__=92 before =91rthal_domain=92
kernel/xenomai/arch/generic/hal.c:97: error: expected =91=3D=92, =91,=92, =
=91;=92, =91asm=92
or =91__attribute__=92 before =91rthal_trap_handler=92
kernel/xenomai/arch/generic/hal.c:99: error: =91RTHAL_NR_FAULTS=92 undeclar=
ed
here (not in a function)
kernel/xenomai/arch/generic/hal.c: In function =91rthal_critical_enter=92:
kernel/xenomai/arch/generic/hal.c:105: error: implicit declaration of
function =91rthal_grab_superlock=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_critical_exit=92:
kernel/xenomai/arch/generic/hal.c:118: error: implicit declaration of
function =91rthal_release_superlock=92
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:169: error: expected declaration
specifiers or =91...=92 before =91rthal_irq_handler_t=92
kernel/xenomai/arch/generic/hal.c:170: error: expected declaration
specifiers or =91...=92 before =91rthal_irq_ackfn_t=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_irq_request=92:
kernel/xenomai/arch/generic/hal.c:172: error: =91handler=92 undeclared (fir=
st
use in this function)
kernel/xenomai/arch/generic/hal.c:172: error: (Each undeclared identifier
is reported only once
kernel/xenomai/arch/generic/hal.c:172: error: for each function it appears
in.)
kernel/xenomai/arch/generic/hal.c:175: error: implicit declaration of
function =91rthal_virtualize_irq=92
kernel/xenomai/arch/generic/hal.c:175: error: =91rthal_domain=92 undeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:179: error: =91ackfn=92 undeclared (first=
 use
in this function)
kernel/xenomai/arch/generic/hal.c:180: error: =91IPIPE_HANDLE_MASK=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:180: error: =91IPIPE_WIRED_MASK=92 undecl=
ared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:181: error: =91IPIPE_EXCLUSIVE_MASK=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function =91rthal_irq_release=92:
kernel/xenomai/arch/generic/hal.c:215: error: =91rthal_domain=92 undeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:216: error: =91IPIPE_PASS_MASK=92 undecla=
red
(first use in this function)
kernel/xenomai/arch/generic/hal.c: In function =91rthal_irq_affinity=92:
kernel/xenomai/arch/generic/hal.c:350: error: implicit declaration of
function =91rthal_set_irq_affinity=92
kernel/xenomai/arch/generic/hal.c:350: error: incompatible types when
assigning to type =91cpumask_t=92 from type =91int=92
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:390: error: expected =91=3D=92, =91,=92, =
=91;=92, =91asm=92
or =91__attribute__=92 before =91rthal_trap_catch=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_apc_handler=92:
kernel/xenomai/arch/generic/hal.c:400: error: implicit declaration of
function =91rthal_spin_lock=92
kernel/xenomai/arch/generic/hal.c:400: error: =91rthal_apc_lock=92 undeclar=
ed
(first use in this function)
kernel/xenomai/arch/generic/hal.c:402: error: implicit declaration of
function =91rthal_processor_id=92
kernel/xenomai/arch/generic/hal.c:413: error: implicit declaration of
function =91ffnz=92
kernel/xenomai/arch/generic/hal.c:418: error: implicit declaration of
function =91rthal_spin_unlock=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_apc_alloc=92:
kernel/xenomai/arch/generic/hal.c:526: error: implicit declaration of
function =91rthal_spin_lock_irqsave=92
kernel/xenomai/arch/generic/hal.c:526: error: =91rthal_apc_lock=92 undeclar=
ed
(first use in this function)
kernel/xenomai/arch/generic/hal.c:537: error: implicit declaration of
function =91rthal_spin_unlock_irqrestore=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_apc_schedule=92:
kernel/xenomai/arch/generic/hal.c:608: error: implicit declaration of
function =91rthal_local_irq_save=92
kernel/xenomai/arch/generic/hal.c:611: error: implicit declaration of
function =91rthal_schedule_irq_root=92
kernel/xenomai/arch/generic/hal.c:613: error: implicit declaration of
function =91rthal_local_irq_restore=92
kernel/xenomai/arch/generic/hal.c: In function =91hal_read_proc=92:
kernel/xenomai/arch/generic/hal.c:628: error: =91IPIPE_MAJOR_NUMBER=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:629: error: =91IPIPE_MINOR_NUMBER=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:630: error: =91IPIPE_PATCH_NUMBER=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function =91faults_read_proc=92:
kernel/xenomai/arch/generic/hal.c:658: error: =91rthal_fault_labels=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function =91rthal_add_proc_leaf=92:
kernel/xenomai/arch/generic/hal.c:744: error: implicit declaration of
function =91wrap_proc_dir_entry_owner=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_proc_register=92:
kernel/xenomai/arch/generic/hal.c:786: error: implicit declaration of
function =91rthal_nmi_proc_register=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_proc_unregister=92:
kernel/xenomai/arch/generic/hal.c:793: error: implicit declaration of
function =91rthal_nmi_proc_unregister=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_init=92:
kernel/xenomai/arch/generic/hal.c:806: error: implicit declaration of
function =91rthal_arch_init=92
kernel/xenomai/arch/generic/hal.c:832: error: invalid use of undefined type
=91struct rthal_calibration_data=92
kernel/xenomai/arch/generic/hal.c:833: error: invalid use of undefined type
=91struct rthal_calibration_data=92
kernel/xenomai/arch/generic/hal.c:834: error: invalid use of undefined type
=91struct rthal_calibration_data=92
kernel/xenomai/arch/generic/hal.c:840: error: implicit declaration of
function =91rthal_alloc_virq=92
kernel/xenomai/arch/generic/hal.c:848: error: =91rthal_current_domain=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:851: error: =91IPIPE_HANDLE_MASK=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:874: error: implicit declaration of
function =91rthal_register_domain=92
kernel/xenomai/arch/generic/hal.c:874: error: =91rthal_domain=92 undeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:876: error: =91RTHAL_DOMAIN_ID=92 undecla=
red
(first use in this function)
kernel/xenomai/arch/generic/hal.c:877: error: =91RTHAL_XENO_PRIO=92 undecla=
red
(first use in this function)
kernel/xenomai/arch/generic/hal.c:877: error: =91rthal_domain_entry=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:915: error: implicit declaration of
function =91rthal_free_virq=92
kernel/xenomai/arch/generic/hal.c:918: error: implicit declaration of
function =91rthal_arch_cleanup=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_exit=92:
kernel/xenomai/arch/generic/hal.c:931: error: =91rthal_current_domain=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:945: error: implicit declaration of
function =91rthal_unregister_domain=92
kernel/xenomai/arch/generic/hal.c:945: error: =91rthal_domain=92 undeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:1107: error: =91rthal_irq_enable=92
undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1107: warning: type defaults to =91int=92=
 in
declaration of =91rthal_irq_enable=92
kernel/xenomai/arch/generic/hal.c:1108: error: =91rthal_irq_disable=92
undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1108: warning: type defaults to =91int=92=
 in
declaration of =91rthal_irq_disable=92
kernel/xenomai/arch/generic/hal.c:1109: error: =91rthal_irq_end=92 undeclar=
ed
here (not in a function)
kernel/xenomai/arch/generic/hal.c:1109: warning: type defaults to =91int=92=
 in
declaration of =91rthal_irq_end=92
kernel/xenomai/arch/generic/hal.c:1110: error: =91rthal_irq_host_request=92
undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1110: warning: type defaults to =91int=92=
 in
declaration of =91rthal_irq_host_request=92
kernel/xenomai/arch/generic/hal.c:1111: error: =91rthal_irq_host_release=92
undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1111: warning: type defaults to =91int=92=
 in
declaration of =91rthal_irq_host_release=92
kernel/xenomai/arch/generic/hal.c:1113: error: =91rthal_trap_catch=92
undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1113: warning: type defaults to =91int=92=
 in
declaration of =91rthal_trap_catch=92
kernel/xenomai/arch/generic/hal.c:1114: error: =91rthal_timer_request=92
undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1114: warning: type defaults to =91int=92=
 in
declaration of =91rthal_timer_request=92
kernel/xenomai/arch/generic/hal.c:1115: error: =91rthal_timer_release=92
undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1115: warning: type defaults to =91int=92=
 in
declaration of =91rthal_timer_release=92
kernel/xenomai/arch/generic/hal.c:1116: error: =91rthal_timer_calibrate=92
undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1116: warning: type defaults to =91int=92=
 in
declaration of =91rthal_timer_calibrate=92
kernel/xenomai/arch/generic/hal.c:1124: error: =91rthal_domain=92 undeclared
here (not in a function)
kernel/xenomai/arch/generic/hal.c:1124: warning: type defaults to =91int=92=
 in
declaration of =91rthal_domain=92
kernel/xenomai/arch/generic/hal.c:1135: error: =91kill_proc_info=92 undecla=
red
here (not in a function)
kernel/xenomai/arch/generic/hal.c:1135: warning: type defaults to =91int=92=
 in
declaration of =91kill_proc_info=92
make[5]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
make[4]: *** [kernel/xenomai/arch/generic] Error 2
make[3]: *** [kernel/xenomai/arch] Error 2
make[2]: *** [kernel/xenomai] Error 2
make[1]: *** [kernel] Error 2
make[1]: *** Waiting for unfinished jobs....
  CC      mm/readahead.o
  CC      mm/swap.o
  CC      mm/truncate.o
  CC      mm/vmscan.o
  CC      mm/shmem.o
  CC      mm/util.o
  CC      mm/backing-dev.o
  CC      mm/mmu_context.o
  CC      mm/fremap.o
  CC      mm/highmem.o
  CC      mm/madvise.o
  CC      mm/memory.o
  CC      mm/mincore.o
  CC      mm/mlock.o
  CC      mm/mmap.o
  CC      mm/mprotect.o
  CC      mm/mremap.o
  CC      mm/msync.o
  CC      mm/rmap.o
  CC      mm/vmalloc.o
  CC      mm/pagewalk.o
  CC      mm/bounce.o
  CC      mm/page_io.o
  CC      mm/swap_state.o
  CC      mm/swapfile.o
  CC      mm/hugetlb.o
  CC      mm/ksm.o
  CC      mm/slub.o
  CC      mm/percpu.o
  CC      mm/memory-failure.o
  LD      mm/built-in.o
make[1]: Leaving directory `/home/luis/linux-2.6.34'
make: *** [debian/stamp/build/kernel] Error 2
root@debbuild:/home/luis/linux-2.6.34# make menuconfig
scripts/kconfig/mconf arch/x86/Kconfig
#
# configuration written to .config
#


*** End of Linux kernel configuration.
*** Execute 'make' to build the kernel or try 'make help'.


Any coment on that? My config file is attached.

Best regards,

-- =

Lu=EDs Filipe Rossi
Electrical Engineer
Biomechatronics Lab. / Grupo de Sensores Integr=E1veis e Sistemas
Escola Polit=E9cnica
Universidade de S=E3o Paulo
Cel. +55 (11) 7662-9234
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config
Type: application/octet-stream
Size: 116107 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20121017/dc96927=
5/attachment.obj>
