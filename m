From: Fino Meng <fino.meng@linux.intel.com>
Subject: [PATCH] ipipe: export symbol of __ipipe_dispatch_irq
Date: Mon,  7 Dec 2020 21:04:18 +0800
Message-Id: <20201207130418.6978-1-fino.meng@linux.intel.com>
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

some drivers referenced __ipipe_dispatch_irq may compile as kernel
module, which need __ipipe_dispatch_irq exported otherwise build will
fail.

Signed-off-by: Fino Meng <fino.meng@linux.intel.com>
---
 kernel/ipipe/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 60f74291f22a..99a88e4d620e 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1573,6 +1573,7 @@ void __ipipe_dispatch_irq(unsigned int irq, int flags) /* hw interrupts off */
 sync:
 	__ipipe_sync_pipeline(ipipe_head_domain);
 }
+EXPORT_SYMBOL_GPL(__ipipe_dispatch_irq);
 
 void ipipe_raise_irq(unsigned int irq)
 {
-- 
2.20.1


