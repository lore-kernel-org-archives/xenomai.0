Date: Thu, 24 Mar 2016 08:04:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160324070428.GG22286@hermes.click-hack.org>
References: <CALxt+8tVMDmQYHv-80rm4LBNGpnqvaNkSiJssGZjg4YOd9w9+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALxt+8tVMDmQYHv-80rm4LBNGpnqvaNkSiJssGZjg4YOd9w9+Q@mail.gmail.com>
Subject: Re: [Xenomai] xenomai latency more than 100 microseconds on 3rd gen
 core i5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Grant Liu <grant7788@gmail.com>
Cc: xenomai@xenomai.org

On Thu, Mar 24, 2016 at 02:51:31PM +0800, Grant Liu wrote:
> Hello,
> 
> I have one X86 system using Ubuntu 12.04 with 3rd gen i5,
> and I try to get one real time system with < 50 us (microsecond) time
> period,
> but with xenomai 3.0.1, the latency is around 10us, and sometimes more than
> 100us (once per 50 seconds or so.)
> 
> Would you please kindly help to check it... Thanks in advance.
> 
> BRs,
> Grant
> 
> ============= System configuration ===========
> X86 system
> Intel 3rd generation i5, 8G RAM, 64G SSD
> Ubuntu 12.04, core version 3.18.20
> Xenomai 3.0.1, ipipe-core-3.18.20-x86-3.patch
> 
> I followed the installation guide:
> http://xenomai.org/installing-xenomai-3-x/#cobalt-core-x86
> and while make menuconfig, I followed this link:
> http://xenomai.org/2014/06/configuring-for-x86-based-dual-kernels/
> disabled the following items:
> CONFIG_APM
> CONFIG_ACPI_PROCESSOR
> CONFIG_CPU_FREQ
> CONFIG_CPU_IDLE
> CONFIG_CC_STACKPROTECTOR

The option CONFIG_CC_STACKPROTECTOR should not a problem with Xenomai 3.

Note that we need to amend the page with
CONFIG_MIGRATION
CONFIG_COMPACTION
But these options are probably not your problem given the trace you
sent.

> 
> I also tried to disable SMI while seems not success...
> add 'xenomai.smi=disabled' to kernel command line,
> but still see the result of 'rdmsr 0x34' changed while system
> running.

You should be able to verify whether the SMI workaround worked by
checking the kernel logs. You may find some option in the BIOS which
avoid SMIs, such as the "DTS" option. Note however that this option
is involved in thermal management, so if you disable it, you should
check the processor temperature.

> 
> the other attempts:
> disable / enable SMT (Hyperthreading( scheduler support
> Change Preemption Model (tested all 3 options)

The preemption model only has an influence on Linux tasks latency,
it has little influence (except some indirect effects on the I-cache
for instance) on latencies of Xenomai tasks.

> ...
> 
> The following are trace result using ./latency -f, hope useful...
> I-pipe worst-case tracing service on 3.18.20/ipipe release #3
> -------------------------------------------------------------
> CPU: 0, Begin: 1102363168656 cycles, Trace Points: 14 (-10/+6), Length: 26
> us
> Calibrated minimum trace-point overhead: 0.081 us
> 
>  +----- Hard IRQs ('|': locked)
>  |+-- Xenomai
>  ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
>  |||   +---------- Delay flag ('+': > 1 us, '!': > 10 us)
>  |||   |    +- NMI noise ('N')
>  |||   |    |
>   Type   User Val.   Time    Delay  Function (Parent)
>  |   #end     0x80000001  -792   0.136  check_preemption_disabled+0x8a
> (debug_smp_processor_id+0x12)
>      #func                -792   0.160  ipipe_restore_root+0x4
> (rcu_idle_enter+0x92)
>      #func                -792   0.149  ipipe_root_only+0xf
> (ipipe_restore_root+0x10)
>  |   #begin   0x80000001  -792   0.176  ipipe_root_only+0x2d
> (ipipe_restore_root+0x10)
>  |   #end     0x80000001  -792   0.158  ipipe_root_only+0x87
> (ipipe_restore_root+0x10)
>      #func                -792   3.093  arch_cpu_idle+0x3
> (cpu_startup_entry+0x243)
>      #func                -788   1.709  mwait_idle+0x4 (arch_cpu_idle+0xe)
>      #func                -787   0.238  __ipipe_halt_root+0x5
> (mwait_idle+0x5a)
>  |   #begin   0x80000000  -787   1.063  __ipipe_halt_root+0x1e
> (mwait_idle+0x5a)
>  |   +end     0x8000000e  -785 785.951  __ipipe_halt_root+0x49
> (mwait_idle+0x5a)

If you run latency -f again, does the trace always point to
__ipipe_halt_root? If so, you may have a problem with the processor
entering some deep sleep mode. A quick test to disable the idle
routine is to boot with "idle=poll". The long term option is to
configure your BIOS to avoid entering deep sleep states when idle.

-- 
					    Gilles.
https://click-hack.org

