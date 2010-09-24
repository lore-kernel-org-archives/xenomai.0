MIME-Version: 1.0
Date: Fri, 24 Sep 2010 22:05:37 +0200
Message-ID: <AANLkTimFXFr48DgXSj=53pNjAQB7w+mjOwwuEYQXc3KV@mail.gmail.com>
From: Gajamohan Mohanarajah <gajamohan.m@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] switchtest/xeon-test fails: Help needed (Ubuntu/Core
	i7)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I'm am new to Xenomai and would appreciate any help / hint on solving
the following problems.
1. My switchtest fails with ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK):
Cannot allocate memory.
If increasing CONFIG_XENO_OPT_SYS_HEAPSZ is the solution what is the
recommended value ? (1024k did not work)
(FYI: Memory 8GB )
2. xeno-test fails with [something died a XXXX or ...]
3. I am compiling the kernel using [fakeroot make-kpkg --initrd
--append-to-version=-xenomaiflv kernel-image kernel-headers
--overlay-dir=$HOME/kernel-package]. After changing just the
CONFIG_XENO_OPT_SYS_HEAPSZ via [make menuconfig], when I issue the the
above command, the kernel goes on to a full recompile which  takes 2
hours :(. Shouldn't it compile just the relevent parts ? (FYI i am not
using [make-kpkg clean]). Please enlighten me on this.

Thank you very much in advance.
Gajan

For your reference:

gajan@domain.hid$ sudo ./switchtest -T10
[sudo] password for gajan:
== Testing FPU check routines...
r0: 1 != 2
r1: 1 != 2
r2: 1 != 2
r3: 1 != 2
r4: 1 != 2
r5: 1 != 2
r6: 1 != 2
r7: 1 != 2
== FPU check routines: OK.
ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory
== Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9
rtup_ufpp0-10 rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15
rtuo0-16 rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20
rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22 sleeper_ufps1-0 rtk1-1 rtk1-2
rtk_fp1-3 rtk_fp1-4 rtk_fp_ufpp1-5 rtk_fp_ufpp1-6 rtup1-7 rtup1-8
rtup_ufpp1-9 rtup_ufpp1-10 rtus1-11 rtus1-12 rtus_ufps1-13
rtus_ufps1-14 rtuo1-15 rtuo1-16 rtuo_ufpp1-17 rtuo_ufpp1-18
rtuo_ufps1-19 rtuo_ufps1-20 rtuo_ufpp_ufps1-21 rtuo_ufpp_ufps1-22
sleeper_ufps2-0 rtk2-1 rtk2-2 rtk_fp2-3RTT|  357043:30:42
RTH|---------cpu|ctx switches|-------total
RTD|           0|           0|           0
RTD|           1|           0|           0
RTD|           2|           0|           0

gajan@domain.hid$ uname -a
Linux totoro 2.6.32.15+drm33.5-xenomaiflv #2 SMP PREEMPT Fri Sep 24
20:07:59 CEST 2010 x86_64 GNU/Linux

gajan@domain.hid$ cat /proc/cpuinfo | grep "model name"
model name	: Intel(R) Core(TM) i7 CPU         880  @ 3.07GHz
model name	: Intel(R) Core(TM) i7 CPU         880  @ 3.07GHz
model name	: Intel(R) Core(TM) i7 CPU         880  @ 3.07GHz
model name	: Intel(R) Core(TM) i7 CPU         880  @ 3.07GHz


