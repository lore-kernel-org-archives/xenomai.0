MIME-Version: 1.0
Date: Tue, 23 Nov 2010 19:12:33 +0100
Message-ID: <AANLkTiny-NB-R4ELThQ0HE3LALz03cvcNuamnsa2kqiC@mail.gmail.com>
From: tadele shiferaw <metitad@domain.hid>
Content-Type: multipart/alternative; boundary=00163646dc3c1b897a0495bc5161
Subject: [Xenomai-help] Xenomai installation on archlinux
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--00163646dc3c1b897a0495bc5161
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

I am tryin to install xenomai 2.5.5.2 on archlinux with kernel version
2.6.35.7. I was able to run and patch adeos. Then I configured the  kernel
to disable

  config_apm
  config_acpi_processot
  config_cpu_freq
  config_pci_msi

Then when i try to run make i have the following error.

  CC      kernel/xenomai/arch/generic/hal.o
In file included from
/home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai/hal.=
h:41:0,
                 from kernel/xenomai/arch/generic/hal.c:47:
include/linux/ipipe_tickdev.h:80:56: warning: =91struct clocksource=92 decl=
ared
inside parameter list
include/linux/ipipe_tickdev.h:80:56: warning: its scope is only this
definition or declaration, which is probably not what you want
In file included from kernel/xenomai/arch/generic/hal.c:47:0:
/home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai/hal.=
h:65:13:
warning: =91struct ipipe_tick_device=92 declared inside parameter list
/home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai/hal.=
h:65:13:
warning: =91enum clock_event_mode=92 declared inside parameter list
/home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai/hal.=
h:67:12:
warning: =91struct ipipe_tick_device=92 declared inside parameter list
In file included from
/home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai/hal_=
32.h:54:0,
                 from
/home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai/hal.=
h:75,
                 from kernel/xenomai/arch/generic/hal.c:47:
include/asm-generic/xenomai/hal.h: In function =91rthal_get_cpufreq=92:
include/asm-generic/xenomai/hal.h:225:23: error: storage size of =91sysinfo=
=92
isn=92t known
include/asm-generic/xenomai/hal.h:226:2: error: implicit declaration of
function =91ipipe_get_sysinfo=92
include/asm-generic/xenomai/hal.h:225:23: warning: unused variable =91sysin=
fo=92
include/asm-generic/xenomai/hal.h: In function =91rthal_get_timerfreq=92:
include/asm-generic/xenomai/hal.h:232:23: error: storage size of =91sysinfo=
=92
isn=92t known
include/asm-generic/xenomai/hal.h:232:23: warning: unused variable =91sysin=
fo=92
include/asm-generic/xenomai/hal.h: At top level:
include/asm-generic/xenomai/hal.h:303:2: error: #error "Adeos: atomic task
switch support is missing; upgrading\n" "     to a recent I-pipe version is
required."
include/asm-generic/xenomai/hal.h: In function =91set_task_nowakeup=92:
include/asm-generic/xenomai/hal.h:314:17: error: =91TASK_NOWAKEUP=92 undecl=
ared
(first use in this function)
include/asm-generic/xenomai/hal.h:314:17: note: each undeclared identifier
is reported only once for each function it appears in
include/asm-generic/xenomai/hal.h: In function =91clear_task_nowakeup=92:
include/asm-generic/xenomai/hal.h:319:2: error: =91TASK_NOWAKEUP=92 undecla=
red
(first use in this function)
include/asm-generic/xenomai/hal.h: In function =91rthal_enable_notifier=92:
include/asm-generic/xenomai/hal.h:337:14: error: =91PF_EVNOTIFY=92 undeclar=
ed
(first use in this function)
include/asm-generic/xenomai/hal.h: At top level:
include/asm-generic/xenomai/hal.h:414:29: error: expected =91=3D=92, =91,=
=92, =91;=92,
=91asm=92 or =91__attribute__=92 before =91rthal_irq_handler_t=92
include/asm-generic/xenomai/hal.h:415:29: error: expected =91=3D=92, =91,=
=92, =91;=92,
=91asm=92 or =91__attribute__=92 before =91rthal_irq_ackfn_t=92
include/asm-generic/xenomai/hal.h:441:39: error: =91IPIPE_NR_CPUS=92 undecl=
ared
here (not in a function)
include/asm-generic/xenomai/hal.h:441:54: error: =91IPIPE_NR_FAULTS=92
undeclared here (not in a function)
include/asm-generic/xenomai/hal.h:495:9: error: expected declaration
specifiers or =91...=92 before =91rthal_irq_handler_t=92
include/asm-generic/xenomai/hal.h:496:9: error: expected declaration
specifiers or =91...=92 before =91rthal_irq_ackfn_t=92
include/asm-generic/xenomai/hal.h: In function =91rthal_irq_host_pend=92:
include/asm-generic/xenomai/hal.h:517:2: error: implicit declaration of
function =91ipipe_propagate_irq=92
include/asm-generic/xenomai/hal.h: In function =91__rthal_apc_schedule=92:
include/asm-generic/xenomai/hal.h:530:3: error: implicit declaration of
function =91ipipe_schedule_irq=92
include/asm-generic/xenomai/hal.h: In function =91rthal_apc_schedule=92:
include/asm-generic/xenomai/hal.h:537:2: error: implicit declaration of
function =91ipipe_test_and_stall_pipeline_from=92
include/asm-generic/xenomai/hal.h:539:2: error: implicit declaration of
function =91ipipe_restore_pipeline_from=92
include/asm-generic/xenomai/hal.h: At top level:
include/asm-generic/xenomai/hal.h:552:57: warning: =91enum clock_event_mode=
=92
declared inside parameter list
include/asm-generic/xenomai/hal.h:557:18: warning: =91enum clock_event_mode=
=92
declared inside parameter list
In file included from
/home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai/hal.=
h:75:0,
                 from kernel/xenomai/arch/generic/hal.c:47:
