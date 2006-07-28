Message-ID: <e325d110607280523n40b51f9frb07cd2e8447c0fe1@domain.hid>
Date: Fri, 28 Jul 2006 13:23:58 +0100
From: "Kim Chuan Lim" <lim.kim.chuan@domain.hid>
Subject: Re: [Xenomai-help] configuration of pentium III 1GHz
In-Reply-To: <44C9D75C.8000906@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e325d110607280158w436c5d53k5f0e3cee4b6015d9@domain.hid>
	<44C9D75C.8000906@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

> Looks to me like you patched a SuSE kernel with I-pipe, did you? I'm
> also running SuSE, but I always use a vanilla kernel as platform for
I'm using SuSE as the base platform to compile a vanilla kernel. :)

> Time to upgrade, 2.2 is out :). BTW, there is one potentially relevant
> fix even post 2.2: if you have CONFIG_DEBUG_SPINLOCK on, switch it off
> or upgrade to I-pipe 1.3-08.
My vanilla kernel source is located at the same directory as xenomai..

I downloaded the latest version of Xenomai from trunk just now ...

./prepare-kernel.sh --linux=../../linux-2.6.17
Target architecture [default i686]:

I think something wrong with the prepare-kernel.sh scripts.. can
someone fix it please?
I think that is the reason why i get the following compilation errors.

In file included from include/asm/xenomai/hal.h:107,
                 from kernel/xenomai/arch/generic/hal.c:43:
include/asm-generic/xenomai/hal.h:60:2: #error "Adeos kernel support
is required to run this software."
include/asm-generic/xenomai/hal.h:61:2: #error "See
http://download.gna.org/adeos/patches/"
In file included from include/asm/xenomai/hal.h:107,
                 from kernel/xenomai/arch/generic/hal.c:43:
