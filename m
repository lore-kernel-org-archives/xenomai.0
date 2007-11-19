Message-ID: <4741CAEE.7020003@domain.hid>
Date: Mon, 19 Nov 2007 18:42:06 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47374EF7.4070608@domain.hid>
In-Reply-To: <47374EF7.4070608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH] x86_64: cleanup IRQ on/off tracing
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Tracing of IRQ on/off paths on x86_64 currently suffers from heavy
> over-instrumentation.

I understand the point of grouping ipipe_trace_begin/ipipe_trace_end
statements inside the .interrupt macros and using a lightweight thunk
code since we are already covered by the SAVE_ARGS prologue, but I find
the following hunk suspicious, since unlike i386, we do not virtualize
inline sti/cli ops for x86_64. My concern is that removing this
instrumentation would leave us naked in the cold the day some subtle
upstream change introduces a hw masked section we don't immediately
notice; such trace points would precisely help us spotting it.

--- linux-2.6.23.1-xeno_64.orig/include/asm-x86_64/irqflags.h
+++ linux-2.6.23.1-xeno_64/include/asm-x86_64/irqflags.h
@@ -241,19 +241,12 @@ static inline void local_irq_enable_hw_n
 #endif /* CONFIG_IPIPE_TRACE_IRQSOFF */

 #else /* __ASSEMBLY__: */
-#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
-#define IPIPE_TRACE_IRQS_ON	call __ipipe_trace_irqs_on_thunk
-#define IPIPE_TRACE_IRQS_OFF	call __ipipe_trace_irqs_off_thunk
-#else /* !CONFIG_IPIPE_TRACE_IRQSOFF */
-#define IPIPE_TRACE_IRQS_ON
-#define IPIPE_TRACE_IRQS_OFF
-#endif /* !CONFIG_IPIPE_TRACE_IRQSOFF */
 # ifdef CONFIG_TRACE_IRQFLAGS
-#  define TRACE_IRQS_ON	IPIPE_TRACE_IRQS_ON; call trace_hardirqs_on_thunk
-#  define TRACE_IRQS_OFF	IPIPE_TRACE_IRQS_OFF; call
trace_hardirqs_off_thunk
+#  define TRACE_IRQS_ON		call trace_hardirqs_on_thunk
+#  define TRACE_IRQS_OFF	call trace_hardirqs_off_thunk
 # else
-#  define TRACE_IRQS_ON	IPIPE_TRACE_IRQS_ON
-#  define TRACE_IRQS_OFF	IPIPE_TRACE_IRQS_OFF
+#  define TRACE_IRQS_ON
+#  define TRACE_IRQS_OFF
 # endif
 #endif

This patch aligns x86_64 in this regard with i386
> (and hopefully the other tracer-supporting archs too). It also gets rid
> of related *_thunk indirections (I wonder if we cannot kill more of
> them...).

We could probably kill the __ipipe_preempt_schedule_irq thunk quite
easily, since we branch to exit_intr which starts with a very limited
register context. However, replacing the thunk routing
__ipipe_syscall_root would require more work, since the syscall arg
registers are expected to survive the call, and those are not
callee-saved according to the AMD64 ABI (which makes sense). We would at
least have to pull all the potentially spilled regs from the saved
exception frame upon return from the I-pipe hook. Ok, this would save a
few cycles we currently spend saving them...

-- 
Philippe.

