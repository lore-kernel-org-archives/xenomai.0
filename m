From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Wed, 12 Sep 2012 19:00:35 +0200
Message-Id: <1347469235-17712-4-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1347469235-17712-1-git-send-email-wolfgang.mauerer@siemens.com>
References: <1347469235-17712-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [PATCH 3/3] Fix IRQs-off-tracer for x86_64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: wolfgang.mauerer@siemens.com

Earlier kernels abused the frame pointer to store the
old stack pointer in SAVE_ARGS_IRQ. This behaviour was
changed in upstream commit a2bbe75089d, which breaks
the IRQs-off tracing code for x86_64.

Fix this by basing the argument calculations for
ipipe_trace_begin and ipipe_trace_end on the base
pointer stored in %rsi.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Tested-by: Gernot Hillier <gernot.hillier@siemens.com>
---
 arch/x86/kernel/entry_64.S |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index b523908..693ad08 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -869,6 +869,7 @@ END(interrupt)
 	CFI_ADJUST_CFA_OFFSET ORIG_RAX-RBP
 	SAVE_ARGS_IRQ
 #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+	/* SAVE_ARGS_IRQ places the frame pointer into %rdi */
 	pushq %rbp
 	leaq RIP-8(%rdi), %rbp	# make interrupted address show up in trace
 	pushq %rdi
@@ -877,13 +878,16 @@ END(interrupt)
 	call ipipe_trace_begin
 	popq %rdi
 	popq %rbp
+	pushq %rdi # Preserve the frame pointer...
 
 	call \func
 
+	popq %rdi # ...  across the function call
 	pushq %rbp
 	pushq %rax
-	movq 8-ARGOFFSET+ORIG_RAX(%rbp), %rdi
-	leaq 8-ARGOFFSET+RIP-8(%rbp), %rbp
+	/* Show interrupted address and IRQ number in the trace, as before */
+	leaq RIP-8(%rdi), %rbp
+	movq ORIG_RAX(%rdi), %rdi
 	notq %rdi
 	call ipipe_trace_end
 	popq %rax
-- 
1.7.6.4


