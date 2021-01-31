From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 11/13] cobalt/machine: ipipe: drop timer frequency setting
Date: Sun, 31 Jan 2021 15:45:38 +0100
Message-Id: <20210131144540.243363-11-rpm@xenomai.org>
In-Reply-To: <20210131144540.243363-1-rpm@xenomai.org>
References: <20210131144540.243363-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

The only user of the timer frequency setting was the machine-specific
timer calibration handler, which is now gone. Therefore we don't need
to know the timer frequency anymore. As a consequence, we don't care
about overriding its value as determined by the I-pipe either.

Let's drop all of these antiquated bits.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 doc/asciidoc/MIGRATION.adoc                    | 1 -
 doc/asciidoc/README.INSTALL.adoc               | 7 -------
 include/cobalt/kernel/ipipe/pipeline/machine.h | 1 -
 kernel/cobalt/ipipe/init.c                     | 7 -------
 4 files changed, 16 deletions(-)

diff --git a/doc/asciidoc/MIGRATION.adoc b/doc/asciidoc/MIGRATION.adoc
index cf1346415..ced356548 100644
--- a/doc/asciidoc/MIGRATION.adoc
+++ b/doc/asciidoc/MIGRATION.adoc
@@ -76,7 +76,6 @@ System parameters renamed::
 * xeno_hal.supported_cpus -> xenomai.supported_cpus
 * xeno_hal.clockfreq -> xenomai.clockfreq
 * xeno_hal.disable -> xenomai.state=disabled
-* xeno_hal.timerfreq -> xenomai.timerfreq
 * xeno_hal.cpufreq -> xenomai.cpufreq
 * xeno_nucleus.watchdog_timeout -> xenomai.watchdog_timeout
 * xeno_nucleus.xenomai_gid -> xenomai.allowed_group
diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
index cbd2adcd5..fc3f52964 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -154,13 +154,6 @@ when initializing. It is strongly recommended *not* to use this option
 unless you really know what you are doing. This value is expressed in
 HZ. | 0 (=calibrated)
 
-|xenomai.timerfreq=<hz-freq> | Override the real-time timer frequency
-used in programming timer shots with the given value. The most
-accurate value is normally determined by the Cobalt core automatically
-when initializing. It is strongly recommended *not* to use this option
-unless you really know what you are doing. This value is expressed in
-HZ. | 0 (=calibrated)
-
 |xenomai.smi=<state> | *x86-specific*: Set the state of the SMI
 workaround. The possible values are _disabled_, _detect_ and
 _enabled_. See the discussion about link:dealing-with-x86-SMI[SMIs]
diff --git a/include/cobalt/kernel/ipipe/pipeline/machine.h b/include/cobalt/kernel/ipipe/pipeline/machine.h
index a5a5197e9..062722a02 100644
--- a/include/cobalt/kernel/ipipe/pipeline/machine.h
+++ b/include/cobalt/kernel/ipipe/pipeline/machine.h
@@ -37,7 +37,6 @@ DECLARE_PER_CPU(struct cobalt_machine_cpudata, cobalt_machine_cpudata);
 
 struct cobalt_pipeline {
 	struct ipipe_domain domain;
-	unsigned long timer_freq;
 	unsigned long clock_freq;
 	unsigned int escalate_virq;
 #ifdef CONFIG_SMP
diff --git a/kernel/cobalt/ipipe/init.c b/kernel/cobalt/ipipe/init.c
index 1dde7bc4b..2533d99ba 100644
--- a/kernel/cobalt/ipipe/init.c
+++ b/kernel/cobalt/ipipe/init.c
@@ -11,9 +11,6 @@
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/clock.h>
 
-static unsigned long timerfreq_arg;
-module_param_named(timerfreq, timerfreq_arg, ulong, 0444);
-
 static unsigned long clockfreq_arg;
 module_param_named(clockfreq, clockfreq_arg, ulong, 0444);
 
@@ -28,9 +25,6 @@ int __init pipeline_init(void)
 
 	ipipe_get_sysinfo(&sysinfo);
 
-	if (timerfreq_arg == 0)
-		timerfreq_arg = sysinfo.sys_hrtimer_freq;
-
 	if (clockfreq_arg == 0)
 		clockfreq_arg = sysinfo.sys_hrclock_freq;
 
@@ -39,7 +33,6 @@ int __init pipeline_init(void)
 		return -ENODEV;
 	}
 
-	cobalt_pipeline.timer_freq = timerfreq_arg;
 	cobalt_pipeline.clock_freq = clockfreq_arg;
 
 	if (cobalt_machine.init) {
-- 
2.26.2


