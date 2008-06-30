Message-ID: <4868EE0C.7050003@domain.hid>
Date: Mon, 30 Jun 2008 16:30:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>	<2766.81.252.86.91.1211992159.squirrel@domain.hid>	<2ff1a98a0805280931j611ae10er69b968ae8699d63d@domain.hid>	<16273.81.252.86.91.1212060383.squirrel@domain.hid>	<2ff1a98a0805290614w3d846e6by69b033204f912391@domain.hid>	<13639.81.252.86.91.1212153659.squirrel@domain.hid>	<18496.31292.674733.417262@domain.hid>	<3380.62.39.72.60.1213367793.squirrel@domain.hid>	<2ff1a98a0806130843u17a146c5g38daf88bcd5ab7f6@domain.hid>	<3842.81.252.86.91.1213598456.squirrel@domain.hid>	<2ff1a98a0806160233o1e37d876xc5210aa16ade0f70@domain.hid>	<7379.62.39.72.60.1213803323.squirrel@domain.hid>
	<4867AA72.8080108@domain.hid>
In-Reply-To: <4867AA72.8080108@domain.hid>
Content-Type: multipart/mixed; boundary="------------080604070004030303030805"
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080604070004030303030805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Fabien MAHOT wrote:
>> Hello,
>>
>> I would like to know if you find something about my problem? Do you have
>> more clues with the "frame pointers" debug?
> 
> Hi Fabien,
> 
> I found something. Could you try the attached patch, to see if we are
> spotting the right bug ?

Ok. Here comes a better patch. To be applied to the I-pipe patched kernel.

-- 
                                                  Gilles.

--------------080604070004030303030805
Content-Type: text/plain;
 name="ipipe-longer-atomicswitch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe-longer-atomicswitch.diff"

diff --git a/kernel/sched.c b/kernel/sched.c
index a4bf7d3..0865f23 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -2488,6 +2488,8 @@ context_switch(struct rq *rq, struct task_struct
*prev,

     barrier();

+    prev->state &= ~TASK_ATOMICSWITCH;
+
     if (task_hijacked(prev))
         return 1;
     /*
@@ -4161,11 +4163,9 @@ need_resched:
     rcu_qsctr_inc(cpu);
     prev = rq->curr;
     switch_count = &prev->nivcsw;
-     if (unlikely(prev->state & TASK_ATOMICSWITCH)) {
-         prev->state &= ~TASK_ATOMICSWITCH;
+     if (unlikely(prev->state & TASK_ATOMICSWITCH))
         /* Pop one disable level -- one still remains. */
         preempt_enable();
-     }

     release_kernel_lock(prev);
 need_resched_nonpreemptible:
@@ -4216,8 +4216,10 @@ need_resched_nonpreemptible:
          */
         cpu = smp_processor_id();
         rq = cpu_rq(cpu);
-    } else
+    } else {
+        prev->state &= ~TASK_ATOMICSWITCH;
         spin_unlock_irq(&rq->lock);
+    }

     hrtick_set(rq);

--------------080604070004030303030805--