include/asm-generic/xenomai/hal.h: In function `rthal_get_cpufreq':
include/asm-generic/xenomai/hal.h:189: error: storage size of
`sysinfo' isn't known
include/asm-generic/xenomai/hal.h:190: warning: implicit declaration
of function `ipipe_get_sysinfo'
include/asm-generic/xenomai/hal.h:189: warning: unused variable `sysinfo'
include/asm-generic/xenomai/hal.h: In function `rthal_get_timerfreq':
include/asm-generic/xenomai/hal.h:196: error: storage size of
`sysinfo' isn't known
include/asm-generic/xenomai/hal.h:196: warning: unused variable `sysinfo'
include/asm-generic/xenomai/hal.h: At top level:
include/asm-generic/xenomai/hal.h:461: error: syntax error before
"rthal_irq_handler_t"
include/asm-generic/xenomai/hal.h:461: warning: type defaults to `int'
in declaration of `rthal_irq_handler_t'
include/asm-generic/xenomai/hal.h:461: warning: data definition has no
type or storage class
include/asm-generic/xenomai/hal.h:462: error: syntax error before
"rthal_irq_ackfn_t"
include/asm-generic/xenomai/hal.h:462: warning: type defaults to `int'
in declaration of `rthal_irq_ackfn_t'
include/asm-generic/xenomai/hal.h:462: warning: data definition has no
type or storage class
include/asm-generic/xenomai/hal.h:486: error: `IPIPE_NR_CPUS'
undeclared here (not in a function)
include/asm-generic/xenomai/hal.h:486: error: `IPIPE_NR_FAULTS'
undeclared here (not in a function)
include/asm-generic/xenomai/hal.h:535: error: syntax error before
"rthal_irq_handler_t"
include/asm-generic/xenomai/hal.h:537: warning: function declaration
isn't a prototype
In file included from kernel/xenomai/arch/generic/hal.c:43:
include/asm/xenomai/hal.h: In function `rthal_timer_program_shot':
include/asm/xenomai/hal.h:190: warning: implicit declaration of
function `ipipe_trigger_irq'
include/asm/xenomai/hal.h:190: error: `IPIPE_SERVICE_IPI3' undeclared
(first use in this function)
include/asm/xenomai/hal.h:190: error: (Each undeclared identifier is
reported only once
include/asm/xenomai/hal.h:190: error: for each function it appears in.)
include/asm/xenomai/hal.h:196: error: `IPIPE_SERVICE_VECTOR3'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:62: error: `IPIPE_NR_CPUS'
undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:72: error: `IPIPE_NR_CPUS'
undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:84: error: `IPIPE_NR_CPUS'
undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:84: error: `IPIPE_NR_FAULTS'
undeclared here (not in a function)
kernel/xenomai/arch/generic/hal.c:84: error: conflicting types for
`rthal_realtime_faults'
include/asm-generic/xenomai/hal.h:486: error: previous declaration of
`rthal_realtime_faults'
kernel/xenomai/arch/generic/hal.c: In function `rthal_critical_enter':
kernel/xenomai/arch/generic/hal.c:90: warning: implicit declaration of
function `ipipe_critical_enter'
kernel/xenomai/arch/generic/hal.c: In function `rthal_critical_exit':
kernel/xenomai/arch/generic/hal.c:103: warning: implicit declaration
of function `ipipe_critical_exit'
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:155: error: syntax error before
"rthal_irq_handler_t"
kernel/xenomai/arch/generic/hal.c:157: warning: function declaration
isn't a prototype
kernel/xenomai/arch/generic/hal.c: In function `rthal_irq_request':
kernel/xenomai/arch/generic/hal.c:158: error: `handler' undeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:158: error: `irq' undeclared (first
use in this function)
kernel/xenomai/arch/generic/hal.c:158: error: `IPIPE_NR_IRQS'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:161: warning: implicit declaration
of function `ipipe_virtualize_irq'
kernel/xenomai/arch/generic/hal.c:161: error: `cookie' undeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:161: error: `ackfn' undeclared
(first use in this function)
kernel/xenomai/arch/generic/hal.c:161: error: `IPIPE_HANDLE_MASK'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:161: error: `IPIPE_EXCLUSIVE_MASK'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function `rthal_irq_release':
kernel/xenomai/arch/generic/hal.c:198: error: `IPIPE_NR_IRQS'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:201: error: `IPIPE_PASS_MASK'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function `rthal_irq_host_pend':
kernel/xenomai/arch/generic/hal.c:298: warning: implicit declaration
of function `ipipe_propagate_irq'
kernel/xenomai/arch/generic/hal.c: In function `rthal_apc_handler':
kernel/xenomai/arch/generic/hal.c:393: error: `ipipe_declare_cpuid'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:395: warning: implicit declaration
of function `ipipe_load_cpuid'
kernel/xenomai/arch/generic/hal.c:397: warning: implicit declaration
of function `spin_lock_hw'
kernel/xenomai/arch/generic/hal.c:413: warning: implicit declaration
of function `spin_unlock_hw'
kernel/xenomai/arch/generic/hal.c: In function `rthal_apc_alloc':
kernel/xenomai/arch/generic/hal.c:520: warning: implicit declaration
of function `ipipe_test_and_stall_pipeline_from'
kernel/xenomai/arch/generic/hal.c:531: warning: implicit declaration
of function `ipipe_restore_pipeline_from'
kernel/xenomai/arch/generic/hal.c: In function `rthal_apc_schedule':
kernel/xenomai/arch/generic/hal.c:598: error: `ipipe_declare_cpuid'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:606: warning: implicit declaration
of function `ipipe_schedule_irq'
kernel/xenomai/arch/generic/hal.c: In function `hal_read_proc':
kernel/xenomai/arch/generic/hal.c:631: error: `ADEOS_MAJOR_NUMBER'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:633: error: `ADEOS_MINOR_NUMBER'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c: In function `rthal_init':
kernel/xenomai/arch/generic/hal.c:815: warning: implicit declaration
of function `ipipe_alloc_virq'
kernel/xenomai/arch/generic/hal.c:823: error: `ipipe_current_domain'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:823: error: `IPIPE_HANDLE_MASK'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:849: error: storage size of `attr' isn't known
kernel/xenomai/arch/generic/hal.c:849: warning: implicit declaration
of function `ipipe_init_attr'
kernel/xenomai/arch/generic/hal.c:849: error: `IPIPE_ROOT_PRIO'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:849: warning: implicit declaration
of function `ipipe_register_domain'
kernel/xenomai/arch/generic/hal.c:849: warning: unused variable `attr'
kernel/xenomai/arch/generic/hal.c:890: warning: implicit declaration
of function `ipipe_free_virq'
kernel/xenomai/arch/generic/hal.c: In function `rthal_exit':
kernel/xenomai/arch/generic/hal.c:912: error: `ipipe_current_domain'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:926: warning: implicit declaration
of function `ipipe_unregister_domain'
kernel/xenomai/arch/generic/hal.c: At top level:
kernel/xenomai/arch/generic/hal.c:1069: error: storage size of
`rthal_domain' isn't known
kernel/xenomai/arch/generic/hal.c:84: error: storage size of
`rthal_realtime_faults' isn't known
kernel/xenomai/arch/generic/hal.c:72: error: storage size of
`rthal_apc_pending' isn't known
kernel/xenomai/arch/generic/hal.c:72: warning: `rthal_apc_pending'
defined but not used

Regards,
Kim Chuan.

