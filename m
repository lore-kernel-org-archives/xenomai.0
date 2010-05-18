Message-ID: <4BF251EC.7040605@domain.hid>
Date: Tue, 18 May 2010 10:38:04 +0200
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>
	<181804936ABC2349BE503168465576460EBD6239@domain.hid>
	<4BF17464.5090100@domain.hid>
	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460EBD62C8@domain.hid>
Content-Type: multipart/mixed; boundary="------------060306020608070903070302"
Subject: Re: [Xenomai-help] Question about getting system time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------060306020608070903070302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Steve Deiters wrote:
>> Periodically setting the time is risky if timed jobs depend 
>> on Xenomai's real-time clock - it may jump in all directions...
>>
>>> Any other suggestions for providing timestamps to real time 
>> tasks in 
>>> this case?
>> Do you just need precise timestamps from with real-time 
>> tasks, or do you have to synchronize timer events of the 
>> Xenomai core on an external clock?
>>
>> For the former case (precisely our scenario), we laid the 
>> ground to extend Xenomai 2.5 with RT-safe syscalls to obtain 
>> Linux's view on gettimeofday. It "just" needs some polishing 
>> to post this for upstream.
>> Wolfgang (CC'ed) is working on this.
> 
> I'm just looking to get timestamps in the real time task.  At least in
> my case being able to call gettimeofday from the real time thread would
> be exactly what I need.

then you might want to try the attached patches for Ipipe and
Xenomai. For upstream submission, they still need a bit of
cleaning up as Jan mentioned, and I'll also prepare a proper
series then. Testing is very welcome, however.

Best, Wolfgang

--------------060306020608070903070302
Content-Type: text/x-patch;
 name="01-generic-gtod-base.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-generic-gtod-base.diff"

Pass generic time-of-day information from Linux to higher domains

From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

Introduce a mechanism to pass all information
required to implement a gettimeofday() call with
NTP corrections as delivered by the Linux domain
to other domains. Essentially, this is an equivalent
of the Linux vsyscall to perform this very action.

We need to ensure that updates of the timing information are
atomic wrt. non-Linux domains. While a simple solution would be to place
an appropriate lock around the updates, this would eliminate
the speed advantages of the kernel's seqlock. Therefore,
we implement a transactional mechanism using two copies of the
timing information that does not interfere with the updates
of the kernel itself.

The timing information is only updated from a single CPU
in the Linux domain, and updates preempted by Xenomai are
protected by the transactional mechanism. However, when a
reader on another CPU runs in parallel with an update on
CPU 0, an inconsistent state can arise. This is mended by
using a sequence counter to ensure that the data structure
was not modified during the read.

Note that since updating the structure takes a constant amount
of time that is much smaller than the interval between updates,
the number of iterations in the retry loop (in case of
modifications during the read) is bounded:

TODO: Explain why this is the case
---
 include/linux/clocksource.h   |    8 ++++++++
 include/linux/ipipe_tickdev.h |   20 ++++++++++++++++++++
 kernel/ipipe/core.c           |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 64b1a4c..5ac07a7 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -281,12 +281,20 @@ extern void clocksource_resume(void);
 extern struct clocksource * __init __weak clocksource_default_clock(void);
 extern void clocksource_mark_unstable(struct clocksource *cs);
 
+/* Including ipipe_tickdev.h that declares update_ipipe_gtod()
+   would lead to a cycle, so we declare update_ipipe_gtod() here */
+void update_ipipe_gtod(struct timespec *ts, struct clocksource *c);
+
 #ifdef CONFIG_GENERIC_TIME_VSYSCALL
 extern void update_vsyscall(struct timespec *ts, struct clocksource *c);
 extern void update_vsyscall_tz(void);
 #else
+
 static inline void update_vsyscall(struct timespec *ts, struct clocksource *c)
 {
+#ifdef CONFIG_IPIPE
+	update_ipipe_gtod(ts, c);
+#endif
 }
 
 static inline void update_vsyscall_tz(void)
diff --git a/include/linux/ipipe_tickdev.h b/include/linux/ipipe_tickdev.h
index 4a1cb1b..68d9100 100644
--- a/include/linux/ipipe_tickdev.h
+++ b/include/linux/ipipe_tickdev.h
@@ -25,6 +25,7 @@
 #if defined(CONFIG_IPIPE) && defined(CONFIG_GENERIC_CLOCKEVENTS)
 
 #include <linux/clockchips.h>
+#include <linux/clocksource.h>
 
 struct tick_device;
 
@@ -44,6 +45,25 @@ struct ipipe_tick_device {
 	int real_shift;
 };
 
+struct ipipe_gtod_data {
+	seqcount_t lock;
+	cycle_t (*vread)(void);
+	time_t wall_time_sec;
+	u32 wall_time_nsec;
+	struct timespec wall_to_monotonic;
+	cycle_t cycle_last;
+	cycle_t mask;
+	u32 mult;
+	u32 shift;
+};
+
+struct gtod_data_exchange {
+	int gtod_active;
+	struct ipipe_gtod_data gtod_data[2];
+};
+
+void ipipe_set_gtod_data_exchange(struct gtod_data_exchange *exchg);
+
 int ipipe_request_tickdev(const char *devname,
 			  void (*emumode)(enum clock_event_mode mode,
 					  struct clock_event_device *cdev),
diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 63deaf9..53d9654 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -48,6 +48,12 @@ static unsigned long __ipipe_domain_slot_map;
 
 struct ipipe_domain ipipe_root;
 
+static struct gtod_data_exchange *gtod_data_exchange = NULL;
+
+void ipipe_set_gtod_data_exchange(struct gtod_data_exchange *exchg) {
+	gtod_data_exchange = exchg;
+}
+
 #ifndef CONFIG_SMP
 /*
  * Create an alias to the unique root status, so that arch-dep code
@@ -203,6 +209,36 @@ void ipipe_release_tickdev(int cpu)
 	ipipe_critical_exit(flags);
 }
 
+#define UPDATE_GTOD_DATA(base)				\
+	base.vread = clock->vread;			\
+	base.cycle_last = clock->cycle_last;		\
+	base.mask = clock->mask;			\
+	base.mult = clock->mult;			\
+	base.shift = clock->shift;			\
+	base.wall_time_sec = wall_time->tv_sec;		\
+	base.wall_time_nsec = wall_time->tv_nsec;	\
+	base.wall_to_monotonic = wall_to_monotonic;
+
+void update_ipipe_gtod(struct timespec *wall_time, struct clocksource *clock)
+{
+	if (!gtod_data_exchange)
+		return;
+
+	/* Activate second instance, update first */
+	gtod_data_exchange->gtod_active = 1;
+
+	write_seqcount_begin(&gtod_data_exchange->gtod_data[0].lock);
+	UPDATE_GTOD_DATA(gtod_data_exchange->gtod_data[0]);
+	write_seqcount_end(&gtod_data_exchange->gtod_data[0].lock);
+
+	/* Activate first instance, update second */
+	gtod_data_exchange->gtod_active = 0;
+
+	write_seqcount_begin(&gtod_data_exchange->gtod_data[1].lock);
+	UPDATE_GTOD_DATA(gtod_data_exchange->gtod_data[1]);
+	write_seqcount_end(&gtod_data_exchange->gtod_data[1].lock);
+};
+
 #endif /* CONFIG_GENERIC_CLOCKEVENTS */
 
 void __init ipipe_init_early(void)

--------------060306020608070903070302
Content-Type: text/x-patch;
 name="02-x86-gtod-part.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-x86-gtod-part.diff"

ipipe-gtod: x86-specific part

From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

x86 specific mechanism to make gtod information available
to non-Linux domains.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
---
 arch/x86/kernel/vsyscall_64.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/vsyscall_64.c b/arch/x86/kernel/vsyscall_64.c
index 8cb4974..565a5ba 100644
--- a/arch/x86/kernel/vsyscall_64.c
+++ b/arch/x86/kernel/vsyscall_64.c
@@ -32,6 +32,7 @@
 #include <linux/cpu.h>
 #include <linux/smp.h>
 #include <linux/notifier.h>
+#include <linux/ipipe_tickdev.h>
 
 #include <asm/vsyscall.h>
 #include <asm/pgtable.h>
@@ -89,6 +90,10 @@ void update_vsyscall(struct timespec *wall_time, struct clocksource *clock)
 	vsyscall_gtod_data.wall_to_monotonic = wall_to_monotonic;
 	vsyscall_gtod_data.wall_time_coarse = __current_kernel_time();
 	write_sequnlock_irqrestore(&vsyscall_gtod_data.lock, flags);
+
+#ifdef CONFIG_IPIPE
+	update_ipipe_gtod(wall_time, clock);
+#endif
 }
 
 /* RED-PEN may want to readd seq locking, but then the variable should be

--------------060306020608070903070302
Content-Type: text/plain;
 name="series-ipipe"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="series-ipipe"

# This series applies on GIT commit 2b9142396e28b8c3d0e6e7d758924f5f5ce81045
01-generic-gtod-base.diff
02-x86-gtod-part.diff

--------------060306020608070903070302
Content-Type: text/x-patch;
 name="01-add-gtod-bits-to-nkvdso.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-add-gtod-bits-to-nkvdso.diff"

Add gtod bits to nkvdso

From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>


---
 include/nucleus/vdso.h |   53 +++++++++++++++++++++++++++++++++++++++++++++---
 ksrc/nucleus/shadow.c  |    8 +++++++
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/include/nucleus/vdso.h b/include/nucleus/vdso.h
index c431f88..ab67a3f 100644
--- a/include/nucleus/vdso.h
+++ b/include/nucleus/vdso.h
@@ -23,7 +23,42 @@
  * 02111-1307, USA.
  */
 
