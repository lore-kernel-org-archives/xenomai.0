Message-ID: <50F505C3.3090803@xenomai.org>
Date: Tue, 15 Jan 2013 08:31:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50F19CE1.5080106@zultron.com> <50F19DE4.4030805@xenomai.org>
	<50F239E1.40400@zultron.com> <50F2A59D.5050600@xenomai.org>
	<50F30781.3050302@zultron.com> <50F30DE5.7030007@xenomai.org>
	<50F38DD5.5010105@zultron.com> <50F3F2C6.2040900@xenomai.org>
	<50F3F359.9020502@siemens.com> <50F409C0.7050701@siemens.com>
	<50F46FF8.5050100@zultron.com> <50F48CBB.7080605@xenomai.org>
	<50F5025E.1040500@zultron.com>
In-Reply-To: <50F5025E.1040500@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 3.5.7 posix/mprotect fixed;
 (Was:  posix/mprotect failure)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 01/15/2013 08:16 AM, John Morris wrote:

> 
> 
> On 01/14/2013 04:54 PM, Gilles Chanteperdrix wrote:
>> On 01/14/2013 09:52 PM, John Morris wrote:
>>> http://www.zultron.com/static/2013/01/xenomai/3.5.7-test/foo-gdb-posix-mprotect-3.5.7-test.log
>>
>>
>> So, you are compiling with _FORTIFY_SOURCE, that is the difference with
>> how we are compiling. Is it easy for you to set _FORTIFY_SOURCE to 0?
> 
> Wow, you picked that out instantly.  That fixes it.  RH-like distros
> define _FORTIFY_SOURCE in the default CFLAGS, worthy of a wiki note:
> 
> http://fedoraproject.org/wiki/Security/Features#Compile_Time_Buffer_Checks_.28FORTIFY_SOURCE.29
> 
> I'm guessing that Xenomai-enabled applications won't have to worry about
> this, because they'll only be compiling header files.  Is that about
> right, or should there be a notice in the -devel package?


No, unfortunately, this is a problem, applications compiled with
-D_FORTIFY_SOURCE will not get proper symbols substitution by xenomai
library for the printf functions. The fix is to implement the checking
variants in xenomai library, so as to be able to have FORTIFY_SOURCE and
symbols susbtitution.

> 
> 
> Here's the latest xeno-regression-test run:
> 
> http://www.zultron.com/static/2013/01/xenomai/3.5.7-test/foo-xeno-regression-test-3.5.7-test.log
> 
> The latest xeno-regression-test run still has a few small problems:
> 
> 1)  "xddp_test" fails:  "...IPCPROTO_XDDP): Address family not supported
> by protocol".  DRIVERS_RTIPC_XDDP is enabled in the config.  Doesn't
> look like others have experienced this before.  LinuxCNC doesn't use
> XDDP, but it should be fixed for the general audience.


You are missing some kernel drivers. I used the following options in the
Debian configuration: basically, all options enabled (some as module,
because they are expected to be used less often).

