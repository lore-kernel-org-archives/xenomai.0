MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OZyTe3w/cI"
Content-Transfer-Encoding: 7bit
Message-ID: <17585.23253.953487.892164@domain.hid>
Date: Sun, 9 Jul 2006 21:36:53 +0200
Subject: Re: [Xenomai-core] nervous nmi-watchdog
In-Reply-To: <1152464821.5027.6.camel@domain.hid>
References: <44736EE4.2060807@domain.hid> <44845D59.5040608@domain.hid>
	<17540.32930.566897.960413@domain.hid>
	<448482B4.2040105@domain.hid>
	<17584.64392.157061.788526@domain.hid>
	<1152463301.5027.3.camel@domain.hid> <44B1354A.50403@domain.hid>
	<1152464821.5027.6.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>


--OZyTe3w/cI
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
 > On Sun, 2006-07-09 at 18:56 +0200, Jan Kiszka wrote:
 > > I can confirm the failing NMI test here on my notebook with both nucleus
 > > and native skin built into the kernel. I haven't seen false positive
 > > NMIs yet, but the tracer is still on. Will switch off and re-check.
 > 
 > FWIW, here, the false positive is raised immediately when starting the
 > latency test.

The attached patch attempt to workaround these early shots, count them,
and display them in /proc/xenomai/nmi_early_shots. Could you try it on
your box and see if the /proc display moves ?

-- 


					    Gilles Chanteperdrix.

--OZyTe3w/cI
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-nmi.diff"
Content-Transfer-Encoding: 7bit

Index: ksrc/arch/i386/nmi.c
===================================================================
--- ksrc/arch/i386/nmi.c	(revision 1316)
+++ ksrc/arch/i386/nmi.c	(working copy)
@@ -61,6 +61,9 @@
         unsigned long perfctr_msr;
         unsigned long long next_linux_check;
         unsigned int p4_cccr_val;
+
+		unsigned early_shots;
+		unsigned long long arm_date;
     };
     char __pad[SMP_CACHE_BYTES];
 } rthal_nmi_wd_t ____cacheline_aligned;
@@ -108,8 +111,13 @@
     rthal_nmi_wd_t *wd = &rthal_nmi_wds[cpu];
     unsigned long long now;
 
-    if (wd->armed)
+	if (wd->armed) {
+		if (rthal_rdtsc() - wd->arm_date < rthal_maxlat_tsc) {
+			++wd->early_shots;
+			wd->next_linux_check = wd->arm_date + rthal_maxlat_tsc;
+		} else
         rthal_nmi_emergency(regs);
+	}
 
     now = rthal_rdtsc();
 
@@ -142,6 +150,27 @@
     wrmsrl(wd->perfctr_msr, now - wd->next_linux_check);
 }
 
+static int earlyshots_read_proc(char *page,
+				char **start,
+				off_t off, int count, int *eof, void *data)
+{
+	int i, len = 0;
+
+	for_each_online_cpu(i)
+		len += sprintf(page + len, "CPU#%d: %u\n",
+			       i, rthal_nmi_wds[i].early_shots);
+	len -= off;
+	if (len <= off + count)
+		*eof = 1;
+	*start = page + off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+
+	return len;
+}
+
 int rthal_nmi_request(void (*emergency) (struct pt_regs *))
 {
     if (!nmi_active || !nmi_watchdog_tick)
@@ -180,6 +209,11 @@
     rthal_linux_nmi_tick = nmi_watchdog_tick;
     wmb();
     nmi_watchdog_tick = &rthal_nmi_watchdog_tick;
+
+	__rthal_add_proc_leaf("nmi_early_shots",
+			      &earlyshots_read_proc,
+			      NULL, NULL, rthal_proc_root);
+
     return 0;
 }
 
@@ -188,6 +222,8 @@
     if (!rthal_linux_nmi_tick)
         return;
 
+	remove_proc_entry("nmi_early_shots", rthal_proc_root);
+
     wrmsrl(rthal_nmi_perfctr_msr, 0 - RTHAL_CPU_FREQ);
     touch_nmi_watchdog();
     wmb();
@@ -215,6 +251,7 @@
         rthal_local_irq_restore(flags);
     }
 
+	wd->arm_date = rthal_rdtsc();
     wrmsrl(wd->perfctr_msr, 0 - delay);
     wmb();
     wd->armed = 1;

--OZyTe3w/cI--

