Subject: [PATCH 2/2] x86/ipipe: Define and use ipipe_root_nr_syscalls
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <56901bab-a85d-2c35-83d7-df8521f72076@siemens.com>
Message-ID: <8c746606-4d4c-8ea6-ce6d-f92d39bb0e63@siemens.com>
Date: Thu, 31 Jan 2019 18:01:37 +0100
MIME-Version: 1.0
In-Reply-To: <56901bab-a85d-2c35-83d7-df8521f72076@siemens.com>
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

If we support compat mode, we need to account for IA32_NR_syscalls being
different than NR_syscalls.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/entry/common.c           | 3 ++-
 arch/x86/include/asm/ipipe_base.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 568f45c47063..8b729d9386b3 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -290,7 +290,8 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
 	 * want to run them exactly once per syscall exit with IRQs on.
 	 */
 	if (unlikely((!IS_ENABLED(CONFIG_IPIPE) ||
-		      syscall_get_nr(current, regs) < NR_syscalls) &&
+		      syscall_get_nr(current, regs) <
+				ipipe_root_nr_syscalls(ti)) &&
 		     (cached_flags & SYSCALL_EXIT_WORK_FLAGS)))
 		syscall_slow_exit_work(regs, cached_flags);
 
diff --git a/arch/x86/include/asm/ipipe_base.h b/arch/x86/include/asm/ipipe_base.h
index e0debe840abd..c09697b1f20c 100644
--- a/arch/x86/include/asm/ipipe_base.h
+++ b/arch/x86/include/asm/ipipe_base.h
@@ -115,6 +115,11 @@ static inline unsigned long __ipipe_ffnz(unsigned long ul)
       return ul;
 }
 
+#ifdef CONFIG_IA32_EMULATION
+#define ipipe_root_nr_syscalls(ti)	\
+	((ti->status & TS_COMPAT) ? IA32_NR_syscalls : NR_syscalls)
+#endif /* CONFIG_IA32_EMULATION */
+
 #endif	/* X86_64 */
 
 struct pt_regs;
-- 
2.16.4

