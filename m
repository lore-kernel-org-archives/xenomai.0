References: <ca00a2b2-b44d-a25a-cb53-852a0f8e2d32@gmail.com>
 <594f0ba9-8e01-d2d2-a58e-2abcb3b72289@gmail.com>
 <fb226301-fe52-c9c9-f5a0-3f760b8d5492@gmail.com>
 <74da7f07-6df9-5a5f-ff63-b414437749b2@xenomai.org>
 <1dbe3f00-a866-248c-3799-a0d8efeee4e4@gmail.com>
 <e937a73f-ef0f-5394-bdae-400fcfe30ddb@gmail.com>
 <2e75fd33-8998-4cfb-6fa6-bef20f37f2dc@gmail.com>
 <e398a8e0-65f2-cd46-b502-0e81f5e6fee6@xenomai.org>
 <9c2a8966-09c2-cc32-9a7b-fe16339d9c80@gmail.com>
 <bd252434-25b7-e0c1-5a55-7e9321c48d8f@gmail.com>
 <6430f861-a017-02e8-ba19-9a75aedc9475@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b6be86e9-bc5a-c213-d458-219d8c4ecc01@xenomai.org>
Date: Sat, 12 May 2018 19:08:21 +0200
MIME-Version: 1.0
In-Reply-To: <6430f861-a017-02e8-ba19-9a75aedc9475@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Crash with longer dlopen/dlcose sequence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Edouard Tisserant <edouard.tisserant@gmail.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 05/09/2018 12:27 PM, Edouard Tisserant wrote:
> 
>>> [Xenomai] bad syscall <0xf0002>
>> #define __ARM_NR_BASE           (__NR_SYSCALL_BASE+0x0f0000)
>> #define __ARM_NR_cacheflush     (__ARM_NR_BASE+2)
> 
> This special syscall is issued by Glibc in _dl_reloacate_object (see
> /elf/dl-reloc.c and /sysdeps/unix/sysv/linux/arm/dl-machine.h)
> 
> As a workaround, rebuilding everything with -fPIC avoids relocation, and
> then bad syscall.
> 

Thanks for digging this out. Could you try this patch, keeping the relocation enabled in your build? TIA,

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
index 92afe8d9d..baa352181 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
@@ -33,6 +33,11 @@
 #define __ARM_NR_ipipe	(__NR_SYSCALL_BASE + XENO_ARM_SYSCALL)
 #endif
 
+/*
+ * Cobalt syscall numbers can be fetched from ARM_ORIG_r0 with ARM_r7
+ * containing the Xenomai syscall marker, Linux syscalls directly from
+ * ARM_r7 (may require the OABI tweak).
+ */
 #define __xn_reg_sys(__regs)	((__regs)->ARM_ORIG_r0)
 /* In OABI_COMPAT mode, handle both OABI and EABI userspace syscalls */
 #ifdef CONFIG_OABI_COMPAT
@@ -46,11 +51,15 @@
 #define __xn_syscall(__regs)	(__xn_reg_sys(__regs) & ~__COBALT_SYSCALL_BIT)
 
 /*
- * Returns the syscall number depending on the handling core. Cobalt
- * syscall numbers can be fetched from ARM_ORIG_r0 with ARM_r7
- * containing the Xenomai syscall marker, Linux syscalls directly from
- * ARM_r7 (may require the OABI tweak).
+ * Root syscall number with predicate (valid only if
+ * !__xn_syscall_p(__regs)).
  */
+#define __xn_rootcall_p(__regs, __code)					\
+	({								\
+		*(__code) = __xn_abi_decode(__regs);			\
+		*(__code) < NR_syscalls || *(__code) >= __ARM_NR_BASE;	\
+	})
+	
 static inline long __xn_get_syscall_nr(struct pt_regs *regs)
 {
 	return __xn_syscall_p(regs) ? __xn_reg_sys(regs) : __xn_abi_decode(regs);
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 68700a336..058a8282b 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -666,10 +666,6 @@ ret_handled:
 	return KEVENT_STOP;
 
 linux_syscall:
-	code = __xn_get_syscall_nr(regs);
-	if (code >= NR_syscalls)
-		goto bad_syscall;
-
 	if (xnsched_root_p())
 		/*
 		 * The call originates from the Linux domain, either
@@ -679,6 +675,9 @@ linux_syscall:
 		 */
 		return KEVENT_PROPAGATE;
 
+	if (!__xn_rootcall_p(regs, &code))
+		goto bad_syscall;
+
 	/*
 	 * We know this is a Cobalt thread since it runs over the head
 	 * domain, however the current syscall should be handled by

-- 
Philippe.