/home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai/hal_=
32.h:
In function =91rthal_rdtsc=92:
/home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai/hal_=
32.h:134:2:
error: implicit declaration of function =91ipipe_read_tsc=92
/home/tadele/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai/ha=
l_32.h:
In function =91rthal_timer_program_shot=92:
/home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai/hal_=
32.h:151:2:
error: implicit declaration of function =91local_irq_save_hw=92
/home/tadele/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai/ha=
l_32.h:156:3:
error: =91IPIPE_SERVICE_IPI3=92 undeclared (first use in this function)
/home/tadele/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai/ha=
l_32.h:173:2:
error: implicit declaration of function =91local_irq_restore_hw=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_critical_enter=92:
kernel/xenomai/arch/generic/hal.c:105:5: error: implicit declaration of
function =91ipipe_critical_enter=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_critical_exit=92:
kernel/xenomai/arch/generic/hal.c:118:5: error: implicit declaration of
function =91ipipe_critical_exit=92
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:169:9: error: expected declaration
specifiers or =91...=92 before =91rthal_irq_handler_t=92
kernel/xenomai/arch/generic/hal.c:170:9: error: expected declaration
specifiers or =91...=92 before =91rthal_irq_ackfn_t=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_irq_request=92:
kernel/xenomai/arch/generic/hal.c:172:9: error: =91handler=92 undeclared (f=
irst
use in this function)
kernel/xenomai/arch/generic/hal.c:172:35: error: =91IPIPE_NR_IRQS=92 undecl=
ared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:175:5: error: implicit declaration of
function =91ipipe_virtualize_irq=92
kernel/xenomai/arch/generic/hal.c:175:12: error: =91ackfn=92 undeclared (fi=
rst
use in this function)
kernel/xenomai/arch/generic/hal.c:175:12: error: =91IPIPE_HANDLE_MASK=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:175:12: error: =91IPIPE_WIRED_MASK=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:175:12: error: =91IPIPE_EXCLUSIVE_MASK=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function =91rthal_irq_release=92:
kernel/xenomai/arch/generic/hal.c:212:16: error: =91IPIPE_NR_IRQS=92 undecl=
ared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:215:12: error: =91IPIPE_PASS_MASK=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function =91rthal_irq_affinity=92:
kernel/xenomai/arch/generic/hal.c:347:16: error: =91IPIPE_NR_XIRQS=92 undec=
lared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:350:5: error: implicit declaration of
function =91ipipe_set_irq_affinity=92
kernel/xenomai/arch/generic/hal.c:350:14: error: incompatible types when
assigning to type =91cpumask_t=92 from type =91int=92
kernel/xenomai/arch/generic/hal.c: In function =91hal_read_proc=92:
kernel/xenomai/arch/generic/hal.c:577:13: error: =91IPIPE_MAJOR_NUMBER=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:578:13: error: =91IPIPE_MINOR_NUMBER=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:579:18: error: =91IPIPE_PATCH_NUMBER=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function =91rthal_init=92:
kernel/xenomai/arch/generic/hal.c:789:5: error: implicit declaration of
function =91ipipe_alloc_virq=92
kernel/xenomai/arch/generic/hal.c:797:11: error: =91ipipe_current_domain=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:797:11: error: =91IPIPE_HANDLE_MASK=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:823:11: error: storage size of =91attr=92
isn=92t known
kernel/xenomai/arch/generic/hal.c:823:11: error: implicit declaration of
function =91ipipe_init_attr=92
kernel/xenomai/arch/generic/hal.c:823:11: error: =91IPIPE_ROOT_PRIO=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:823:11: error: implicit declaration of
function =91ipipe_register_domain=92
kernel/xenomai/arch/generic/hal.c:823:11: warning: unused variable =91attr=
=92
kernel/xenomai/arch/generic/hal.c:864:5: error: implicit declaration of
function =91ipipe_free_virq=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_exit=92:
kernel/xenomai/arch/generic/hal.c:880:2: error: =91ipipe_current_domain=92
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:894:2: error: implicit declaration of
function =91ipipe_unregister_domain=92
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:1105:1: warning: type defaults to =91int=
=92 in
declaration of =91rthal_apc_pending=92
kernel/xenomai/arch/generic/hal.c: In function =91rthal_irq_release=92:
kernel/xenomai/arch/generic/hal.c:217:1: warning: control reaches end of
non-void function
kernel/xenomai/arch/generic/hal.c: In function =91rthal_irq_request=92:
kernel/xenomai/arch/generic/hal.c:182:1: warning: control reaches end of
non-void function
make[4]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
make[3]: *** [kernel/xenomai/arch/generic] Error 2
make[2]: *** [kernel/xenomai/arch] Error 2
make[1]: *** [kernel/xenomai] Error 2
make: *** [kernel] Error 2

