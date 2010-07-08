From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Thu,  8 Jul 2010 12:20:44 +0200
Message-Id: <1278584445-8162-2-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1278584445-8162-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1278584445-8162-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Adeos-main] [PATCH 1/2] ipipe: Pass NTP-corrected time information
	from Linux to higher domains
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: jan.kiszka@domain.hid, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

Introduce a mechanism to pass all information
required to implement CLOCK_HOST_REALTIME for
clock_gettime with NTP corrections as delivered by the
Linux domain to other domains. Essentially, this is an
equivalent of the Linux vsyscall to perform this very action.

We need to ensure that updates of the timing information are
atomic wrt. non-Linux domains with an ipipe spinlock, which
also protects against concurrent writers in the kernel, for
example do_settimeofday().

The timing information is only updated from a single CPU
in the Linux domain. When a reader on another CPU runs in
parallel with an update on CPU 0, an inconsistent state can
arise. This is mended by using a sequence counter to ensure
that the data structure was not modified during the read, which
also allows for lock-less access from userland.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/linux/ipipe_tickdev.h |   23 +++++++++++++++++++++++
 kernel/ipipe/Kconfig          |    7 +++++++
 kernel/ipipe/core.c           |   26 ++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/include/linux/ipipe_tickdev.h b/include/linux/ipipe_tickdev.h
index 4a1cb1b..9683e4f 100644
--- a/include/linux/ipipe_tickdev.h
+++ b/include/linux/ipipe_tickdev.h
@@ -25,6 +25,7 @@
 #if defined(CONFIG_IPIPE) && defined(CONFIG_GENERIC_CLOCKEVENTS)
 
 #include <linux/clockchips.h>
+#include <linux/clocksource.h>
 
 struct tick_device;
 
@@ -44,6 +45,28 @@ struct ipipe_tick_device {
 	int real_shift;
 };
 
+/*
+ * NOTE: When modifying this structure, make sure to keep the Xenomai
+ * definition include/nucleus/vdso.h in sync.
+ */
+struct ipipe_hostrt_data {
+	short live;
+	seqcount_t seqcount;
+	time_t wall_time_sec;
+	u32 wall_time_nsec;
+	struct timespec wall_to_monotonic;
+	cycle_t cycle_last;
+	cycle_t mask;
+	u32 mult;
+	u32 shift;
+};
+
+#ifdef CONFIG_IPIPE_HOSTRT
+void update_ipipe_hostrt(struct timespec *wall_time, struct clocksource *clock);
+#else /* !CONFIG_IPIPE_HOSTRT */
+static inline void update_ipipe_hostrt(struct timespec *wall_time, struct clocksource *clock) {};
+#endif
+
 int ipipe_request_tickdev(const char *devname,
 			  void (*emumode)(enum clock_event_mode mode,
 					  struct clock_event_device *cdev),
diff --git a/kernel/ipipe/Kconfig b/kernel/ipipe/Kconfig
index de5e6a3..bc7a00c 100644
--- a/kernel/ipipe/Kconfig
+++ b/kernel/ipipe/Kconfig
@@ -33,3 +33,10 @@ config IPIPE_UNMASKED_CONTEXT_SWITCH
        bool
        depends on IPIPE
        default n
+
+config HAVE_IPIPE_HOSTRT
+       bool
+
+config IPIPE_HOSTRT
+       def_bool y
+       depends on HAVE_IPIPE_HOSTRT && IPIPE
diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 63deaf9..80209f8 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -48,6 +48,32 @@ static unsigned long __ipipe_domain_slot_map;
 
 struct ipipe_domain ipipe_root;
 
+#ifdef CONFIG_IPIPE_HOSTRT
+/*
+ * NOTE: The architecture specific code must only call this function
+ * when a clocksource suitable for CLOCK_HOST_REALTIME is enabled.
+ */
+void update_ipipe_hostrt(struct timespec *wall_time, struct clocksource *clock)
+{
+	unsigned long flags;
+	struct ipipe_hostrt_data hostrt_data;
+
+	hostrt_data.live = 1;
+	hostrt_data.cycle_last = clock->cycle_last;
+	hostrt_data.mask = clock->mask;
+	hostrt_data.mult = clock->mult;
+	hostrt_data.shift = clock->shift;
+	hostrt_data.wall_time_sec = wall_time->tv_sec;
+	hostrt_data.wall_time_nsec = wall_time->tv_nsec;
+	hostrt_data.wall_to_monotonic = wall_to_monotonic;
+
+	/* Note: The event receiver is responsible for providing
+	   proper locking */
+	if (__ipipe_event_monitored_p(IPIPE_EVENT_HOSTRT))
+		__ipipe_dispatch_event(IPIPE_EVENT_HOSTRT, &hostrt_data);
+};
+#endif /* CONFIG_IPIPE_HOSTRT */
+
 #ifndef CONFIG_SMP
 /*
  * Create an alias to the unique root status, so that arch-dep code
-- 
1.6.4


