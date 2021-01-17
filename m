From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail v2 4/5] cobalt/machine: drop obsolete APC bits
Date: Sun, 17 Jan 2021 16:08:02 +0100
Message-Id: <20210117150803.477767-5-rpm@xenomai.org>
In-Reply-To: <20210117150803.477767-1-rpm@xenomai.org>
References: <20210117150803.477767-1-rpm@xenomai.org>
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

APCs are gone, drop the related machine-specific data.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/ipipe/pipeline/machine.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/cobalt/kernel/ipipe/pipeline/machine.h b/include/cobalt/kernel/ipipe/pipeline/machine.h
index 4a434bc4d..c7d2d68b4 100644
--- a/include/cobalt/kernel/ipipe/pipeline/machine.h
+++ b/include/cobalt/kernel/ipipe/pipeline/machine.h
@@ -31,8 +31,6 @@ struct cobalt_machine {
 extern struct cobalt_machine cobalt_machine;
 
 struct cobalt_machine_cpudata {
-	unsigned long apc_pending;
-	unsigned long apc_shots[BITS_PER_LONG];
 	unsigned int faults[IPIPE_NR_FAULTS];
 };
 
@@ -45,11 +43,6 @@ struct cobalt_pipeline {
 	unsigned int apc_virq;
 	unsigned long apc_map;
 	unsigned int escalate_virq;
-	struct {
-		void (*handler)(void *cookie);
-		void *cookie;
-		const char *name;
-	} apc_table[BITS_PER_LONG];
 #ifdef CONFIG_SMP
 	cpumask_t supported_cpus;
 #endif
-- 
2.26.2


