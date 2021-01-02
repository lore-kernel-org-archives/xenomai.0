From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail 12/13] cobalt/debug: pipeline: abstract panic prep
 call
Date: Sat,  2 Jan 2021 10:33:52 +0100
Message-Id: <20210102093353.3195090-13-rpm@xenomai.org>
In-Reply-To: <20210102093353.3195090-1-rpm@xenomai.org>
References: <20210102093353.3195090-1-rpm@xenomai.org>
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

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/ipipe/pipeline/pipeline.h | 5 +++++
 kernel/cobalt/debug.c                           | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/ipipe/pipeline/pipeline.h b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
index 6f6958402..0ffc9b00b 100644
--- a/include/cobalt/kernel/ipipe/pipeline/pipeline.h
+++ b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
@@ -70,4 +70,9 @@ static inline void pipeline_send_timer_ipi(const struct cpumask *dest)
 
 #endif
 
+static inline void pipeline_prepare_panic(void)
+{
+	ipipe_prepare_panic();
+}
+
 #endif /* !_COBALT_KERNEL_IPIPE_PIPELINE_H */
diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
index 12fc57289..1e9edda99 100644
--- a/kernel/cobalt/debug.c
+++ b/kernel/cobalt/debug.c
@@ -587,7 +587,7 @@ int xnlock_dbg_release(struct xnlock *lock,
 	}
 
 	if (unlikely(lock->owner != cpu)) {
-		ipipe_prepare_panic();
+		pipeline_prepare_panic();
 		printk(XENO_ERR "lock %p already unlocked on CPU #%d\n"
 				"          last owner = %s:%u (%s(), CPU #%d)\n",
 		       lock, cpu, lock->file, lock->line, lock->function,
-- 
2.26.2