+#ifdef __KERNEL__
+#include <linux/time.h>
+#include <linux/seqlock.h>
+#include <linux/ipipe_tickdev.h>
+#define testbits(flags,mask) ((flags) & (mask))
+#else /* !__KERNEL__ */
+#include <time.h>
+#include <sys/types.h>
+#include <nucleus/seqlock_user.h>
 #include <nucleus/types.h>
+typedef u_int32_t u32;
+typedef u_int64_t cycle_t;
+
+/*
+ * ipipe_gtod_data and gtod_data_exchange must be kept in sync with
+ * the corresponding definitions in the ipipe: ipipe_tickdev.h
+ * We cannot include the file here because the definitios are also
+ * required in xenomai userland.
+ */
+struct ipipe_gtod_data {
+	seqcount_t lock;
+	cycle_t (*vread)(void);
+	time_t wall_time_sec;
+	u32 wall_time_nsec;
+	struct timespec wall_to_monotonic;
+	cycle_t cycle_last;
+	cycle_t mask;
+	u32 mult;
+	u32 shift;
+};
+
+struct gtod_data_exchange {
+	int gtod_active;
+	struct ipipe_gtod_data gtod_data[2];
+};
+#endif /* __KERNEL__ */
 
 /*
  * Data shared between Xenomai kernel/userland and the Linux kernel/userland
@@ -33,8 +68,11 @@
 struct xnvdso {
 	unsigned long long features;
 
-	/* Embed domain specific structures that describe the
-	 * shared data here */
+	struct gtod_data_exchange gtod_data_exchange;
+	/*
+	 * Embed further domain specific structures that
+	 * describe the shared data here
+	 */
 };
 
 /*
@@ -48,7 +86,8 @@ struct xnvdso {
 #define XNVDSO_FEATURES	(XNVDSO_FEAT_A | XNVDSO_FEAT_B | XVDSO_FEAT_C)
 */
 #define XNVDSO_FEAT_DROP_U_MODE 0x0000000000000001ULL