Any help?

--00163646dc3c1b897a0495bc5161
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

I am tryin to install xenomai 2.5.5.2 on archlinux with kernel version 2.6.=
35.7. I was able to run and patch adeos. Then I configured the =A0kernel to=
 disable<div><br></div><div>=A0=A0config_apm=A0</div><div>=A0=A0config_acpi=
_processot</div>
<div>=A0=A0config_cpu_freq=A0</div><div>=A0=A0config_pci_msi</div><div><br>=
</div><div>Then when i try to run make i have the following error.=A0</div>=
<div><br></div><div><div>=A0=A0CC =A0 =A0 =A0kernel/xenomai/arch/generic/ha=
l.o</div><div>In file included from /home/meti/kernelbuild/src/linux-2.6.35=
.7/arch/x86/include/asm/xenomai/hal.h:41:0,</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from kernel/xenomai/arch/generic/ha=
l.c:47:</div><div>include/linux/ipipe_tickdev.h:80:56: warning: =91struct c=
locksource=92 declared inside parameter list</div><div>include/linux/ipipe_=
tickdev.h:80:56: warning: its scope is only this definition or declaration,=
 which is probably not what you want</div>
<div>In file included from kernel/xenomai/arch/generic/hal.c:47:0:</div><di=
v>/home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai/ha=
l.h:65:13: warning: =91struct ipipe_tick_device=92 declared inside paramete=
r list</div>
<div>/home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai=
/hal.h:65:13: warning: =91enum clock_event_mode=92 declared inside paramete=
r list</div><div>/home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include=
/asm/xenomai/hal.h:67:12: warning: =91struct ipipe_tick_device=92 declared =
inside parameter list</div>
<div>In file included from /home/meti/kernelbuild/src/linux-2.6.35.7/arch/x=
86/include/asm/xenomai/hal_32.h:54:0,</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 from /home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm=
/xenomai/hal.h:75,</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from kernel/xenomai/arch/generic/ha=
l.c:47:</div><div>include/asm-generic/xenomai/hal.h: In function =91rthal_g=
et_cpufreq=92:</div><div>include/asm-generic/xenomai/hal.h:225:23: error: s=
torage size of =91sysinfo=92 isn=92t known</div>
<div>include/asm-generic/xenomai/hal.h:226:2: error: implicit declaration o=
f function =91ipipe_get_sysinfo=92</div><div>include/asm-generic/xenomai/ha=
l.h:225:23: warning: unused variable =91sysinfo=92</div><div>include/asm-ge=
neric/xenomai/hal.h: In function =91rthal_get_timerfreq=92:</div>
<div>include/asm-generic/xenomai/hal.h:232:23: error: storage size of =91sy=
sinfo=92 isn=92t known</div><div>include/asm-generic/xenomai/hal.h:232:23: =
warning: unused variable =91sysinfo=92</div><div>include/asm-generic/xenoma=
i/hal.h: At top level:</div>
<div>include/asm-generic/xenomai/hal.h:303:2: error: #error &quot;Adeos: at=
omic task switch support is missing; upgrading\n&quot; &quot; =A0 =A0 to a =
recent I-pipe version is required.&quot;</div><div>include/asm-generic/xeno=
mai/hal.h: In function =91set_task_nowakeup=92:</div>
<div>include/asm-generic/xenomai/hal.h:314:17: error: =91TASK_NOWAKEUP=92 u=
ndeclared (first use in this function)</div><div>include/asm-generic/xenoma=
i/hal.h:314:17: note: each undeclared identifier is reported only once for =
each function it appears in</div>
<div>include/asm-generic/xenomai/hal.h: In function =91clear_task_nowakeup=
=92:</div><div>include/asm-generic/xenomai/hal.h:319:2: error: =91TASK_NOWA=
KEUP=92 undeclared (first use in this function)</div><div>include/asm-gener=
ic/xenomai/hal.h: In function =91rthal_enable_notifier=92:</div>
<div>include/asm-generic/xenomai/hal.h:337:14: error: =91PF_EVNOTIFY=92 und=
eclared (first use in this function)</div><div>include/asm-generic/xenomai/=
hal.h: At top level:</div><div>include/asm-generic/xenomai/hal.h:414:29: er=
ror: expected =91=3D=92, =91,=92, =91;=92, =91asm=92 or =91__attribute__=92=
 before =91rthal_irq_handler_t=92</div>
