From: roman.stratiienko@globallogic.com
Subject: [PATCH v2 03/10] kernel: cobalt: use printk instead of print_symbol
 on v4.16 and later
Date: Wed,  6 Mar 2019 19:53:24 +0200
Message-Id: <20190306175331.25444-3-roman.stratiienko@globallogic.com>
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

print_symbol() removed since v4.16-rc1 commit d2279c9d7f7d
("kallsyms: remove print_symbol() function")
use print_symbol for version less than v4.16 and printk starting from v4.16

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
Since v1: add cast to (void *) to fix build warning
 kernel/cobalt/posix/process.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index d0f2f3725..85dd3cfb7 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -747,8 +747,13 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 		}
 		splexit(s);
 #endif /* CONFIG_XENO_ARCH_FPU */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 16, 0)
+		printk("invalid use of FPU in Xenomai context at %pS\n",
+		       (void *)xnarch_fault_pc(d));
+#else
 		print_symbol("invalid use of FPU in Xenomai context at %s\n",
 			     xnarch_fault_pc(d));
+#endif
 	}
 
 	/*
-- 
2.17.1


