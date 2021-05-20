From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 06/25] cobalt/x86: ipipe: Remove leftover from x86_32 removal
Date: Thu, 20 May 2021 23:44:16 +0200
Message-Id: <d8be79d16f04a4d06db5e85ca2c97c6f4139bb4f.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h   | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h
index f3f1b476f7..f889f5fc73 100644
--- a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h
@@ -29,19 +29,11 @@
  */
 #define __xn_reg_sys(regs)    ((regs)->orig_ax)
 #define __xn_reg_rval(regs)   ((regs)->ax)
-#ifdef __i386__
-#define __xn_reg_arg1(regs)   ((regs)->bx)
-#define __xn_reg_arg2(regs)   ((regs)->cx)
-#define __xn_reg_arg3(regs)   ((regs)->dx)
-#define __xn_reg_arg4(regs)   ((regs)->si)
-#define __xn_reg_arg5(regs)   ((regs)->di)
-#else /* x86_64 */
 #define __xn_reg_arg1(regs)   ((regs)->di)
 #define __xn_reg_arg2(regs)   ((regs)->si)
 #define __xn_reg_arg3(regs)   ((regs)->dx)
 #define __xn_reg_arg4(regs)   ((regs)->r10)
 #define __xn_reg_arg5(regs)   ((regs)->r8)
-#endif /* x86_64 */
 #define __xn_reg_pc(regs)     ((regs)->ip)
 #define __xn_reg_sp(regs)     ((regs)->sp)
 
-- 
2.26.2