CONFIG_XENOMAI=y
CONFIG_XENO_GENERIC_STACKPOOL=y
CONFIG_XENO_FASTSYNCH=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
# CONFIG_XENO_OPT_PRIOCPL is not set
CONFIG_XENO_OPT_PIPELINE_HEAD=y
# CONFIG_XENO_OPT_SCHED_CLASSES is not set
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_MAP=y
CONFIG_XENO_OPT_VFILE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=4096
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=4096
CONFIG_XENO_OPT_SEM_HEAPSZ=12
CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=12
CONFIG_XENO_OPT_STATS=y
CONFIG_XENO_OPT_DEBUG=y
# CONFIG_XENO_OPT_DEBUG_NUCLEUS is not set
# CONFIG_XENO_OPT_DEBUG_XNLOCK is not set
# CONFIG_XENO_OPT_DEBUG_QUEUES is not set
# CONFIG_XENO_OPT_DEBUG_REGISTRY is not set
# CONFIG_XENO_OPT_DEBUG_TIMERS is not set
CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX=y
CONFIG_XENO_OPT_WATCHDOG=y
CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=4
CONFIG_XENO_OPT_SHIRQ=y
CONFIG_XENO_OPT_SELECT=y
CONFIG_XENO_OPT_HOSTRT=y
CONFIG_XENO_OPT_TIMING_PERIODIC=y
CONFIG_XENO_OPT_TIMING_VIRTICK=1000
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=y
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set
CONFIG_XENO_HW_FPU=y
# CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
CONFIG_XENO_HW_SMI_DETECT=y
# CONFIG_XENO_HW_SMI_WORKAROUND is not set
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_PERIOD=0
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=1024
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_BUFFER=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
# CONFIG_XENO_OPT_NATIVE_INTR is not set
# CONFIG_XENO_OPT_DEBUG_NATIVE is not set
CONFIG_XENO_SKIN_POSIX=y
CONFIG_XENO_OPT_POSIX_PERIOD=0
# CONFIG_XENO_OPT_POSIX_SHM is not set
# CONFIG_XENO_OPT_POSIX_INTR is not set
CONFIG_XENO_OPT_POSIX_SELECT=y
# CONFIG_XENO_OPT_DEBUG_POSIX is not set
CONFIG_XENO_SKIN_PSOS=m
CONFIG_XENO_OPT_PSOS_PERIOD=1000
# CONFIG_XENO_OPT_DEBUG_PSOS is not set
CONFIG_XENO_SKIN_UITRON=m
CONFIG_XENO_OPT_UITRON_PERIOD=1000
# CONFIG_XENO_OPT_DEBUG_UITRON is not set
CONFIG_XENO_SKIN_VRTX=m
CONFIG_XENO_OPT_VRTX_PERIOD=1000
CONFIG_XENO_SKIN_VXWORKS=m
CONFIG_XENO_OPT_VXWORKS_PERIOD=1000
# CONFIG_XENO_OPT_DEBUG_VXWORKS is not set
# CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_OPT_RTDM_PERIOD=0
CONFIG_XENO_OPT_RTDM_FILDES=128
CONFIG_XENO_OPT_RTDM_SELECT=y
# CONFIG_XENO_OPT_DEBUG_RTDM is not set
# CONFIG_XENO_OPT_DEBUG_RTDM_APPL is not set
CONFIG_XENO_DRIVERS_16550A=m
# CONFIG_XENO_DRIVERS_16550A_PIO is not set
# CONFIG_XENO_DRIVERS_16550A_MMIO is not set
CONFIG_XENO_DRIVERS_16550A_ANY=y
CONFIG_XENO_DRIVERS_16550A_PCI=y
CONFIG_XENO_DRIVERS_16550A_PCI_MOXA=y
CONFIG_XENO_DRIVERS_TIMERBENCH=y
CONFIG_XENO_DRIVERS_KLATENCY=m
CONFIG_XENO_DRIVERS_IRQBENCH=m
CONFIG_XENO_DRIVERS_SWITCHTEST=y
CONFIG_XENO_DRIVERS_RTDMTEST=m
CONFIG_XENO_DRIVERS_CAN=m
CONFIG_XENO_DRIVERS_CAN_DEBUG=y
# CONFIG_XENO_DRIVERS_CAN_LOOPBACK is not set
CONFIG_XENO_DRIVERS_CAN_RXBUF_SIZE=1024
CONFIG_XENO_DRIVERS_CAN_MAX_DEVICES=4
CONFIG_XENO_DRIVERS_CAN_MAX_RECEIVERS=16
CONFIG_XENO_DRIVERS_CAN_BUS_ERR=y
# CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD is not set
CONFIG_XENO_DRIVERS_CAN_VIRT=m
# CONFIG_XENO_DRIVERS_CAN_FLEXCAN is not set
CONFIG_XENO_DRIVERS_CAN_SJA1000=m
CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA=m
CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM=m
CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_PCI=m
CONFIG_XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI=m
CONFIG_XENO_DRIVERS_CAN_SJA1000_ADV_PCI=m
CONFIG_XENO_DRIVERS_CAN_SJA1000_PLX_PCI=m
CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI=m
CONFIG_XENO_DRIVERS_CAN_SJA1000_ESD_PCI=m
CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_DNG=m
CONFIG_XENO_DRIVERS_ANALOGY=m
CONFIG_XENO_DRIVERS_ANALOGY_DEBUG=y
CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_LEVEL=0
CONFIG_XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL=0
CONFIG_XENO_DRIVERS_ANALOGY_FAKE=m
CONFIG_XENO_DRIVERS_ANALOGY_8255=m
CONFIG_XENO_DRIVERS_ANALOGY_PARPORT=m
CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE=m
CONFIG_XENO_DRIVERS_ANALOGY_NI_TIO=m
CONFIG_XENO_DRIVERS_ANALOGY_NI_MIO=m
CONFIG_XENO_DRIVERS_ANALOGY_NI_PCIMIO=m
CONFIG_XENO_DRIVERS_ANALOGY_NI_670x=m
CONFIG_XENO_DRIVERS_ANALOGY_NI_660x=m
CONFIG_XENO_DRIVERS_ANALOGY_S526=m
CONFIG_XENO_DRIVERS_RTIPC=y
CONFIG_XENO_DRIVERS_RTIPC_XDDP=y
CONFIG_XENO_DRIVERS_RTIPC_IDDP=y
CONFIG_XENO_OPT_IDDP_NRPORT=32
CONFIG_XENO_DRIVERS_RTIPC_BUFP=y
CONFIG_XENO_OPT_BUFP_NRPORT=32


> 
> 2)  "clocktest -C 42 -T 30" fails; apparently expected in some
> circumstances ('... || :').  Does anything need to be fixed here?  The
> test system switched to acpi_pm, and the TSCs on the dual-core are
> unsynched.  We don't know if the end-user's application will lock the
> process to a single CPU, so CLOCK_HOST_REALTIME isn't the best choice,
> even if it were somehow available.


Yes, if linux does not use the tsc for CLOCK_REALTIME,
CLOCK_HOST_REALTIME does not work.


> 
> 3)  "Warning: Linux is compiled to use FPU in kernel-space" in dmesg:
> Ignoring:  disabling (at least) software RAID breaks the
> 'one-size-fits-all' goal, and Gilles states this is harmless:
> http://www.xenomai.org/pipermail/xenomai/2009-May/016743.html


It means that the switchtest test does not really test every possible
FPU switch. So, in order to validate thoroughly a release, you should
compile a kernel without the conflicting options, run
xeno-regression-test, then compile the final kernel, and run
xeno-regression-test again.

Regards.

-- 
                                                                Gilles.

