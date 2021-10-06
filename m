From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/arch/arm: fptest: Add missing SIMD register clobbering
Message-ID: <30a64188-e09e-d63d-dfcc-a678f72e15ac@siemens.com>
Date: Wed, 6 Oct 2021 17:19:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This caused troubles with modern gcc that starts to use those regs for
other purposes. Seen with gcc-10 on Debian 11 e.g.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
index b81d109933..d5c2c7515b 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
@@ -32,7 +32,12 @@ static inline void fp_regs_set(int features, unsigned int val)
 		/* vldm %0!, {d0-d15},
 		   AKA fldmiax %0!, {d0-d15} */
 		__asm__ __volatile__("ldc p11, cr0, [%0],#32*4":
-				     "=r"(i): "0"(&e[0]): "memory");
+				     "=r"(i)
+				     : "0"(&e[0])
+				     : "d0", "d1", "d2", "d3", "d4", "d5",
+				       "d6", "d7", "d8", "d9", "d10", "d11",
+				       "d12", "d13", "d14", "d15",
+				       "memory");
 	}
 }
 
-- 
2.31.1