gajan@domain.hid$ sudo ./latency -t0 -p200 -f -T50
== Sampling period: 200 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 200 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      0.087|      0.670|      1.992|       0|     0|      0.087|      1.992
RTD|      0.371|      0.651|      1.338|       0|     0|      0.087|      1.992
RTD|     -0.083|      0.648|      2.351|       0|     0|     -0.083|      2.351
RTD|      0.377|      0.665|      1.583|       0|     0|     -0.083|      2.351
RTD|      0.060|      0.662|      1.622|       0|     0|     -0.083|      2.351
RTD|      0.371|      0.657|      1.266|       0|     0|     -0.083|      2.351
RTD|      0.004|      0.653|      1.927|       0|     0|     -0.083|      2.351
RTD|      0.372|      0.640|      1.700|       0|     0|     -0.083|      2.351
RTD|      0.070|      0.659|      1.614|       0|     0|     -0.083|      2.351
RTD|      0.352|      0.660|      1.456|       0|     0|     -0.083|      2.351
RTD|     -0.064|      0.641|      1.315|       0|     0|     -0.083|      2.351
RTD|      0.299|      0.641|      1.501|       0|     0|     -0.083|      2.351
RTD|      0.085|      0.659|      1.643|       0|     0|     -0.083|      2.351
RTD|      0.235|      0.649|      1.196|       0|     0|     -0.083|      2.351
RTD|     -0.077|      0.644|      1.799|       0|     0|     -0.083|      2.351
RTD|      0.202|      0.637|      1.701|       0|     0|     -0.083|      2.351
RTD|      0.147|      0.664|      1.567|       0|     0|     -0.083|      2.351
RTD|      0.165|      0.635|      2.342|       0|     0|     -0.083|      2.351
RTD|     -0.057|      0.646|      1.402|       0|     0|     -0.083|      2.351
RTD|      0.073|      0.629|      1.701|       0|     0|     -0.083|      2.351
RTD|     -0.013|      0.655|      2.133|       0|     0|     -0.083|      2.351
RTT|  00:00:22  (periodic user-mode task, 200 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     -0.084|      0.618|      1.240|       0|     0|     -0.084|      2.351
RTD|     -0.006|      0.647|      1.386|       0|     0|     -0.084|      2.351
RTD|      0.365|      0.642|      1.621|       0|     0|     -0.084|      2.351
RTD|      0.104|      0.667|      1.702|       0|     0|     -0.084|      2.351
RTD|      0.370|      0.660|      1.844|       0|     0|     -0.084|      2.351
RTD|     -0.019|      0.657|      1.587|       0|     0|     -0.084|      2.351
RTD|      0.371|      0.645|      1.751|       0|     0|     -0.084|      2.351
RTD|      0.122|      0.668|      1.598|       0|     0|     -0.084|      2.351
RTD|      0.372|      0.664|      1.880|       0|     0|     -0.084|      2.351
RTD|      0.065|      0.664|      1.404|       0|     0|     -0.084|      2.351
RTD|      0.375|      0.661|      1.658|       0|     0|     -0.084|      2.351
RTD|      0.172|      0.664|      2.426|       0|     0|     -0.084|      2.426
RTD|      0.376|      0.662|      1.704|       0|     0|     -0.084|      2.426
RTD|     -0.065|      0.660|      1.659|       0|     0|     -0.084|      2.426
RTD|      0.371|      0.656|      1.610|       0|     0|     -0.084|      2.426
RTD|     -0.034|      0.660|      1.703|       0|     0|     -0.084|      2.426
RTD|      0.418|      0.671|      1.908|       0|     0|     -0.084|      2.426
RTD|     -0.037|      0.658|      1.626|       0|     0|     -0.084|      2.426
RTD|      0.370|      0.655|      1.737|       0|     0|     -0.084|      2.426
RTD|     -0.095|      0.657|      1.762|       0|     0|     -0.095|      2.426
RTD|      0.369|      0.666|      1.779|       0|     0|     -0.095|      2.426
RTT|  00:00:43  (periodic user-mode task, 200 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      0.092|      0.659|      1.465|       0|     0|     -0.095|      2.426
RTD|      0.370|      0.651|      1.542|       0|     0|     -0.095|      2.426
RTD|     -0.089|      0.646|      1.639|       0|     0|     -0.095|      2.426
RTD|      0.384|      0.668|      2.033|       0|     0|     -0.095|      2.426
RTD|      0.156|      0.658|      1.534|       0|     0|     -0.095|      2.426
RTD|      0.382|      0.665|      1.748|       0|     0|     -0.095|      2.426
RTD|     -0.065|      0.650|      1.850|       0|     0|     -0.095|      2.426
RTD|      0.385|      0.669|      1.801|       0|     0|     -0.095|      2.426
---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     -0.095|      0.655|      2.426|       0|     0|    00:00:50/00:00:50

xeno-test: running tests

Fri Sep 24 21:36:43 CEST 2010
running: ./xeno-config --verbose
xeno-config --verbose
        --version="2.5.4"
        --cc="gcc"
        --arch="x86"
        --prefix="/usr/xenomai"
        --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__"
        --xeno-ldflags="-L/usr/xenomai/lib -lxenomai -lpthread "
        --posix-cflags=""
        --posix-ldflags="-Wl,@/usr/xenomai/lib/posix.wrappers
-L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt "
        --library-dir="/usr/xenomai/lib"

Fri Sep 24 21:36:43 CEST 2010
running: ./xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux totoro 2.6.32.15+drm33.5-xenomaiflv #2 SMP PREEMPT Fri Sep 24
20:07:59 CEST 2010 x86_64 GNU/Linux

Gnu C                  4.4.3-4ubuntu5)
Gnu make               3.81
util-linux             ng 2.17.2)
mount                  ng 2.17.2 (with libblkid and selinux support)
module-init-tools      3.11.1
e2fsprogs              1.41.11
PPP                    2.4.5
Linux C Library        2.11.1
Dynamic linker (ldd)   2.11.1
Procps                 3.2.8
Net-tools              1.60
Kbd                    1.15
Sh-utils               7.4
Modules Loaded         binfmt_misc ppdev nouveau ttm drm_kms_helper
drm i2c_algo_bit snd_hda_codec_realtek snd_hda_intel snd_hda_codec
snd_hwdep snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss
snd_seq_midi snd_rawmidi psmouse snd_seq_midi_event serio_raw snd_seq
snd_timer snd_seq_device lp snd soundcore snd_page_alloc parport
dcdbas vga16fb vgastate usbhid hid e1000 tg3 ahci fbcon tileblit font
bitblit softcursor

