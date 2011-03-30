Message-ID: <4D93BA6F.6010203@domain.hid>
Date: Thu, 31 Mar 2011 01:19:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=LM5LNr1mT-f3xY-w-ATzRNPZX3hPVsFpG=TnC@mail.gmail.com>	<4D89A334.4090802@domain.hid>	<AANLkTikiEN7Pd-F2FqgXf9MGSTqg1wq_KxsumfZeR5xX@mail.gmail.com>	<4D93A7F9.8060108@domain.hid>	<AANLkTinmEU=a6SP4yf_jVDSVS8gTuNH-6N5ALT7aT4uT@mail.gmail.com>	<4D93AC71.7040700@domain.hid>
	<4D93B154.7030806@domain.hid>
In-Reply-To: <4D93B154.7030806@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] CLOCK_REALTIME synchronized to NTP
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Jeff Weber wrote:
>>> On Wed, Mar 30, 2011 at 5:00 PM, Gilles Chanteperdrix <
>>> gilles.chanteperdrix@xenomai.org> wrote:
>>>
>>>> Jeff Weber wrote:
>>>>> On Wed, Mar 23, 2011 at 2:37 AM, Gilles Chanteperdrix <
>>>>> gilles.chanteperdrix@xenomai.org> wrote:
>>>>>
>>>>>> Jeff Weber wrote:
>>>>>>> I need to timetag events from a realtime context with a
>>>> NPT-synchronized
>>>>>>> system clock.  This topic comes up periodically on the mailing list.
>>>>>>  Last I
>>>>>>> recall, there was talk of adding the capability via an alternate
>>>>>>> (non-CLOCK_REALTIME) clock_id. What is the status of this topic?
>>>>>> The CLOCK_HOST_REALTIME is available in the xenomai-head branch (to be
>>>>>> 2.6 branch, soon). It requires modifications of the I-pipe patch which
>>>>>> are available, at least, on x86, but are probably not really hard to
>>>>>> implement on other platforms.
>>>>>>
>>>>>  clock_gettime(CLOCK_HOST_REALTIME) fails when called from kernel, and
>>>> from
>>>>> clocktest.  Any ideas why?
>>>>> Does the CLOCK_HOST_REALTIME need to be initialized in some way?
>>>>> Test and config follow.
>> It definitely works here with clocktest. I get, for instance:
> 
> ... and it definitely does not work with a 32 bits kernel.
>

The problem is that in the x86_32 patch, nobody calls
ipipe_update_hostrt. The following patch should get it working. Though
may not be the cleanest way to do it.

And except for the "if (clock == clocksource_tsc)", is probably the way
we could get it working for other architectures.

I am not sure it really works, since the clocktest output seemed to have
much more jitter than on x86_64, though the jitter decreased over time.

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cef6fde..4ac1073 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -154,7 +154,7 @@ config GENERIC_CALIBRATE_DELAY

 config GENERIC_TIME_VSYSCALL
        bool
-       default X86_64
+       default X86_64 || HAVE_IPIPE_HOSTRT

 config ARCH_HAS_CPU_RELAX
        def_bool y
diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index d1d4544..04de06d 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <linux/clockchips.h>
 #include <linux/kprobes.h>
+#include <linux/ipipe_tickdev.h>
 #include <asm/unistd.h>
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -49,6 +50,7 @@
 #include <asm/apic.h>
 #endif /* CONFIG_X86_LOCAL_APIC */
 #include <asm/traps.h>
+#include <asm/tsc.h>

 int __ipipe_tick_irq = 0;      /* Legacy timer */

@@ -814,6 +816,19 @@ int __ipipe_check_tickdev(const char *devname)
        return ret;
 }

+#ifdef CONFIG_X86_32
+void update_vsyscall(struct timespec *wall_time, struct timespec *wtm,
+                       struct clocksource *clock, u32 mult)
+{
+       if (clock == &clocksource_tsc)
+               ipipe_update_hostrt(wall_time, clock);
+}
+
+void update_vsyscall_tz(void)
+{
+}
+#endif /* CONFIG_X86_32 */
+
 EXPORT_SYMBOL(__ipipe_tick_irq);

 EXPORT_SYMBOL_GPL(irq_to_desc);


-- 
                                                                Gilles.

