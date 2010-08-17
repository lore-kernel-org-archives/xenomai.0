From: Hemal C.Bavishi <Hemal.Bavishi@domain.hid>
Date: Tue, 17 Aug 2010 19:21:46 +0530
Message-ID: <E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065794@domain.hid>
References: <4C45539B.70204@domain.hid> <4C6932E8.7050701@domain.hid>
	<4C694AB3.8050407@domain.hid> <4C698E16.5050806@domain.hid>,
	<1282040830.1730.232.camel@domain.hid>
In-Reply-To: <1282040830.1730.232.camel@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Theo Veenker <T.J.G.Veenker@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

When I tried to compile it with the latest version of kernel with xenomai 2=
.5.4, I am getting following errors in Xenomai (disable CONFIG_SMP, enable =
CONFIG_X86_UP_APIC and
CONFIG_X86_UP_IOAPIC (*).)


kernel/xenomai/arch/generic/hal.c:47:29: error: asm/xenomai/hal.h: No such =
file or directory
kernel/xenomai/arch/generic/hal.c:77: error: =91RTHAL_NR_CPUS=92 undeclared=
 here (not in a function)
kernel/xenomai/arch/generic/hal.c:79: error: =91RTHAL_NR_APCS=92 undeclared=
 here (not in a function)
kernel/xenomai/arch/generic/hal.c:89: error: expected =91=3D=92, =91,=92, =
=91;=92, =91asm=92 or =91__attribute__=92 before =91rthal_apc_lock=92
kernel/xenomai/arch/generic/hal.c:93: error: expected =91=3D=92, =91,=92, =
=91;=92, =91asm=92 or =91__attribute__=92 before =91rthal_domain=92
kernel/xenomai/arch/generic/hal.c:97: error: expected =91=3D=92, =91,=92, =
=91;=92, =91asm=92 or =91__attribute__=92 before =91rthal_trap_handler=92
kernel/xenomai/arch/generic/hal.c:99: error: =91RTHAL_NR_FAULTS=92 undeclar=
ed here (not in a function)
kernel/xenomai/arch/generic/hal.c: In function =91rthal_critical_enter=92:
kernel/xenomai/arch/generic/hal.c:105: error: implicit declaration of funct=
ion =91rthal_grab_superlock=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_critical_exit=92:
kernel/xenomai/arch/generic/hal.c:118: error: implicit declaration of funct=
ion =91rthal_release_superlock=92
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:169: error: expected declaration specifie=
rs or =91...=92 before =91rthal_irq_handler_t=92
kernel/xenomai/arch/generic/hal.c:170: error: expected declaration specifie=
rs or =91...=92 before =91rthal_irq_ackfn_t=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_irq_request=92:
kernel/xenomai/arch/generic/hal.c:172: error: =91handler=92 undeclared (fir=
st use in this function)
kernel/xenomai/arch/generic/hal.c:172: error: (Each undeclared identifier i=
s reported only once
kernel/xenomai/arch/generic/hal.c:172: error: for each function it appears =
in.)
kernel/xenomai/arch/generic/hal.c:175: error: implicit declaration of funct=
ion =91rthal_virtualize_irq=92
kernel/xenomai/arch/generic/hal.c:175: error: =91rthal_domain=92 undeclared=
 (first use in this function)
kernel/xenomai/arch/generic/hal.c:179: error: =91ackfn=92 undeclared (first=
 use in this function)
kernel/xenomai/arch/generic/hal.c:180: error: =91IPIPE_HANDLE_MASK=92 undec=
lared (first use in this function)
kernel/xenomai/arch/generic/hal.c:180: error: =91IPIPE_WIRED_MASK=92 undecl=
ared (first use in this function)
kernel/xenomai/arch/generic/hal.c:181: error: =91IPIPE_EXCLUSIVE_MASK=92 un=
declared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function =91rthal_irq_release=92:
kernel/xenomai/arch/generic/hal.c:215: error: =91rthal_domain=92 undeclared=
 (first use in this function)
