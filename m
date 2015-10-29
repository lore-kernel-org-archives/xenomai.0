From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Thu, 29 Oct 2015 08:47:28 +0100
Message-Id: <1446104848-20767-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 1/3] ipipe/trace: ipipe_trace_asm: allow null PC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

The PC is replaced with the return address when null.
---
 kernel/ipipe/tracer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/ipipe/tracer.c b/kernel/ipipe/tracer.c
index c8c1b97..e726444 100644
--- a/kernel/ipipe/tracer.c
+++ b/kernel/ipipe/tracer.c
@@ -458,6 +458,8 @@ ipipe_trace_asm(enum ipipe_trace_type type, unsigned long eip,
 {
 	if (!ipipe_trace_enable)
 		return;
+	if (eip == 0)
+		eip = __BUILTIN_RETURN_ADDRESS0;
 	__ipipe_trace(type, eip, parent_eip, v);
 }
 
-- 
1.8.4