<div>include/asm-generic/xenomai/hal.h:415:29: error: expected =91=3D=92, =
=91,=92, =91;=92, =91asm=92 or =91__attribute__=92 before =91rthal_irq_ackf=
n_t=92</div><div>include/asm-generic/xenomai/hal.h:441:39: error: =91IPIPE_=
NR_CPUS=92 undeclared here (not in a function)</div>
<div>include/asm-generic/xenomai/hal.h:441:54: error: =91IPIPE_NR_FAULTS=92=
 undeclared here (not in a function)</div><div>include/asm-generic/xenomai/=
hal.h:495:9: error: expected declaration specifiers or =91...=92 before =91=
rthal_irq_handler_t=92</div>
<div>include/asm-generic/xenomai/hal.h:496:9: error: expected declaration s=
pecifiers or =91...=92 before =91rthal_irq_ackfn_t=92</div><div>include/asm=
-generic/xenomai/hal.h: In function =91rthal_irq_host_pend=92:</div><div>in=
clude/asm-generic/xenomai/hal.h:517:2: error: implicit declaration of funct=
ion =91ipipe_propagate_irq=92</div>
<div>include/asm-generic/xenomai/hal.h: In function =91__rthal_apc_schedule=
=92:</div><div>include/asm-generic/xenomai/hal.h:530:3: error: implicit dec=
laration of function =91ipipe_schedule_irq=92</div><div>include/asm-generic=
/xenomai/hal.h: In function =91rthal_apc_schedule=92:</div>
<div>include/asm-generic/xenomai/hal.h:537:2: error: implicit declaration o=
f function =91ipipe_test_and_stall_pipeline_from=92</div><div>include/asm-g=
eneric/xenomai/hal.h:539:2: error: implicit declaration of function =91ipip=
e_restore_pipeline_from=92</div>
<div>include/asm-generic/xenomai/hal.h: At top level:</div><div>include/asm=
-generic/xenomai/hal.h:552:57: warning: =91enum clock_event_mode=92 declare=
d inside parameter list</div><div>include/asm-generic/xenomai/hal.h:557:18:=
 warning: =91enum clock_event_mode=92 declared inside parameter list</div>
