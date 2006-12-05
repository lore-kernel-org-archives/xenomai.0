Subject: Re: =?ISO-8859-1?Q?R=E9p=2E?= : Re: [Xenomai-help]  Switch mode
	with x86
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45748DE3.9030300@domain.hid>
References: <s56d88c0.099@domain.hid>  <45732660.6050605@domain.hid>
	<1165175999.4952.431.camel@domain.hid>  <45733D1B.7010805@domain.hid>
	<1165188655.4952.457.camel@domain.hid> <4573D896.9050200@domain.hid>
	<45748DE3.9030300@domain.hid>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 23:17:20 +0100
Message-Id: <1165357040.7218.15.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-12-04 at 22:06 +0100, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > ...
> > This indicates that we face an I-pipe bug: the scheduled Linux call on
> > relaxation of TASK2 and then later TASK1 somehow gets lost (there is no
> > rthal_apc_handler in the remaining trace).
> 
> I think I got it. No I-pipe bug, but one in the HAL.
> 
> What happened? A weird race caused by the unprotected optimisation to
> only call rthal_schedule_irq() if there is no APC pending yet. This is
> the constellation I finally worked out via instrumenting and tracing:
> 
> PRIO 1:
> rthal_apc_schedule()
>   test&set rthal_apc_pending
>   (but no rthal_schedule_irq() yet)
> 
>                         -PREEMPTION-
> 
>                                         PRIO 99:
>                                         ...
>                                         rthal_apc_schedule()
>                                           test rthal_apc_pending
>                                           (already set => no
>                                           rthal_schedule_irq()!)
> 
> So, no one reported the ACP to I-pipe, and no one ever will in Nicolas
> scenario - soft lock-up!
> 
> Nicolas, please give the attached patch a try. Your test is running fine
> for me now.
> 
> 
> At this chance: do we need rthal_apc_schedule() returning the previous
> state at all? No current caller checks the return value. If it's OK to
> clean this up, I will post a combined patch.

It's pointless to return this info, the caller would not be able to
exploit it in any way.

Could you please try this other form of your fix? This would prevent the
virq to be fired twice (or more) uselessly, with no request pending.
Masking interrupts to enforce atomicity is ok here, since
rthal_schedule_irq() will run this way in any case. Additionally, my
comment about migration was suspicious, I do see a case where CPU
migration would leave this code in limbos. But to get the cpuid
properly, we need the local interrupts to be masked first. TIA,

--- arch/generic/hal.c	(revision 1919)
+++ arch/generic/hal.c	(working copy)
@@ -596,18 +596,24 @@
 int rthal_apc_schedule(int apc)
 {
     rthal_declare_cpuid;
+    unsigned long flags;
+    int ret = 0;
 
     if (apc < 0 || apc >= RTHAL_NR_APCS)
-        return -EINVAL;
+	    return -EINVAL;
 
-    rthal_load_cpuid();         /* Migration would be harmless here. */
+    rthal_local_irq_save(flags);
 
-    if (!test_and_set_bit(apc, &rthal_apc_pending[cpuid])) {
-        rthal_schedule_irq(rthal_apc_virq);
-        return 1;
-    }
+    rthal_load_cpuid();
 
-    return 0;                   /* Already pending. */
+    if (__test_and_set_bit(apc, &rthal_apc_pending[cpuid]))
+	    ret = 1;
+    else
+	    rthal_schedule_irq(rthal_apc_virq);
+
+    rthal_local_irq_restore(flags);
+
+    return ret;
 }
 
 #ifdef CONFIG_PROC_FS

-- 
Philippe.



