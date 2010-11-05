Message-ID: <4CD35F7C.7010607@domain.hid>
Date: Fri, 05 Nov 2010 02:35:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	<4CD18782.7090607@domain.hid>	<4CD191EE.7000604@domain.hid>	<4CD1936E.50203@domain.hid>	<4CD1BA29.9000303@domain.hid>	<1288816871.1842.84.camel@domain.hid>	<4CD1DC1B.8060407@domain.hid>	<4CD1DE12.5010309@domain.hid>	<4CD1E890.5010702@domain.hid>	<4CD1EC2F.4040603@domain.hid>	<4CD1ED16.8030103@domain.hid>	<4CD1EDA8.10007@domain.hid>	<4CD1F33C.5070208@domain.hid>	<4CD1F3F5.5080505@domain.hid>	<4CD1F4FE.9020908@domain.hid>	<4CD1F69B.9070100@domain.hid>	<4CD1F906.1070703@domain.hid>	<4CD1FABD.1080301@domain.hid>	<4CD2612C.2070507@domain.hid>	<4CD279F7.7070502@domain.hid>	<4CD27C46.8010302@domain.hid>	<4CD27DC2.7060607@domain.hid>	<4CD2A96B.3080001@domain.hid>	<4CD2B2A7.9010900@domain.hid>	<4CD2C50F.1090604@domain.hid>	<4CD2C8E2.9090608@domain.hid>	<4CD2D25D.6000604@domain.hid>	<4CD32EF1.7000202@domain.hid>
	<4CD33D59.1010003@domain.hid>	<4CD340E0.7020109@domain.hid>
	<4CD34293.7040802@domain.hid> <4CD345F0.3040509@domain.hid>
In-Reply-To: <4CD345F0.3040509@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Am 05.11.2010 00:25, Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Am 04.11.2010 23:08, Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> rework. Safer for now is likely to revert 56ff4329ff, keeping nucleus
>>>>>> debugging off.
>>>>> That is not enough.
>>>> It is, I've reviewed the code today.
>>> The fallouts I am talking about are:
>>> 47dac49c71e89b684203e854d1b0172ecacbc555
>> Not related.
>>
>>> 38f2ca83a8e63cc94eaa911ff1c0940c884b5078
>> An optimization.
>>
>>> 5e7cfa5c25672e4478a721eadbd6f6c5b4f88a2f
>> That fall out of that commit is fixed in my series.
>>
>>>>> This commit was followed by several others to "fix
>>>>> the fix". You know how things are, someone proposes a fix, which fixes
>>>>> things for him, but it breaks in the other people configurations (one of
>>>>> the fallouts was a complete revamp of include/asm-arm/atomic.h for
>>>>> instance).
>>>>>
>>>> I've pushed a series that reverts that commit, then fixes and cleans up
>>>> on top of it. Just pushed if you want to take a look. We can find some
>>>> alternative debugging mechanism independently (though I'm curious to see
>>>> it - it still makes no sense to me).
>>> Since the fix is simply a modification to what we have currently. I
>>> would prefer if we did not remove it. In fact, I think it would be
>>> simpler if we started from what we currently have than reverting past
>>> patches.
>> Look at the series, it goes step by step to an IMHO clean state. We can
>> pull out the debugging check removal, though, if you prefer to work on
>> top of the existing code.
> 
> From my point of view, Anders looks for something that works, so 
> following the rules that the minimal set of changes minimize the chances
> of introducing new bugs while cleaning, I would go for the minimal set 
> of changes, such as:

The tested one (on SMP, and UP with and without unlocked ctx switch):

diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
index df56417..8888cf4 100644
--- a/include/nucleus/sched.h
+++ b/include/nucleus/sched.h
@@ -165,28 +165,27 @@ struct xnsched_class {
 #endif /* CONFIG_SMP */
 
 /* Test all resched flags from the given scheduler mask. */
-static inline int xnsched_resched_p(struct xnsched *sched)
+static inline int xnsched_remote_resched_p(struct xnsched *sched)
 {
-	return testbits(sched->status, XNRESCHED);
+	return !xnarch_cpus_empty(sched->resched);
 }
 
-static inline int xnsched_self_resched_p(struct xnsched *sched)
+static inline int xnsched_resched_p(struct xnsched *sched)
 {
 	return testbits(sched->status, XNRESCHED);
 }
 
 /* Set self resched flag for the given scheduler. */
 #define xnsched_set_self_resched(__sched__) do {		\
-  setbits((__sched__)->status, XNRESCHED);			\
+  __setbits((__sched__)->status, XNRESCHED);			\
 } while (0)
 
 /* Set specific resched flag into the local scheduler mask. */
 #define xnsched_set_resched(__sched__) do {				\
   xnsched_t *current_sched = xnpod_current_sched();			\
-  setbits(current_sched->status, XNRESCHED);				\
+  __setbits(current_sched->status, XNRESCHED);				\
   if (current_sched != (__sched__))	{				\
       xnarch_cpu_set(xnsched_cpu(__sched__), current_sched->resched);	\
-      setbits((__sched__)->status, XNRESCHED);				\
   }									\
 } while (0)
 
diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 862838c..4cb707a 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -276,18 +276,16 @@ EXPORT_SYMBOL_GPL(xnpod_fatal_helper);
 
 void xnpod_schedule_handler(void) /* Called with hw interrupts off. */
 {
-	xnsched_t *sched;
+	xnsched_t *sched = xnpod_current_sched();
 
 	trace_mark(xn_nucleus, sched_remote, MARK_NOARGS);
 #if defined(CONFIG_SMP) && defined(CONFIG_XENO_OPT_PRIOCPL)
-	sched = xnpod_current_sched();
 	if (testbits(sched->status, XNRPICK)) {
 		clrbits(sched->status, XNRPICK);
 		xnshadow_rpi_check();
 	}
-#else
-	(void)sched;
 #endif /* CONFIG_SMP && CONFIG_XENO_OPT_PRIOCPL */
+	xnsched_set_self_resched(sched);
 	xnpod_schedule();
 }
 
@@ -2174,7 +2172,7 @@ static inline int __xnpod_test_resched(struct xnsched *sched)
 	int resched = testbits(sched->status, XNRESCHED);
 #ifdef CONFIG_SMP
 	/* Send resched IPI to remote CPU(s). */
-	if (unlikely(xnsched_resched_p(sched))) {
+	if (unlikely(xnsched_remote_resched_p(sched))) {
 		xnarch_send_ipi(sched->resched);
 		xnarch_cpus_clear(sched->resched);
 	}
diff --git a/ksrc/nucleus/timer.c b/ksrc/nucleus/timer.c
index 1fe3331..a0ac627 100644
--- a/ksrc/nucleus/timer.c
+++ b/ksrc/nucleus/timer.c
@@ -97,7 +97,7 @@ void xntimer_next_local_shot(xnsched_t *sched)
 	__clrbits(sched->status, XNHDEFER);
 	timer = aplink2timer(h);
 	if (unlikely(timer == &sched->htimer)) {
-		if (xnsched_self_resched_p(sched) ||
+		if (xnsched_resched_p(sched) ||
 		    !xnthread_test_state(sched->curr, XNROOT)) {
 			h = xntimerq_it_next(&sched->timerqueue, &it, h);
 			if (h) {


-- 
                                                                Gilles.

