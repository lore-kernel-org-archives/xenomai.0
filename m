From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH] dovetail: add prctl() call form
Date: Tue,  7 Sep 2021 19:55:03 +0200
Message-Id: <20210907175503.289178-2-rpm@xenomai.org>
In-Reply-To: <20210907175503.289178-1-rpm@xenomai.org>
References: <20210907175503.289178-1-rpm@xenomai.org>
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

From: Philippe Gerum <rpm@xenomai.org>

The syscall form used for issuing requests to the companion core is
based on ORing __OOB_SYSCALL_BIT to the syscall register for tagging
an out-of-band syscall, which is outside of the valid in-band range
for syscall numbers.

Unfortunately, this method has a major drawback: tools like Valgrind
which track system calls issued by applications may choke on
out-of-band system calls since these do not belong to the common set
it recognizes. Although adding syscall wrappers to Valgrind might be a
solution, this would not be the most practical one for dual kernel
syscall interfaces. The most practical approach would be to piggyback
on an existing system call which Valgrind (and others) already
recognizes.

To this end, we provide another option for issuing out-of-band
syscalls to the companion core, based on the [kitchen-sink] prctl(2)
call. The prctl() syscall is unconditionally routed to the core for
inspection, along with any syscall which bears the __OOB_SYSCALL_BIT
tag as previously.

According to this scheme, the core should figure out whether it should
handle the current prctl() request, or leave it to the in-band kernel
(i.e. propagation status set to zero). To fit in the prctl()
signature, the core would typically use the prctl() @option argument
to encode its own syscall number, which would leave enough room for up
to 4 arguments to the corresponding request.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/dovetail.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index b68cfb10093db0e..92fc8e2e1b4a818 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -72,7 +72,7 @@ void __weak handle_oob_syscall(struct pt_regs *regs)
 int __weak handle_pipelined_syscall(struct irq_stage *stage,
 				    struct pt_regs *regs)
 {
-	return 0;
+	return 0;	/* i.e. propagate to in-band handler. */
 }
 
 void __weak handle_oob_mayday(struct pt_regs *regs)
@@ -166,6 +166,19 @@ int __pipeline_syscall(struct pt_regs *regs)
 	return ret;
 }
 
+static inline bool maybe_oob_syscall(unsigned int nr, struct pt_regs *regs)
+{
+	/*
+	 * Check whether the companion core might be interested in
+	 * @nr. Hand the request to the core if __OOB_SYSCALL_BIT is
+	 * set in @nr, or this is a prctl() request into which an oob
+	 * syscall might be folded. If the prctl() call ends up being
+	 * a regular in-band request, the core should tell us to
+	 * propagate it to the in-band handler eventually.
+	 */
+	return (nr & __OOB_SYSCALL_BIT) || nr == __NR_prctl;
+}
+
 int pipeline_syscall(unsigned int nr, struct pt_regs *regs)
 {
 	struct thread_info *ti = current_thread_info();
@@ -175,11 +188,12 @@ int pipeline_syscall(unsigned int nr, struct pt_regs *regs)
 	WARN_ON_ONCE(dovetail_debug() && hard_irqs_disabled());
 
 	/*
-	 * If __OOB_SYSCALL_BIT is set into the syscall number and we
-	 * are running out-of-band, pass the request directly to the
-	 * companion core by calling the oob syscall handler.
+	 * If the syscall signature belongs to the out-of-band syscall
+	 * set and we are running out-of-band, pass the request
+	 * directly to the companion core by calling the oob syscall
+	 * handler.
 	 *
-	 * Otherwise, if __OOB_SYSCALL_BIT is set or alternate
+	 * Otherwise, if this is an out-of-band syscall or alternate
 	 * scheduling is enabled for the caller, propagate the syscall
 	 * through the pipeline stages, so that:
 	 *
@@ -203,7 +217,7 @@ int pipeline_syscall(unsigned int nr, struct pt_regs *regs)
 	 * after exiting to user.
 	 */
 
-	if ((nr & __OOB_SYSCALL_BIT) && (local_flags & _TLF_OOB)) {
+	if ((local_flags & _TLF_OOB) && maybe_oob_syscall(nr, regs)) {
 		handle_oob_syscall(regs);
 		local_flags = READ_ONCE(ti_local_flags(ti));
 		if (local_flags & _TLF_OOB) {
@@ -216,7 +230,7 @@ int pipeline_syscall(unsigned int nr, struct pt_regs *regs)
 		}
 	}
 
-	if ((local_flags & _TLF_DOVETAIL) || (nr & __OOB_SYSCALL_BIT)) {
+	if ((local_flags & _TLF_DOVETAIL) || maybe_oob_syscall(nr, regs)) {
 		ret = __pipeline_syscall(regs);
 		local_flags = READ_ONCE(ti_local_flags(ti));
 		if (local_flags & _TLF_OOB)
-- 
2.31.1


