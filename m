From: roman.stratiienko@globallogic.com
Subject: [PATCH v2 02/10] kernel: cobalt: replace ACCESS_ONCE with READ_ONCE
Date: Wed,  6 Mar 2019 19:53:23 +0200
Message-Id: <20190306175331.25444-2-roman.stratiienko@globallogic.com>
In-Reply-To: <20190306175331.25444-1-roman.stratiienko@globallogic.com>
References: <20190306175331.25444-1-roman.stratiienko@globallogic.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Roman Stratiienko <roman.stratiienko@globallogic.com>

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

READ_ONCE() introduced from v3.19 commit 230fa253df63
("kernel: Provide READ_ONCE and ASSIGN_ONCE")
and ACCESS_ONCE() removed startibg from v4.15-rc4 commit
b899a850431e ("compiler.h: Remove ACCESS_ONCE()")
Replace ACCESS_ONCE with READ_ONCE and make READ_ONCE wrapper
for case when READ_ONCE is not available (<v3.19)

This will fix build with v4.15

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 include/cobalt/uapi/kernel/urw.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/uapi/kernel/urw.h b/include/cobalt/uapi/kernel/urw.h
index 40a1eb5ff..fcfde21a0 100644
--- a/include/cobalt/uapi/kernel/urw.h
+++ b/include/cobalt/uapi/kernel/urw.h
@@ -53,11 +53,15 @@ typedef struct {
 #define URW_INITIALIZER     { 0 }
 #define DEFINE_URW(__name)  urw_t __name = URW_INITIALIZER
 
+#ifndef READ_ONCE
+#define READ_ONCE ACCESS_ONCE
+#endif
+
 static inline void __try_read_start(const urw_t *urw, urwstate_t *tmp)
 {
 	__u32 token;
 repeat:
-	token = ACCESS_ONCE(urw->sequence);
+	token = READ_ONCE(urw->sequence);
 	smp_rmb();
 	if (token & 1) {
 		cpu_relax();
-- 
2.17.1


