From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] lib/cobalt: x86: Relax asm constraints for syscall wrapper
Message-ID: <d3783484-d571-431c-8954-9f480876396c@siemens.com>
Date: Mon, 16 Aug 2021 11:10:35 +0200
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

The y2038 test will pass the syscall number as variable. This is in
conflict with immediate constraint the current wrapper uses so far.
Relax it, the compiler will still use immediate where possible.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Adding this before your series in next.

 lib/cobalt/arch/x86/include/asm/xenomai/syscall.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h b/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h
index 21aace16f9..2e02b9983b 100644
--- a/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h
@@ -84,7 +84,7 @@ asm (".L__X'%ebx = 1\n\t"
 		DOSYSCALL					\
 		RESTOREARGS_##nr				\
 		: "=a" (__resultvar)				\
-		: "i" (__xn_syscode(op)) ASMFMT_##nr(args)	\
+		: "g" (__xn_syscode(op)) ASMFMT_##nr(args)	\
 		: "memory", "cc");				\
 	(int) __resultvar;					\
 })
@@ -98,7 +98,7 @@ asm (".L__X'%ebx = 1\n\t"
 		DOSYSCALLSAFE					\
 		RESTOREARGS_##nr				\
 		: "=a" (__resultvar)				\
-		: "i" (__xn_syscode(op)) ASMFMT_##nr(args)	\
+		: "g" (__xn_syscode(op)) ASMFMT_##nr(args)	\
 		: "memory", "cc");				\
 	(int) __resultvar;					\
 })
-- 
2.31.1

