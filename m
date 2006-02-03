Message-ID: <43E329DF.4010403@domain.hid>
Date: Fri, 03 Feb 2006 11:01:03 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] some results on my laptop
References: <43E288AA.3050203@domain.hid>	<43E28EE8.3020103@domain.hid>	<43E2A31D.9000807@domain.hid>	<43E30B8D.6030507@domain.hid>
	<43E31186.1000007@domain.hid> <43E31EE0.8020808@domain.hid>
	<43E323CC.4040306@domain.hid>
In-Reply-To: <43E323CC.4040306@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Anders Blomdell wrote:
> 
>>Jan Kiszka wrote:
>>
>>>...and may also add further latencies with the system has to speed up
>>>again. Anyway, there might be use-cases where power consumption is -
>>>besides latency - also an important issue. I'm just thinking of our
>>>smaller mobile robots where the power demand of the drives and the
>>>controller are not that far apart as on the larger platforms.
>>>
>>>What about other time sources on x86? Which systems already have HPET
>>>these days, and does this source not suffer from frequency scaling? I
>>>once read that HPET is quite easy to program, is this true? IOW, would
>>>it be worth considering to add this to the HAL?
>>
>>If it an computer with ACPI (which is very likely), one could use the PM
>>Timer (3.579545 MHz) as the base system clock, and sync with TSC at
>>every clockscaling and power events (the reason for that is that PM
>>Timer reads  are quite slow (around 1 microsecond on the hardwares I
>>have tested), so most timer stuff should go via TSC).
>>
>>The advantage with this is that the system will keep accurate time even
>>in the low power modes (when TSC is turned off). I have done a crude
>>implementation of this on KURT (http://www.ittc.ku.edu/kurt/), and it is
>>a workable solution
> 
> 
> Oh, KURT still exists? Appeared a bit unmaintained to me last time I
> checked.
Maintained, but results are unfortunately not propagated to their homepage. We 
are currently running a 2.6.12 version, which is (for our purposes) essentially 
is Ingo Molnars patches + microsecond timer resolution.

>>There are also good research/development oppurtunities in:
>>
>>  1. scheduling ACPI wakeup from those low-power modes in such good
>>     time that all realtime requirements are met :-)
>>  2. scheduling of clockscaling changes to make minimum impact
>>     on realtime tasks
>>
>>(For ACPI, see http://www.acpi.info/DOWNLOADS/ACPIspec30a.pdf)
>>
> 
> 
> Hmm, though likely feasible, this sounds like it requires some effort,
> especially the infrastructure to access ACPI directly (I guess we would
> still have to switch it off for Linux, wouldn't we?) and to set up the
> power event hooks. 
Or present our own virtual ACPI controller to Linux, and enforce our timing 
constraints while trying to keep power as low as Linux want us to.

> How much code was involved in your KURT add-on? Can
> you extract it as a patch to asses the required work? I'm not planing to
> work on this, but if it is not too complicated, someone may once pick it
> up and integrate it in Xenomai.
I guess this is approximately the patch (which always reads the PM Timer, which 
is not good for performance). It also does nothing to prevent Linux from doing 
Power management, the only thing it does, is to keep wall time and computer time 
in sync.

===================================================================
--- include/linux/mutime.h      (revision 1334)
+++ include/linux/mutime.h      (working copy)
@@ -144,6 +144,8 @@
          */
         atomic_t jiffies_intr;

+       time_standard_t volatile cycles_lost;
+        long cpu_khz;
         time_standard_t volatile cycles_at_last_jiffy;
         time_standard_t volatile cycles_at_next_jiffy;
         time_standard_t volatile cycles_at_last_wall_jiffy;
@@ -290,11 +292,13 @@
  #define utimespec_to_timespec(x,y) \
         utime_subjiffies_to_timespec ((x)->jiffies, (x)->subjiffies, y)

-static inline time_standard_t get_time_standard(void)
+extern time_standard_t get_time_standard(void);
+extern void sync_time_standard_to_acpi(long pm_timer);
+/*static inline time_standard_t get_time_standard(void)
  {
        return get_cycles();
  }
-
+*/
  /* Compares two timer values.  Returns:
   * -1 if timer1 is set for earlier than timer2.
   * 0 if timer1 and timer2 are set for the same time.
Index: Makefile
===================================================================
--- Makefile    (revision 1334)
+++ Makefile    (working copy)
@@ -1,7 +1,7 @@
  VERSION = 2
  PATCHLEVEL = 6
  SUBLEVEL = 12
-EXTRAVERSION = -RT-V0.7.50-04-utime
+EXTRAVERSION = -RT-V0.7.50-04-laptop
  NAME=Woozy Numbat

  # *DOCUMENTATION*
Index: drivers/utime/utime.c
===================================================================
--- drivers/utime/utime.c       (revision 1334)
+++ drivers/utime/utime.c       (working copy)
@@ -41,10 +41,14 @@
  #include <linux/utimedev.h>
  #include <asm/div64.h>
  #include <linux/seq_file.h>
+#include <linux/cpufreq.h>
+#include <acpi/acpi_bus.h>

  /* Standard kernel module header files */
  #include <linux/module.h> /* For doing modules */
  #include <linux/init.h> /* For doing kernel work */
+#define DEB(i) outb_p(1<<i, 0x378)
+static int switched = 0;

  #define __UTIME_DEBUG__
  #ifdef __UTIME_DEBUG__
@@ -162,7 +166,12 @@
   */
  static inline void internal_update_system_time(void)
  {
-       time_standard_t elapsed;
+        signed long long elapsed;
+       int n;
+       /* elapsed is signed to handle the case where
+        * get_time_standard() < utime_state.cycles_at_last_jiffy,
+        * which can happen when cpu frequency is changed
+        */

         /* Here's the part we care about.  We want to save the result
          * from the get_time_standard call into last_update.
@@ -175,7 +184,15 @@

         /* Have any jiffies elapsed since our last update?
          */
-       while (elapsed >= utime_state.time_standard_per_jiffy) {
+       n = 0;
+       while (elapsed > 0 &&
+              elapsed >= utime_state.time_standard_per_jiffy) {
+         n++;
+         outb_p(0x80, 0x378);
+         if (switched && elapsed < 0) {
+           printk("elapsed=%Ld %d\n", elapsed, n);
+           BUG();
+         }
                 utime_state.cycles_at_last_jiffy =
                         utime_state.cycles_at_next_jiffy;
                 utime_state.cycles_at_next_jiffy +=
@@ -183,6 +200,7 @@
                 elapsed -= utime_state.time_standard_per_jiffy;
                 atomic_inc(&utime_state.jiffies_intr);
                 jiffies_64++;
+          outb_p(0x40, 0x378);
         }

         /* Now calculate the new subjiffies with what's left in
@@ -228,7 +246,45 @@
         internal_update_system_time();
         write_sequnlock_irqrestore(&xtime_lock, flags);
  }
+
+static time_standard_t acpi_ts = 0;
+static long saved_pm_timer = 0;

+extern void sync_time_standard_to_acpi(long pm_timer)
+{
+  unsigned long flags;
+  DEB(1);
+  pm_timer = pm_timer & 0xffffff;
+  local_irq_save(flags);
+  if (acpi_ts == 0) {
+    acpi_ts += 0x1000000;
+  } else if (pm_timer < saved_pm_timer ) {
+    acpi_ts += 0x1000000;
+  }
+  saved_pm_timer = pm_timer;
+  local_irq_restore(flags);
+  DEB(2);
+}
+
+time_standard_t get_time_standard(void)
+{
+  time_standard_t result;
+  unsigned long flags;
+  u32 pm_timer;
+  static u32 t_old;
+  static time_standard_t ts = 0;
+
+  local_irq_save(flags);
+  pm_timer = inl(acpi_fadt.xpm_tmr_blk.address) & 0xffffff;
+  sync_time_standard_to_acpi(pm_timer);
+  result = acpi_ts + pm_timer;
+  local_irq_restore(flags);
+
+//  result = get_cycles() + utime_state.cycles_lost;
+
+  return result<<4;
+}
+
  void get_system_time(unsigned long *j, u32 *u)
  {
         unsigned long flags;
@@ -736,6 +792,7 @@

         unsigned long flags;

+       DEB(0);
         local_irq_save(flags);
         /* Clear the interrupt expected flag, before we go to
          * internal_program_next_event. This used to live in
@@ -767,18 +824,23 @@
                  * there is nothing to do, but this is left as a
                  * placeholder.
                  */
+               DEB(1);
                 orig_do_timer(regs);
                 atomic_dec(&utime_state.jiffies_intr);
+               DEB(2);
         }

         /*
          * Update system time and reprogram the timer chip for the
          * next event
          */
+       DEB(3);
         internal_update_system_time();

+       DEB(4);
         internal_program_next_event();

+       DEB(5);
         dotimer_active = 0;

         local_irq_restore(flags);
@@ -1020,6 +1082,7 @@
         unsigned long flags;

         printk("Calibrating UTIME \n");
+       utime_state.time_standard_per_sec = 3579545<<4;
         if (!utime_state.time_standard_per_sec) {
                 time_standard_t diff;
                 if (UTIME_TSC_HZ) {
@@ -1301,6 +1364,57 @@
  }
  EXPORT_SYMBOL(set_utime_state);

+/*
+ * CPU frequency scaling handler
+ */
+static inline time_standard_t
+utime_cpufreq_scale(time_standard_t old, u_int div, u_int mult)
+{
+  time_standard_t result = ((time_standard_t) old) * ((time_standard_t) mult);
+  do_div(result, div);
+  return result;
+};
+
+static int
+time_cpufreq_notifier(struct notifier_block *nb, unsigned long val, void *data)
+{
+  unsigned long flags;
+  struct cpufreq_freqs *freq = data;
+  static time_standard_t ref_per_sec = 0;
+  static time_standard_t ref_per_jiffy = 0;
+  static time_standard_t ref_per_subjiffy = 0;
+  static u_int ref_freq = 0;
+
+  printk("cpufreq val=%lx old=%d new=%d ref=%d\n",
+        val, freq->old, freq->new, ref_freq);
+  if (val == CPUFREQ_PRECHANGE) {
+    write_seqlock_irqsave(&xtime_lock, flags);
+    if (!ref_freq) {
+      ref_per_sec = utime_state.time_standard_per_sec;
+      ref_per_jiffy = utime_state.time_standard_per_jiffy;
+      ref_per_subjiffy = utime_state.time_standard_per_subjiffy;
+      ref_freq = freq->old;
+    }
+    if (ref_freq) {
+      utime_state.time_standard_per_sec =
+       utime_cpufreq_scale(ref_per_sec, ref_freq, freq->new);
+      utime_state.time_standard_per_jiffy =
+       utime_cpufreq_scale(ref_per_jiffy, ref_freq, freq->new);
+      utime_state.time_standard_per_subjiffy =
+       utime_cpufreq_scale(ref_per_subjiffy, ref_freq, freq->new);
+      calc_utime_quotient();
+      switched = 1;
+    }
+    write_sequnlock_irqrestore(&xtime_lock, flags);
+  }
+  printk("Done\n");
+  return 0;
+}
+
+static struct notifier_block time_cpufreq_notifier_block = {
+        .notifier_call  = time_cpufreq_notifier
+};
+
  /**
   * UTIME init code
   */
@@ -1358,6 +1472,8 @@

         change_timer_mode();
         write_sequnlock_irqrestore(&xtime_lock, flags);
+//     cpufreq_register_notifier(&time_cpufreq_notifier_block,
+//                               CPUFREQ_TRANSITION_NOTIFIER);
         printk(KERN_INFO "UTIME module loaded successfully\n");
         return 0;
  }
Index: drivers/acpi/processor_idle.c
===================================================================
--- drivers/acpi/processor_idle.c       (revision 1334)
+++ drivers/acpi/processor_idle.c       (working copy)
@@ -290,6 +290,7 @@
                 t2 = inl(acpi_fadt.xpm_tmr_blk.address);
                 /* Get end time (ticks) */
                 t2 = inl(acpi_fadt.xpm_tmr_blk.address);
+               sync_time_standard_to_acpi(t2);
                 /* Re-enable interrupts */
                 local_irq_enable();
                 /* Compute time (ticks) that we were actually asleep */
@@ -307,6 +308,7 @@
                 t2 = inl(acpi_fadt.xpm_tmr_blk.address);
                 /* Get end time (ticks) */
                 t2 = inl(acpi_fadt.xpm_tmr_blk.address);
+               sync_time_standard_to_acpi(t2);
                 /* Enable bus master arbitration */
                 acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0, 
ACPI_MTX_DO_NOT_LOCK);
                 /* Re-enable interrupts */


-- 

Anders

