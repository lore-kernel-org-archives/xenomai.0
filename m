From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH] x86: dovetail: Fix TS flag reservation
Message-ID: <b9298c16-0340-9189-a2a7-0fc678c84e98@siemens.com>
Date: Mon, 7 Jun 2021 12:05:33 +0200
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
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

We had an overlap with compat flags so that, e.g., TS_COMPAT_RESTART
made a 32-bit standard task also a dovetail one.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/include/asm/thread_info.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 54e409140884..8c3e9c0c0045 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -215,10 +215,11 @@ static inline int arch_within_stack_frames(const void * const stack,
  * have to worry about atomic accesses.
  */
 #define TS_COMPAT		0x0002	/* 32bit syscall active (64BIT)*/
-#define TS_OOB			0x0004	/* Thread is running out-of-band */
-#define TS_DOVETAIL		0x0008  /* Dovetail notifier enabled */
-#define TS_OFFSTAGE		0x0010	/* Thread is in-flight to OOB context */
-#define TS_OOBTRAP		0x0020	/* Handling a trap from OOB context */
+/* bits 2 and 3 reserved for compat */
+#define TS_OOB			0x0010	/* Thread is running out-of-band */
+#define TS_DOVETAIL		0x0020  /* Dovetail notifier enabled */
+#define TS_OFFSTAGE		0x0040	/* Thread is in-flight to OOB context */
+#define TS_OOBTRAP		0x0080	/* Handling a trap from OOB context */
 
 #define _TLF_OOB		TS_OOB
 #define _TLF_DOVETAIL		TS_DOVETAIL
-- 
2.26.2