kernel/xenomai/arch/generic/hal.c:216: error: =91IPIPE_PASS_MASK=92 undecla=
red (first use in this function)
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:390: error: expected =91=3D=92, =91,=92, =
=91;=92, =91asm=92 or =91__attribute__=92 before =91rthal_trap_catch=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_apc_handler=92:
kernel/xenomai/arch/generic/hal.c:400: error: implicit declaration of funct=
ion =91rthal_spin_lock=92
kernel/xenomai/arch/generic/hal.c:400: error: =91rthal_apc_lock=92 undeclar=
ed (first use in this function)
kernel/xenomai/arch/generic/hal.c:402: error: implicit declaration of funct=
ion =91rthal_processor_id=92
kernel/xenomai/arch/generic/hal.c:413: error: implicit declaration of funct=
ion =91ffnz=92
kernel/xenomai/arch/generic/hal.c:418: error: implicit declaration of funct=
ion =91rthal_spin_unlock=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_apc_alloc=92:
kernel/xenomai/arch/generic/hal.c:526: error: implicit declaration of funct=
ion =91rthal_spin_lock_irqsave=92
kernel/xenomai/arch/generic/hal.c:526: error: =91rthal_apc_lock=92 undeclar=
ed (first use in this function)
kernel/xenomai/arch/generic/hal.c:537: error: implicit declaration of funct=
ion =91rthal_spin_unlock_irqrestore=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_apc_schedule=92:
kernel/xenomai/arch/generic/hal.c:608: error: implicit declaration of funct=
ion =91rthal_local_irq_save=92
kernel/xenomai/arch/generic/hal.c:611: error: implicit declaration of funct=
ion =91rthal_schedule_irq_root=92
kernel/xenomai/arch/generic/hal.c:613: error: implicit declaration of funct=
ion =91rthal_local_irq_restore=92
kernel/xenomai/arch/generic/hal.c: In function =91hal_read_proc=92:
kernel/xenomai/arch/generic/hal.c:628: error: =91IPIPE_MAJOR_NUMBER=92 unde=
clared (first use in this function)
kernel/xenomai/arch/generic/hal.c:629: error: =91IPIPE_MINOR_NUMBER=92 unde=
clared (first use in this function)
kernel/xenomai/arch/generic/hal.c:630: error: =91IPIPE_PATCH_NUMBER=92 unde=
clared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function =91faults_read_proc=92:
kernel/xenomai/arch/generic/hal.c:658: error: =91rthal_fault_labels=92 unde=
clared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function =91rthal_add_proc_leaf=92:
kernel/xenomai/arch/generic/hal.c:744: error: implicit declaration of funct=
ion =91wrap_proc_dir_entry_owner=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_proc_register=92:
kernel/xenomai/arch/generic/hal.c:786: error: implicit declaration of funct=
ion =91rthal_nmi_proc_register=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_proc_unregister=92:=

kernel/xenomai/arch/generic/hal.c:793: error: implicit declaration of funct=
ion =91rthal_nmi_proc_unregister=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_init=92:
kernel/xenomai/arch/generic/hal.c:806: error: implicit declaration of funct=
ion =91rthal_arch_init=92
kernel/xenomai/arch/generic/hal.c:832: error: invalid use of undefined type=
 =91struct rthal_calibration_data=92
kernel/xenomai/arch/generic/hal.c:833: error: invalid use of undefined type=
 =91struct rthal_calibration_data=92
kernel/xenomai/arch/generic/hal.c:834: error: invalid use of undefined type=
 =91struct rthal_calibration_data=92
kernel/xenomai/arch/generic/hal.c:840: error: implicit declaration of funct=
ion =91rthal_alloc_virq=92
kernel/xenomai/arch/generic/hal.c:848: error: =91rthal_current_domain=92 un=
declared (first use in this function)
kernel/xenomai/arch/generic/hal.c:851: error: =91IPIPE_HANDLE_MASK=92 undec=
lared (first use in this function)
kernel/xenomai/arch/generic/hal.c:874: error: implicit declaration of funct=
ion =91rthal_register_domain=92
kernel/xenomai/arch/generic/hal.c:874: error: =91rthal_domain=92 undeclared=
 (first use in this function)