-#define XNVDSO_FEATURES (XNVDSO_FEAT_DROP_U_MODE)
+#define XNVDSO_FEAT_GTOD	0x0000000000000002ULL
+#define XNVDSO_FEATURES (XNVDSO_FEAT_DROP_U_MODE | XNVDSO_FEAT_GTOD)
 
 extern struct xnvdso *nkvdso;
 
@@ -57,5 +96,13 @@ static inline int xnvdso_test_feature(unsigned long long feature)
 	return testbits(nkvdso->features, feature);
 }
 
+static inline struct ipipe_gtod_data *get_gtod_data(void)
+{
+	// TODO: Is this safe, especially because of the array index operation?
+	struct gtod_data_exchange *exchg = &nkvdso->gtod_data_exchange;
+
+	return &exchg->gtod_data[exchg->gtod_active];
+}
+
 extern void xnheap_init_vdso(void);
 #endif /* _XENO_NUCLEUS_VDSO_H */
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 872c37f..7db740d 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -713,6 +713,14 @@ void __init xnheap_init_vdso(void)
 		xnpod_fatal("Xenomai: cannot allocate memory for xnvdso!\n");
 
 	nkvdso->features = XNVDSO_FEATURES;
+
+	nkvdso->gtod_data_exchange.gtod_active = 0;
+	seqcount_init(&nkvdso->gtod_data_exchange.gtod_data[0].lock);
+	nkvdso->gtod_data_exchange.gtod_data[0].vread = NULL;
+	seqcount_init(&nkvdso->gtod_data_exchange.gtod_data[1].lock);
+	nkvdso->gtod_data_exchange.gtod_data[1].vread = NULL;
+
+	ipipe_set_gtod_data_exchange(&nkvdso->gtod_data_exchange);
 }
 
 static inline void handle_rt_signals(xnthread_t *thread,

--------------060306020608070903070302
Content-Type: text/x-patch;
 name="02-support-gettimeofday-in-realti.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-support-gettimeofday-in-realti.diff"

Support gettimeofday in realtime context

From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

Wall time management is typically assisted by the NTP
protocol in the Linux context, but this information is
not propagated to Xenomai. This patch adds support
for gettimeofday(2) in primary mode by transactionally
copying the required information from the Kernel into
Xenomai. On the reader-side part, a seqlock is used
to ensure correctness of the mechanism when readers
on CPU n compete with a writer on CPU m != n

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/posix/syscall.h        |    1 
 include/posix/time.h           |    4 ++
 ksrc/skins/posix/clock.c       |   84 ++++++++++++++++++++++++++++++++++++++++
 ksrc/skins/posix/syscall.c     |   18 +++++++++
 src/skins/posix/clock.c        |   15 +++++++
 src/skins/posix/posix.wrappers |    1 
 6 files changed, 123 insertions(+), 0 deletions(-)

diff --git a/include/posix/syscall.h b/include/posix/syscall.h
index 04a528d..b8d4f38 100644
--- a/include/posix/syscall.h
+++ b/include/posix/syscall.h
@@ -104,6 +104,7 @@
 #define __pse51_select                77
 #define __pse51_thread_setschedparam_ex	78
 #define __pse51_thread_getschedparam_ex	79
+#define __pse51_gettimeofday          80
 
 #ifdef __KERNEL__
 
diff --git a/include/posix/time.h b/include/posix/time.h
index 4f2d760..d1fe28d 100644
--- a/include/posix/time.h
+++ b/include/posix/time.h
@@ -74,6 +74,8 @@ int clock_nanosleep(clockid_t clock_id,
                     const struct timespec *rqtp,
 		    struct timespec *rmtp);
 
+int gettimeofday(struct timeval *tp, void *tzp);
+
 int nanosleep(const struct timespec *rqtp,
               struct timespec *rmtp);
 
@@ -111,6 +113,8 @@ int __real_clock_gettime(clockid_t clock_id,
 int __real_clock_settime(clockid_t clock_id,
 			 const struct timespec *tp);
 
+int __real_gettimeofday(struct timeval *tv, void *tzp);
+
 int __real_clock_nanosleep(clockid_t clock_id,
 			   int flags,
 			   const struct timespec *rqtp,
diff --git a/ksrc/skins/posix/clock.c b/ksrc/skins/posix/clock.c
index 553e123..fcf3e4d 100644
--- a/ksrc/skins/posix/clock.c
+++ b/ksrc/skins/posix/clock.c
@@ -50,6 +50,9 @@
  *@{*/
 
 #include <posix/thread.h>
+#include <linux/ipipe_tickdev.h>
+#include <linux/math64.h>
+#include <nucleus/vdso.h>
 
 /**
  * Get the resolution of the specified clock.
@@ -88,6 +91,86 @@ int clock_getres(clockid_t clock_id, struct timespec *res)
 }
 
 /**
+ * Read the clock.
+ *
+ * Obtain the current time with NTP corrections from the Linux domain
+ *
+ * @param tv pointer to a struct timeval
+ * @param tzp Timezone (ignored)
+ *
+ * @retval 0 on success; note however that if no suitable NTP-corrected
+ *         clocksource is available, the call still succeeds, but returns
+ *         the time obtained by clock_gettime() _without_ NTP corrections.
+ *
+ * @see
+ * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/gettimeofday.html">
+ * Specification.</a>
+ *
+ */
+
+int gettimeofday(struct timeval *tv, void *tzp)
+{
+	cycle_t now, base, mask, cycle_delta;
+	unsigned long mult, shift, nsec, rem;
+	struct timespec tp;
+	struct ipipe_gtod_data *gtod_data;
+	unsigned int seq;
+
+retry:
+	gtod_data = get_gtod_data();
+
+	/* Note: gtod_data must not be protected by a lock because Linux
+	   cannot preempt us and gtod_data is guaranteed to point to a
+	   consistent data structure from the ipipe layer when the reader has
+	   interrupted the writer on the same CPU.
+
+	   The sequence counter is required when a reader is interleaved by a
+	   writer on a different CPU. It allows us to detect that the data
+	   have changed while reading them, and we switch to the alternative
+	   data element in this case (get_gtod_data() will automatically
+	   return it). When the time required to read the data is much smaller
+	   than the intervals between the updates (and no real-time
+	   process with higher priority preempts us), we loop at most thrice
+	   before we obtain a consistent data set. */
+	if (unlikely(!gtod_data) || unlikely(!gtod_data->vread)) {
+		printk(KERN_INFO "No gtod data provided, "
+		       "using non-rt gettimeofday");
+		clock_gettime(CLOCK_MONOTONIC, &tp);
+		tv->tv_sec = tp.tv_sec;
+		tv->tv_usec = tp.tv_nsec/1000;
+		return 0;
+	}
+
+	seq = read_seqcount_begin(&gtod_data->lock);
+
+	now = gtod_data->vread();
+	base = gtod_data->cycle_last;
+	mask = gtod_data->mask;
+	mult = gtod_data->mult;
+	shift = gtod_data->shift;
+	tv->tv_sec = gtod_data->wall_time_sec;
+	nsec = gtod_data->wall_time_nsec;
+
+	/* If the data changed during the read, try the
+	   alternative data element */
+	if (read_seqcount_retry(&gtod_data->lock, seq))
+		goto retry;
+
+	/* At this point, we have a consistent copy of the fundamental
+	 * data structure - calculate the interval between the current
+	 * and base time stamp cycles, and convert the difference
+	 * to nanoseconds. */
+	cycle_delta = (now - base) & mask;
+	nsec += (cycle_delta * mult) >> shift;
+
+	/* Convert to the desired sec, usec representation */
+	tv->tv_sec +=  xnarch_divrem_billion(nsec, &rem);
+	tv->tv_usec = rem / NSEC_PER_USEC;
+
+	return 0;
+}
+
+/**
  * Read the specified clock. 
  *
  * This service returns, at the address @a tp the current value of the clock @a
@@ -322,4 +405,5 @@ EXPORT_SYMBOL(clock_getres);
 EXPORT_SYMBOL(clock_gettime);
 EXPORT_SYMBOL(clock_settime);
 EXPORT_SYMBOL(clock_nanosleep);
+EXPORT_SYMBOL(gettimeofday);
 EXPORT_SYMBOL(nanosleep);
diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
index 2a97a2d..e403d12 100644
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -765,6 +765,23 @@ static int __clock_gettime(struct pt_regs *regs)
 	return err ? -thread_get_errno() : 0;
 }
 
+static int __gettimeofday(struct pt_regs *regs)
+{
+	struct timeval tv;
+	int err;
+
+	/* POSIX leaves the behaviour of gettimeofday unspecified
+	   when tzp != NULL, so we adjust it to this value for
+	   simplicity's sake */
+	err = gettimeofday(&tv, NULL);
+
+	if (!err && __xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs),
+					   &tv, sizeof(tv)))
+		return -EFAULT;
+
+	return err ? -thread_get_errno() : 0;
+}
+
 static int __clock_settime(struct pt_regs *regs)
 {
 	struct timespec ts;
@@ -2775,6 +2792,7 @@ static xnsysent_t __systab[] = {
 	[__pse51_sem_open] = {&__sem_open, __xn_exec_any},
 	[__pse51_sem_close] = {&__sem_close, __xn_exec_any},
 	[__pse51_sem_unlink] = {&__sem_unlink, __xn_exec_any},
+	[__pse51_gettimeofday] = {&__gettimeofday, __xn_exec_any},
 	[__pse51_clock_getres] = {&__clock_getres, __xn_exec_any},
 	[__pse51_clock_gettime] = {&__clock_gettime, __xn_exec_any},
 	[__pse51_clock_settime] = {&__clock_settime, __xn_exec_any},
diff --git a/src/skins/posix/clock.c b/src/skins/posix/clock.c
index e27a2ec..4c31114 100644
--- a/src/skins/posix/clock.c
+++ b/src/skins/posix/clock.c
@@ -56,6 +56,21 @@ int __wrap_clock_getres(clockid_t clock_id, struct timespec *tp)
 	return -1;
 }
 
+int __wrap_gettimeofday(struct timeval *tv, void *tzp)
+{
+	int err;
+
+	err = -XENOMAI_SKINCALL2(__pse51_muxid,
+				 __pse51_gettimeofday,
+				 tv, tzp);
+
+	if (!err)
+		return 0;
+
+	errno = err;
+	return -1;
+}
+
 int __wrap_clock_gettime(clockid_t clock_id, struct timespec *tp)
 {
 	int err;
diff --git a/src/skins/posix/posix.wrappers b/src/skins/posix/posix.wrappers
index 776c5d5..b8927b5 100644
--- a/src/skins/posix/posix.wrappers
+++ b/src/skins/posix/posix.wrappers
@@ -18,6 +18,7 @@
 --wrap clock_gettime
 --wrap clock_settime
 --wrap clock_nanosleep
+--wrap gettimeofday
 --wrap nanosleep
 --wrap pthread_mutexattr_init
 --wrap pthread_mutexattr_destroy

--------------060306020608070903070302
Content-Type: text/x-patch;
 name="03-userspace-gtod-reading-without.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03-userspace-gtod-reading-without.diff"

Userspace gtod reading without switching to kernel mode

From: Wolfgang Mauerer (none) <wolfgang@domain.hid>

We can do this since the data are on the shared semaphore heap.
The basis data structure is placed so that it is accessible from
both the Linux kernel and Xenomai kernel/userland. This also
requires to make the structure work with both kernel and userland
definitions for elementary data types.

Although we could read the TSC directly using __xn_rdtsc(), we
use the vread function also employed by the kernel to make the
code in both worlds aligned as good as possible.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/nucleus/seqlock_user.h |   77 ++++++++++++++++++++++++++++++++++++++++
 src/skins/posix/clock.c        |   47 ++++++++++++++++++++++++
 src/skins/posix/seqlock.h      |   77 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+), 0 deletions(-)
 create mode 100644 include/nucleus/seqlock_user.h
 create mode 100644 src/skins/posix/seqlock.h

diff --git a/include/nucleus/seqlock_user.h b/include/nucleus/seqlock_user.h
new file mode 100644
index 0000000..35ed045
--- /dev/null
+++ b/include/nucleus/seqlock_user.h
@@ -0,0 +1,77 @@
+#ifndef __SEQLOCK_USER_H
+#define __SEQLOCK_USER_H
+
+/* Stolen from the linux kernel and slightly adapted for userland */
+
+// TODO: This is just the version for x86, other CPUs require
+// different definitions. Though it would make sense to remove
+// the cpu_relax() in the waiting path at all.
+static inline void rep_nop(void)
+{
+	asm volatile("rep; nop" ::: "memory");
+}
+
+static inline void cpu_relax(void)
+{
+	rep_nop();
+}
+
+
+// This definitely needs some work. It only works for the SMP and x86 case.
+#define barrier() __asm__ __volatile__("": : :"memory")
+
+#define smp_rmb()	barrier()
+#define smp_wmb()	barrier()
+
+//#define unlikely(x)    __builtin_expect(!!(x), 0)
+
+typedef struct seqcount {
+	unsigned sequence;
+} seqcount_t;
+
+#define SEQCNT_ZERO { 0 }
+#define seqcount_init(x)	do { *(x) = (seqcount_t) SEQCNT_ZERO; } while (0)
+
+/* Start of read using pointer to a sequence counter only.  */
+static inline unsigned read_seqcount_begin(const seqcount_t *s)
+{
+	unsigned ret;
+
+repeat:
+	ret = s->sequence;
+	smp_rmb();
+	if (unlikely(ret & 1)) {
+		cpu_relax();
+		goto repeat;
+	}
+	return ret;
+}
+
+/*
+ * Test if reader processed invalid data because sequence number has changed.
+ */
+static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
+{
+	smp_rmb();
+
+	return s->sequence != start;
+}
+
+
+/*
+ * Sequence counter only version assumes that callers are using their
+ * own mutexing.
+ */
+static inline void write_seqcount_begin(seqcount_t *s)
+{
+	s->sequence++;
+	smp_wmb();
+}
+
+static inline void write_seqcount_end(seqcount_t *s)
+{
+	smp_wmb();
+	s->sequence++;
+}
+
+#endif
diff --git a/src/skins/posix/clock.c b/src/skins/posix/clock.c
index 4c31114..ba1bc20 100644
--- a/src/skins/posix/clock.c
+++ b/src/skins/posix/clock.c
@@ -25,6 +25,9 @@
 #include <time.h>
 #include <asm/xenomai/arith.h>
 #include <asm-generic/xenomai/timeconv.h>
+#include <nucleus/seqlock_user.h>
+#include <sys/types.h>
+#include <nucleus/vdso.h>
 
 extern int __pse51_muxid;
 
@@ -59,6 +62,50 @@ int __wrap_clock_getres(clockid_t clock_id, struct timespec *tp)
 int __wrap_gettimeofday(struct timeval *tv, void *tzp)
 {
 	int err;
+#ifdef XNARCH_HAVE_NONPRIV_TSC
+	unsigned int seq;
+	cycle_t now, base, mask, cycle_delta;
+	unsigned long mult, shift, nsec, rem;
+
+        struct gtod_data_exchange *exchg = &nkvdso->gtod_data_exchange;
+	struct ipipe_gtod_data *gtod_data;
+
+retry:
+        gtod_data = &exchg->gtod_data[exchg->gtod_active];
+	if(unlikely(!gtod_data->vread))
+		goto fallback;
+
+	/*
+	 * The following is essentially a verbatim copy of the
+	 * mechanism in the kernel
+	 */
+	seq = read_seqcount_begin(&gtod_data->lock);
+
+	now = gtod_data->vread();
+	base = gtod_data->cycle_last;
+	mask = gtod_data->mask;
+	mult = gtod_data->mult;
+	shift = gtod_data->shift;
+	tv->tv_sec = gtod_data->wall_time_sec;
+	nsec = gtod_data->wall_time_nsec;
+
+	/* If the data changed during the read, try the
+	   alternative data element */
+	if (read_seqcount_retry(&gtod_data->lock, seq))
+		goto retry;
+
+	cycle_delta = (now - base) & mask;
+	nsec += (cycle_delta * mult) >> shift;
+
+#define NSEC_PER_USEC	1000L
+#define NSEC_PER_SEC	1000000000L
+	tv->tv_sec += xnarch_divrem_billion(nsec, &rem);
+	tv->tv_usec = rem / NSEC_PER_USEC;
+
+	return 0;
+
+fallback:
+#endif /* XNARCH_HAVE_NONPRIV_TSC */
 
 	err = -XENOMAI_SKINCALL2(__pse51_muxid,
 				 __pse51_gettimeofday,
diff --git a/src/skins/posix/seqlock.h b/src/skins/posix/seqlock.h
new file mode 100644
index 0000000..9929247
--- /dev/null
+++ b/src/skins/posix/seqlock.h
@@ -0,0 +1,77 @@
+#ifndef __SEQLOCK_H
+#define __SEQLOCK_H
+
+/* Stolen from the linux kernel and slightly adapted for userland */
+
+// TODO: This is just the version for x86, other CPUs require
+// different definitions. Though it would make sense to remove
+// the cpu_relax() in the waiting path at all.
+static inline void rep_nop(void)
+{
+	asm volatile("rep; nop" ::: "memory");
+}
+
+static inline void cpu_relax(void)
+{
+	rep_nop();
+}
+
+
+// This definitely needs some work. It only works for the SMP and x86 case.
+#define barrier() __asm__ __volatile__("": : :"memory")
+
+#define smp_rmb()	barrier()
+#define smp_wmb()	barrier()
+
+//#define unlikely(x)    __builtin_expect(!!(x), 0)
+
+typedef struct seqcount {
+	unsigned sequence;
+} seqcount_t;
+
+#define SEQCNT_ZERO { 0 }
+#define seqcount_init(x)	do { *(x) = (seqcount_t) SEQCNT_ZERO; } while (0)
+
+/* Start of read using pointer to a sequence counter only.  */
+static inline unsigned read_seqcount_begin(const seqcount_t *s)
+{
+	unsigned ret;
+
+repeat:
+	ret = s->sequence;
+	smp_rmb();
+	if (unlikely(ret & 1)) {
+		cpu_relax();
+		goto repeat;
+	}
+	return ret;
+}
+
+/*
+ * Test if reader processed invalid data because sequence number has changed.
+ */
+static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
+{
+	smp_rmb();
+
+	return s->sequence != start;
+}
+
+
+/*
+ * Sequence counter only version assumes that callers are using their
+ * own mutexing.
+ */
+static inline void write_seqcount_begin(seqcount_t *s)
+{
+	s->sequence++;
+	smp_wmb();
+}
+
+static inline void write_seqcount_end(seqcount_t *s)
+{
+	smp_wmb();
+	s->sequence++;
+}
+
+#endif

--------------060306020608070903070302
Content-Type: text/plain;
 name="series-xenomai"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="series-xenomai"

# This series applies on GIT commit 811b7af4ddb08f39ea12f4c98e56eee690e77769
01-add-gtod-bits-to-nkvdso.diff
02-support-gettimeofday-in-realti.diff
03-userspace-gtod-reading-without.diff

--------------060306020608070903070302--