<div>In file included from /home/meti/kernelbuild/src/linux-2.6.35.7/arch/x=
86/include/asm/xenomai/hal.h:75:0,</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 from kernel/xenomai/arch/generic/hal.c:47:</div><div>/home/meti/kernel=
build/src/linux-2.6.35.7/arch/x86/include/asm/xenomai/hal_32.h: In function=
 =91rthal_rdtsc=92:</div>
<div>/home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai=
/hal_32.h:134:2: error: implicit declaration of function =91ipipe_read_tsc=
=92</div><div>/home/tadele/kernelbuild/src/linux-2.6.35.7/arch/x86/include/=
asm/xenomai/hal_32.h: In function =91rthal_timer_program_shot=92:</div>
<div>/home/meti/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenomai=
/hal_32.h:151:2: error: implicit declaration of function =91local_irq_save_=
hw=92</div><div>/home/tadele/kernelbuild/src/linux-2.6.35.7/arch/x86/includ=
e/asm/xenomai/hal_32.h:156:3: error: =91IPIPE_SERVICE_IPI3=92 undeclared (f=
irst use in this function)</div>
<div>/home/tadele/kernelbuild/src/linux-2.6.35.7/arch/x86/include/asm/xenom=
ai/hal_32.h:173:2: error: implicit declaration of function =91local_irq_res=
tore_hw=92</div><div>kernel/xenomai/arch/generic/hal.c: In function =91rtha=
l_critical_enter=92:</div>
<div>kernel/xenomai/arch/generic/hal.c:105:5: error: implicit declaration o=
f function =91ipipe_critical_enter=92</div><div>kernel/xenomai/arch/generic=
/hal.c: In function =91rthal_critical_exit=92:</div><div>kernel/xenomai/arc=
h/generic/hal.c:118:5: error: implicit declaration of function =91ipipe_cri=
tical_exit=92</div>
<div>kernel/xenomai/arch/generic/hal.c: At top level:</div><div>kernel/xeno=
mai/arch/generic/hal.c:169:9: error: expected declaration specifiers or =91=
...=92 before =91rthal_irq_handler_t=92</div><div>kernel/xenomai/arch/gener=
ic/hal.c:170:9: error: expected declaration specifiers or =91...=92 before =
=91rthal_irq_ackfn_t=92</div>
<div>kernel/xenomai/arch/generic/hal.c: In function =91rthal_irq_request=92=
:</div><div>kernel/xenomai/arch/generic/hal.c:172:9: error: =91handler=92 u=
ndeclared (first use in this function)</div><div>kernel/xenomai/arch/generi=
c/hal.c:172:35: error: =91IPIPE_NR_IRQS=92 undeclared (first use in this fu=
nction)</div>
<div>kernel/xenomai/arch/generic/hal.c:175:5: error: implicit declaration o=
f function =91ipipe_virtualize_irq=92</div><div>kernel/xenomai/arch/generic=
/hal.c:175:12: error: =91ackfn=92 undeclared (first use in this function)</=
div>
<div>kernel/xenomai/arch/generic/hal.c:175:12: error: =91IPIPE_HANDLE_MASK=
=92 undeclared (first use in this function)</div><div>kernel/xenomai/arch/g=
eneric/hal.c:175:12: error: =91IPIPE_WIRED_MASK=92 undeclared (first use in=
 this function)</div>
<div>kernel/xenomai/arch/generic/hal.c:175:12: error: =91IPIPE_EXCLUSIVE_MA=
SK=92 undeclared (first use in this function)</div><div>kernel/xenomai/arch=
/generic/hal.c: In function =91rthal_irq_release=92:</div><div>kernel/xenom=
ai/arch/generic/hal.c:212:16: error: =91IPIPE_NR_IRQS=92 undeclared (first =
use in this function)</div>
<div>kernel/xenomai/arch/generic/hal.c:215:12: error: =91IPIPE_PASS_MASK=92=
 undeclared (first use in this function)</div><div>kernel/xenomai/arch/gene=
