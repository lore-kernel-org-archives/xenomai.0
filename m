From: Henning Schild <henning.schild@siemens.com>
Date: Thu, 17 Sep 2015 14:46:35 +0200
Message-Id: <1442493995-25337-4-git-send-email-henning.schild@siemens.com>
In-Reply-To: <1442493995-25337-1-git-send-email-henning.schild@siemens.com>
References: <20150917143955.01a71eb6@md1em3qc>
 <1442493995-25337-1-git-send-email-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH xenomai3 2/2] adopt to kernel change
	3a161d99c43ce74c76aecff309be4c3ba455e823
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 kernel/cobalt/trace/cobalt-posix.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 2382615..07e5e92 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -92,7 +92,7 @@ DECLARE_EVENT_CLASS(syscall_exit,
 
 #define cobalt_print_sched_params(__policy, __p_ex)			\
 ({									\
-  	const char *__ret = p->buffer + p->len;				\
+	const char *__ret = p->buffer + p->seq.len;			\
 	switch (__policy) {						\
 	case SCHED_QUOTA:						\
 		trace_seq_printf(p, "priority=%d, group=%d",		\
-- 
2.4.6


