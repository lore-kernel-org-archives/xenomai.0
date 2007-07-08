Message-ID: <4690B062.4090000@domain.hid>
Date: Sun, 08 Jul 2007 03:37:38 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
References: <1183144465.6574.99.camel@domain.hid> <46908B79.30908@domain.hid>
	<1183882578.6014.58.camel@domain.hid>
In-Reply-To: <1183882578.6014.58.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Support for 2.6.22/x86
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Hi Jim,
>
> On Sun, 2007-07-08 at 01:00 -0600, Jim Cromie wrote:
>   
>> Philippe Gerum wrote:
>>     
>>> Our development trunk now contains the necessary support for running
>>> Xenomai over 2.6.22/x86. This work boils down to enabling Xenomai to use
>>> the generic clock event device abstraction that comes with newest
>>> kernels. Other archs / kernel versions still work the older way, until
>>> all archs eventually catch up with clockevents upstream.
>>>
>>> This support won't be backported to 2.3.x, because it has some
>>> significant impact on the nucleus. Tested as thoroughly as possible here
>>> on low-end and mid-range x86 boxen, including SMP.
>>>
>>> Please give this hell.
>>>
>>> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch
>>>
>>>   
>>>       
>> Ive been running 22-rc7 on my Sony VAIO with this patch applied since 
>> July 3,
>>
>> the only thing wrong Ive seen is that perl ( both bleed and maint )
>> is failing its time related regression tests.
>> ie
>>     rsync -avz rsync://public.activestate.com/perl-current/ .
>>     rsync -avz rsync://public.activestate.com/perl-5.8.x .
>>
>> Failed 3 tests out of 1429, 99.79% okay.
>>         ../ext/Time/HiRes/t/HiRes.t
>>         ../lib/Benchmark.t
>>         op/time.t
>>
>> the lib/Benchmark.t test is hanging, and must be killed manually
>>     
>
> Thanks for the feedback.
>
> Does this happen with the I-pipe switched off too?
> Also, is Xenomai patched in your kernel with any of the skins statically
> enabled, or just the I-pipe?
>
>   

Im not sure what 'switched off' means, so heres the 'relevant' parts of 
the .config
Now that I look at it, Ive obviously not attended to the advice in 
README.INSTALL.

This config worked nicely with ntp, FWIW.

Given that this is a laptop, Id like to keep ACPI and/or CPU-freq if 
possible,
but I'll try some combos to see if any work for both the battery,
and for the perl tests.  I'll try a conservative/recommended config too.
Any suggestions or test-requests are welcome.


vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.70GHz
stepping        : 6
cpu MHz         : 1700.000


#
# Real-time sub-system
#

#
# WARNING! You enabled APM, CPU Frequency scaling or ACPI 'processor'
#

#
# option. These options are known to cause troubles with Xenomai.
#


[jimc@domain.hid linux-2.6.22-rc7-ipipe-190-sony]$ grep XENO .config
CONFIG_XENOMAI=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_PRIOCPL=y
CONFIG_XENO_OPT_PIPELINE_HEAD=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY=y
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=128
CONFIG_XENO_OPT_STATS=y
# CONFIG_XENO_OPT_DEBUG is not set
# CONFIG_XENO_OPT_TIMING_PERIODIC is not set
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=y
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set
# CONFIG_XENO_OPT_SHIRQ_LEVEL is not set
# CONFIG_XENO_OPT_SHIRQ_EDGE is not set
CONFIG_XENO_HW_FPU=y
# CONFIG_XENO_HW_NMI_DEBUG_LATENCY is not set
# CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
CONFIG_XENO_HW_SMI_DETECT=y
# CONFIG_XENO_HW_SMI_WORKAROUND is not set
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_PERIOD=0
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=1024
CONFIG_XENO_OPT_NATIVE_REGISTRY=y
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_SKIN_POSIX=y
CONFIG_XENO_OPT_POSIX_PERIOD=0
# CONFIG_XENO_OPT_POSIX_SHM is not set
# CONFIG_XENO_OPT_POSIX_INTR is not set
CONFIG_XENO_OPT_DEBUG_POSIX=y
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_SKIN_RTAI is not set
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_OPT_RTDM_PERIOD=0
CONFIG_XENO_OPT_RTDM_FILDES=128
# CONFIG_XENO_DRIVERS_16550A is not set
# CONFIG_XENO_DRIVERS_TIMERBENCH is not set
# CONFIG_XENO_DRIVERS_IRQBENCH is not set
# CONFIG_XENO_DRIVERS_SWITCHTEST is not set
# CONFIG_XENO_DRIVERS_CAN is not set

[jimc@domain.hid linux-2.6.22-rc7-ipipe-190-sony]$ grep APM .config
# WARNING! You enabled APM, CPU Frequency scaling or ACPI 'processor'
# Power management options (ACPI, APM)
# CONFIG_APM is not set

[jimc@domain.hid linux-2.6.22-rc7-ipipe-190-sony]$ grep ACPI .config
# WARNING! You enabled APM, CPU Frequency scaling or ACPI 'processor'
# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_PROCFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=m
# CONFIG_ACPI_BAY is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_PNPACPI=y
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_BLK_DEV_IDEACPI is not set

[jimc@domain.hid linux-2.6.22-rc7-ipipe-190-sony]$ grep _PM .config
CONFIG_PM=y
# CONFIG_PM_LEGACY is not set
# CONFIG_PM_DEBUG is not set
# CONFIG_PM_SYSFS_DEPRECATED is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_VIDEO_PMS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set