kernel/xenomai/arch/generic/hal.c:876: error: =91RTHAL_DOMAIN_ID=92 undecla=
red (first use in this function)
kernel/xenomai/arch/generic/hal.c:877: error: =91RTHAL_XENO_PRIO=92 undecla=
red (first use in this function)
kernel/xenomai/arch/generic/hal.c:877: error: =91rthal_domain_entry=92 unde=
clared (first use in this function)
kernel/xenomai/arch/generic/hal.c:915: error: implicit declaration of funct=
ion =91rthal_free_virq=92
kernel/xenomai/arch/generic/hal.c:918: error: implicit declaration of funct=
ion =91rthal_arch_cleanup=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_exit=92:
kernel/xenomai/arch/generic/hal.c:931: error: =91rthal_current_domain=92 un=
declared (first use in this function)
kernel/xenomai/arch/generic/hal.c:945: error: implicit declaration of funct=
ion =91rthal_unregister_domain=92
kernel/xenomai/arch/generic/hal.c:945: error: =91rthal_domain=92 undeclared=
 (first use in this function)
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:1107: error: =91rthal_irq_enable=92 undec=
lared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1107: warning: type defaults to =91int=92=
 in declaration of =91rthal_irq_enable=92
kernel/xenomai/arch/generic/hal.c:1108: error: =91rthal_irq_disable=92 unde=
clared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1108: warning: type defaults to =91int=92=
 in declaration of =91rthal_irq_disable=92
kernel/xenomai/arch/generic/hal.c:1109: error: =91rthal_irq_end=92 undeclar=
ed here (not in a function)
kernel/xenomai/arch/generic/hal.c:1109: warning: type defaults to =91int=92=
 in declaration of =91rthal_irq_end=92
kernel/xenomai/arch/generic/hal.c:1110: error: =91rthal_irq_host_request=92=
 undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1110: warning: type defaults to =91int=92=
 in declaration of =91rthal_irq_host_request=92
kernel/xenomai/arch/generic/hal.c:1111: error: =91rthal_irq_host_release=92=
 undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1111: warning: type defaults to =91int=92=
 in declaration of =91rthal_irq_host_release=92
kernel/xenomai/arch/generic/hal.c:1113: error: =91rthal_trap_catch=92 undec=
lared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1113: warning: type defaults to =91int=92=
 in declaration of =91rthal_trap_catch=92
kernel/xenomai/arch/generic/hal.c:1114: error: =91rthal_timer_request=92 un=
declared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1114: warning: type defaults to =91int=92=
 in declaration of =91rthal_timer_request=92
kernel/xenomai/arch/generic/hal.c:1115: error: =91rthal_timer_release=92 un=
declared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1115: warning: type defaults to =91int=92=
 in declaration of =91rthal_timer_release=92
kernel/xenomai/arch/generic/hal.c:1116: error: =91rthal_timer_calibrate=92 =
undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:1116: warning: type defaults to =91int=92=
 in declaration of =91rthal_timer_calibrate=92
kernel/xenomai/arch/generic/hal.c:1124: error: =91rthal_domain=92 undeclare=
d here (not in a function)
kernel/xenomai/arch/generic/hal.c:1124: warning: type defaults to =91int=92=
 in declaration of =91rthal_domain=92
kernel/xenomai/arch/generic/hal.c:1135: error: =91kill_proc_info=92 undecla=
red here (not in a function)
kernel/xenomai/arch/generic/hal.c:1135: warning: type defaults to =91int=92=
 in declaration of =91kill_proc_info=92
make[6]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
make[5]: *** [kernel/xenomai/arch/generic] Error 2
make[4]: *** [kernel/xenomai/arch] Error 2
make[3]: *** [kernel/xenomai] Error 2
make[2]: *** [kernel] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      mm/mincore.o
  CC      mm/mlock.o
  CC      mm/mmap.o
  CC      mm/mprotect.o
  CC      mm/mremap.o
  CC      mm/msync.o
  CC      mm/rmap.o
  CC      mm/vmalloc.o
  CC      mm/pagewalk.o
  CC      mm/init-mm.o
  CC      mm/bounce.o
  CC      mm/page_io.o
  CC      mm/swap_state.o
  CC      mm/swapfile.o
  CC      mm/thrash.o
  CC      mm/dmapool.o
  CC      mm/hugetlb.o
  CC      mm/mmu_notifier.o
  CC      mm/ksm.o
  CC      mm/slub.o
  CC      mm/percpu_up.o
  CC      mm/memcontrol.o
  CC      mm/page_cgroup.o
  CC      mm/memory-failure.o
  LD      mm/built-in.o