Fri Sep 24 21:36:43 CEST 2010
running: cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         880  @ 3.07GHz
stepping	: 5
cpu MHz		: 3059.346
cache size	: 8192 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida tpr_shadow vnmi
flexpriority ept vpid
bogomips	: 6118.69
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         880  @ 3.07GHz
stepping	: 5
cpu MHz		: 3059.346
cache size	: 8192 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida tpr_shadow vnmi
flexpriority ept vpid
bogomips	: 6117.95
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         880  @ 3.07GHz
stepping	: 5
cpu MHz		: 3059.346
cache size	: 8192 KB
physical id	: 0
siblings	: 4
core id		: 2
cpu cores	: 4
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida tpr_shadow vnmi
flexpriority ept vpid
bogomips	: 6117.97
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         880  @ 3.07GHz
stepping	: 5
cpu MHz		: 3059.346
cache size	: 8192 KB
physical id	: 0
siblings	: 4
core id		: 3
cpu cores	: 4
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida tpr_shadow vnmi
flexpriority ept vpid
bogomips	: 6117.96
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:


Fri Sep 24 21:36:43 CEST 2010
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
239798129e94a8be7e47565eac9ee303  /proc/cpuinfo
# CONFIG_TREE_PREEMPT_RCU is not set
CONFIG_PREEMPT_NOTIFIERS=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_IPIPE=y
CONFIG_IPIPE_DOMAINS=4
CONFIG_IPIPE_COMPAT=y
CONFIG_IPIPE_DELAYED_ATOMICSW=y
# CONFIG_IPIPE_UNMASKED_CONTEXT_SWITCH is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_VERBOSE is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_SLEEP=y
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_DISABLE_CONSOLE=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_RUNTIME=y
# CONFIG_ACPI is not set
# CONFIG_CPU_FREQ is not set
CONFIG_PMIC_DA903X=y
# CONFIG_IPIPE_DEBUG is not set
CONFIG_DEBUG_PREEMPT=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_PREEMPT_TRACER is not set

Fri Sep 24 21:36:43 CEST 2010
running: cat /proc/ipipe/Linux
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
   0:  A....
   1:  A....
   2:  A....
   3:  A....
   4:  A.L..
   5:  A....
   6:  A.L..

