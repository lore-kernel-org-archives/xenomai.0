From: roman.stratiienko@globallogic.com
Subject: [PATCH 5/7] kernel: cobalt: support building against v5.0
Date: Tue,  5 Mar 2019 16:45:19 +0200
Message-Id: <20190305144521.2567-5-roman.stratiienko@globallogic.com>
In-Reply-To: <20190305144521.2567-1-roman.stratiienko@globallogic.com>
References: <20190305144521.2567-1-roman.stratiienko@globallogic.com>
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

Since kernel v5.0 upstream commit 96d4f267e40f
("Remove 'type' argument from access_ok() function")
 access_ok() funcion takes only 2 parameters

Change access_rok and access_wok wrappers for kernels
 starting from v5.0, and preserve them for earlier versions

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 kernel/cobalt/include/asm-generic/xenomai/syscall.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index e14a9d1e3..0d50d4107 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -27,8 +27,13 @@
 #include <asm/xenomai/machine.h>
 #include <cobalt/uapi/asm-generic/syscall.h>
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 0, 0)
+#define access_rok(addr, size)	access_ok((addr), (size))
+#define access_wok(addr, size)	access_ok((addr), (size))
+#else
 #define access_rok(addr, size)	access_ok(VERIFY_READ, (addr), (size))
 #define access_wok(addr, size)	access_ok(VERIFY_WRITE, (addr), (size))
+#endif
 
 #define __xn_reg_arglist(regs)	\
 	__xn_reg_arg1(regs),	\
-- 
2.17.1