make[2]: Leaving directory `/root/linux-2.6.34.2'
make[1]: *** [debian/stamp/build/kernel] Error 2
make[1]: Leaving directory `/root/linux-2.6.34.2'
make: *** [debian/stamp/do-build-arch] Error 2
root@domain.hid# cd latency



________________________________________
From: xenomai-help-bounces@domain.hid [xenomai-help-bounces@domain.hid] On Behalf=
 Of Philippe Gerum [rpm@xenomai.org]
Sent: Tuesday, August 17, 2010 3:57 PM
To: Theo Veenker
Cc: Xenomai help
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to bo=
ot on ubuntu lucid system

On Mon, 2010-08-16 at 21:14 +0200, Theo Veenker wrote:
> On 08/16/2010 04:26 PM, Theo Veenker wrote:
> > Gilles Chanteperdrix wrote:
> >> Theo Veenker wrote:
> >>> Hi,
> >>>
> >>> I want to upgrade all our PC's from Ubuntu hardy to lucid and in the
> >>> process
> >>> I'm also going from kernel 2.6.29.5 with Xenomai 2.4.8 to kernel
> >>> 2.6.32.11
> >>> with Xenomai 2.5.3.
> >>>
> >>> I first built and tested the 2.6.32.11 kernel with 2.5.3 on my hardy
> >>> system
> >>> and all went fine. But the problem is it just doesn't run on the
> >>> lucid distro.
> >>
> >> This, I do not understand, the kernel does not need any support from t=
he
> >> distribution for booting, how can the same kernel boot with one
> >> distribution, and not with the other? When you say the "same kernel", =
do
> >> you mean the exact same zImage or bzImage, or do you mean the kernel
> >> with the same configuration, but with a different compiler, or only th=
e
> >> version is identical?
> >>
> >
> > It is a complete mystery to me either. I compiled my kernel into a deb
> > package
> > and installed the very same deb package on three machines:
> > MSI p45 neo3 with Hardy on it -> works OK
> > MSI p45 neo3 with Ludid on it -> nothing (works fine with regular kerne=
l)
> > MSI 945P with Lucid on it: -> nothing (works fine with regular kernel)
> >
> > I'll try the suggestions posted and keep you informed.
>
> OK. Connected a terminal to catch early kernel messages. Still no output
> unfortunately (with the regular kernel I do get output on the terminal,
> so the connection works).
>
> Meanwhile also built and tested kernel 2.6.32.15 + xenomai 2.5.4. Still n=
othing.
> I'm clueless. I'm running Xenomai for years on dozens of systems and I've=

> never run into problems like this. I think I'll have to sit down and take=
 a
> close look at what I'm doing. I've always built my kernels using make-kpk=
g,
> maybe that somehow introduces a problem here. I'll try without it.
>
> (unfortunately/luckily I have to work from home for a few days so I can't=

> get to the test system until later this week)

I failed to reproduce the issue yet, but it very much looks like an
I-pipe bug. Could you try the following config variants when time
allows:

- on 2.6.32.11 or .15, disable CONFIG_SMP, enable CONFIG_X86_UP_APIC
only (*).
- on 2.6.32.11 or .15, disable CONFIG_SMP, enable CONFIG_X86_UP_APIC and
CONFIG_X86_UP_IOAPIC (*).
- on 2.6.32.7, use your normal CONFIG_SMP config, with this patch in:
http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.32.7-x=
86-2.5-01.patch

(*) you need to switch off CONFIG_SMP first, to see those knobs appear
in the "processor type and features" menu.

The fact that you did see the panic blinking signal at least once tends
to point the finger at some access fault the kernel tries to recover
without success, rather than a sudden freeze. It must happen early
enough during the boot process, for the console not to be available yet
for reporting what the kernel whines about.

We don't know yet if that bug is either the consequence of some
interrupt delivery, and/or induced by code only involved in SMP. Those
test configs may help in discovering this.

TIA,

--
Philippe.



_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help