ric/hal.c: In function =91rthal_irq_affinity=92:</div><div>kernel/xenomai/a=
rch/generic/hal.c:347:16: error: =91IPIPE_NR_XIRQS=92 undeclared (first use=
 in this function)</div>
<div>kernel/xenomai/arch/generic/hal.c:350:5: error: implicit declaration o=
f function =91ipipe_set_irq_affinity=92</div><div>kernel/xenomai/arch/gener=
ic/hal.c:350:14: error: incompatible types when assigning to type =91cpumas=
k_t=92 from type =91int=92</div>
<div>kernel/xenomai/arch/generic/hal.c: In function =91hal_read_proc=92:</d=
iv><div>kernel/xenomai/arch/generic/hal.c:577:13: error: =91IPIPE_MAJOR_NUM=
BER=92 undeclared (first use in this function)</div><div>kernel/xenomai/arc=
h/generic/hal.c:578:13: error: =91IPIPE_MINOR_NUMBER=92 undeclared (first u=
se in this function)</div>
<div>kernel/xenomai/arch/generic/hal.c:579:18: error: =91IPIPE_PATCH_NUMBER=
=92 undeclared (first use in this function)</div><div>kernel/xenomai/arch/g=
eneric/hal.c: In function =91rthal_init=92:</div><div>kernel/xenomai/arch/g=
eneric/hal.c:789:5: error: implicit declaration of function =91ipipe_alloc_=
virq=92</div>
<div>kernel/xenomai/arch/generic/hal.c:797:11: error: =91ipipe_current_doma=
in=92 undeclared (first use in this function)</div><div>kernel/xenomai/arch=
/generic/hal.c:797:11: error: =91IPIPE_HANDLE_MASK=92 undeclared (first use=
 in this function)</div>
<div>kernel/xenomai/arch/generic/hal.c:823:11: error: storage size of =91at=
tr=92 isn=92t known</div><div>kernel/xenomai/arch/generic/hal.c:823:11: err=
or: implicit declaration of function =91ipipe_init_attr=92</div><div>kernel=
/xenomai/arch/generic/hal.c:823:11: error: =91IPIPE_ROOT_PRIO=92 undeclared=
 (first use in this function)</div>
<div>kernel/xenomai/arch/generic/hal.c:823:11: error: implicit declaration =
of function =91ipipe_register_domain=92</div><div>kernel/xenomai/arch/gener=
ic/hal.c:823:11: warning: unused variable =91attr=92</div><div>kernel/xenom=
ai/arch/generic/hal.c:864:5: error: implicit declaration of function =91ipi=
pe_free_virq=92</div>
<div>kernel/xenomai/arch/generic/hal.c: In function =91rthal_exit=92:</div>=
<div>kernel/xenomai/arch/generic/hal.c:880:2: error: =91ipipe_current_domai=
n=92 undeclared (first use in this function)</div><div>kernel/xenomai/arch/=
generic/hal.c:894:2: error: implicit declaration of function =91ipipe_unreg=
ister_domain=92</div>
<div>kernel/xenomai/arch/generic/hal.c: At top level:</div><div>kernel/xeno=
mai/arch/generic/hal.c:1105:1: warning: type defaults to =91int=92 in decla=
ration of =91rthal_apc_pending=92</div><div>kernel/xenomai/arch/generic/hal=
.c: In function =91rthal_irq_release=92:</div>
<div>kernel/xenomai/arch/generic/hal.c:217:1: warning: control reaches end =
of non-void function</div><div>kernel/xenomai/arch/generic/hal.c: In functi=
on =91rthal_irq_request=92:</div><div>kernel/xenomai/arch/generic/hal.c:182=
:1: warning: control reaches end of non-void function</div>
<div>make[4]: *** [kernel/xenomai/arch/generic/hal.o] Error 1</div><div>mak=
e[3]: *** [kernel/xenomai/arch/generic] Error 2</div><div>make[2]: *** [ker=
nel/xenomai/arch] Error 2</div><div>make[1]: *** [kernel/xenomai] Error 2</=
div>
<div>make: *** [kernel] Error 2</div></div><div><br></div><div>Any help?</d=
iv><div><br></div>

--00163646dc3c1b897a0495bc5161--

