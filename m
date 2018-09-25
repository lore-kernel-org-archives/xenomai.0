From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:53 +0200
Message-Id: <20180925103809.4932-17-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 16/32] x86/mmx32: ipipe: use slow copy from head
 domain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Using the MMX unit from the head domain requires the co-kernel to deal
with preemption of sections delimited by kernel_fpu_begin <->
kernel_fpu_end, which is a burden when it comes to scheduling its own
fpu-enabled tasks in between. Branch to the generic memcpy instead.
---
 arch/x86/lib/mmx_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/mmx_32.c b/arch/x86/lib/mmx_32.c
index 4321fa02e18d..1d9ad8f0bc4b 100644
--- a/arch/x86/lib/mmx_32.c
+++ b/arch/x86/lib/mmx_32.c
@@ -31,7 +31,7 @@ void *_mmx_memcpy(void *to, const void *from, size_t len)
 	void *p;
 	int i;
 
-	if (unlikely(in_interrupt()))
+	if (unlikely(!ipipe_root_p || in_interrupt()))
 		return __memcpy(to, from, len);
 
 	p = to;
-- 
2.14.4


