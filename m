Message-ID: <513A464E.90800@xenomai.org>
Date: Fri, 08 Mar 2013 21:13:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51372B12.2030400@mitrol.it>	<51373149.4050700@xenomai.org>	<5137370B.2050402@mitrol.it>	<51373841.70704@xenomai.org>	<51385910.80203@mitrol.it>	<51388A3A.2090004@xenomai.org>
	<51388DD2.2020805@mitrol.it>	<51388EB2.6000206@xenomai.org>
	<5139DEA2.9050103@mitrol.it>
In-Reply-To: <5139DEA2.9050103@mitrol.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Sporadic problem : rt_task_sleep
	locked	after	debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Cc: xenomai@xenomai.org

On 03/08/2013 01:50 PM, Paolo Minazzi wrote:

> This fault does not freeze the arm, I can countinue to work.
> 
> Ideas ?


Please try the following patch:

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index c91a6f3..ed3864b 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -1430,8 +1430,10 @@ void xnshadow_unmap(xnthread_t *thread)
 	rpi_pop(thread);
 
 	sys_ppd = xnsys_ppd_get(0);
-	xnheap_free(&sys_ppd->sem_heap, thread->u_mode);
-	thread->u_mode = NULL;
+	if (thread->u_mode) {
+		xnheap_free(&sys_ppd->sem_heap, thread->u_mode);
+		thread->u_mode = NULL;
+	}
 
 	xnarch_atomic_dec(&sys_ppd->refcnt);
 
@@ -2379,7 +2381,7 @@ int do_hisyscall_event(unsigned event, rthal_pipeline_stage_t *stage,
       ret_handled:
 
 	/* Update the userland-visible state. */
-	if (thread)
+	if (thread && thread->u_mode)
 		*thread->u_mode = thread->state;
 
 	trace_mark(xn_nucleus, syscall_histage_exit,
@@ -2549,7 +2551,7 @@ int do_losyscall_event(unsigned event, rthal_pipeline_stage_t *stage,
       ret_handled:
 
 	/* Update the userland-visible state. */
-	if (thread)
+	if (thread && thread->u_mode)
 		*thread->u_mode = thread->state;
 
 	trace_mark(xn_nucleus, syscall_lostage_exit,

-- 
                                                                Gilles.

