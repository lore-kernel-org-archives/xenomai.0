From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Tue, 25 Sep 2012 15:19:18 +0200
Message-Id: <1348579158-5686-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [PATCH] hal: Fix cpu bitmap handling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: wolfgang.mauerer@siemens.com

Don't left-shift further than the bit-width of the
shifted type allows. In this particular constellation,
this leads to selecting CPUs that are not specified in
supported_cpus_arg on systems with more than 32 cores.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 ksrc/arch/generic/hal.c |    2 +-
 ksrc/nucleus/intr.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ksrc/arch/generic/hal.c b/ksrc/arch/generic/hal.c
index ac6c171..f6ac722 100644
--- a/ksrc/arch/generic/hal.c
+++ b/ksrc/arch/generic/hal.c
@@ -539,7 +539,7 @@ int rthal_init(void)
     int cpu;
     cpus_clear(rthal_supported_cpus);
     for (cpu = 0; cpu < BITS_PER_LONG; cpu++)
-	    if (supported_cpus_arg & (1 << cpu))
+	    if (supported_cpus_arg & (1ul << cpu))
 		    cpu_set(cpu, rthal_supported_cpus);
 #endif /* CONFIG_SMP */
 
diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
index 0f37bb2..e77f25e 100644
--- a/ksrc/nucleus/intr.c
+++ b/ksrc/nucleus/intr.c
@@ -1083,7 +1083,7 @@ static int affinity_vfile_show(struct xnvfile_regular_iterator *it,
 
 	for (cpu = 0; cpu < BITS_PER_LONG; cpu++)
 		if (xnarch_cpu_isset(cpu, nkaffinity))
-			val |= (1 << cpu);
+			val |= (1ul << cpu);
 
 	xnvfile_printf(it, "%08lx\n", val);
 
-- 
1.7.1


