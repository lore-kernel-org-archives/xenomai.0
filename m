Message-ID: <4235A0BD.2010601@domain.hid>
Date: Mon, 14 Mar 2005 07:33:33 -0700
From: Jim Cromie <jcromie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000704060701050801050607"
Subject: [Adeos-main] [patch]  spelling errors - s/prioritary/priority/
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org, Philippe Gerum <rpm@xenomai.org>

This is a multi-part message in MIME format.
--------------000704060701050801050607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hi Philippe,

attached patch fixes spelling in adeos r9c6 patch;
prioritary -> priority.
I resisted urge to tinker with sentences around them;
I didnt want to subtly alter the meaning of stuff I dont
understand.

hth, and thanks for your work.
jimc



--------------000704060701050801050607
Content-Type: text/plain;
 name="c6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="c6.patch"

--- adeos-linux-2.6.10-i386-r9c6.patch.orig	2005-03-13 22:24:51.000000000 -0700
+++ adeos-linux-2.6.10-i386-r9c6.patch	2005-03-14 06:24:15.611540350 -0700
@@ -701,7 +701,7 @@
 +
 +    /* Make the current domain (== sleeper) wait for the mutex to be
 +       released. Adeos' pipelined scheme guarantees that the new
-+       sleeper _is_ more prioritary than any aslept domain since we
++       sleeper _is_ more priority than any aslept domain since we
 +       have stalled each sleeper's stage. Must be called with local hw
 +       interrupts off. */
 +
@@ -734,7 +734,7 @@
 +    flags = __test_and_set_bit(IPIPE_STALL_FLAG,&adp->cpudata[cpuid].status);
 +
 +    /* Two cases to handle here on SMP systems, only one for UP:
-+       1) in case of a conflicting access from a prioritary domain
++       1) in case of a conflicting access from a priority domain
 +       running on the same cpu, make this domain sleep on the mutex,
 +       and resume the current owner so it can release the lock asap.
 +       2) in case of a conflicting access from any domain on a
@@ -797,7 +797,7 @@
 +    if (mutex->sleepq != NULL)
 +	{
 +	adomain_t *sleeper = mutex->sleepq;
-+	/* Wake up the first most prioritary sleeper. */
++	/* Wake up the first highest priority sleeper. */
 +	mutex->sleepq = sleeper->m_link;
 +	__adeos_switch_to(adp_cpu_current[cpuid],sleeper,cpuid);
 +	adeos_load_cpuid();
@@ -2225,7 +2225,7 @@
 +	    if (adp == adp_root)
 +		{
 +		/* Make sure to re-enable hw interrupts to reduce
-+		   preemption latency by more prioritary domains when
++		   preemption latency by more priority domains when
 +		   calling Linux handlers. */
 +
 +		adeos_hw_sti();
@@ -2401,8 +2401,8 @@
 +       in mind that domains having a higher priority than the current
 +       one are sleeping on the adeos_suspend_domain() service. In
 +       addition, domains having a lower priority have been preempted
-+       by an interrupt dispatched to a more prioritary domain. Once
-+       the first and most prioritary stage has been selected here, the
++       by an interrupt dispatched to a more priority domain. Once
++       the first and highest priority stage has been selected here, the
 +       subsequent stages will be activated in turn when each visited
 +       domain calls adeos_suspend_domain() to wake up its neighbour
 +       down the pipeline. */
@@ -2419,7 +2419,7 @@
 +   just like if it has been actually received from a hw source. This
 +   both works for real and virtual interrupts. This also means that
 +   the current domain might be immediately preempted by a more
-+   prioritary domain who happens to handle this interrupt. */
++   priority domain who happens to handle this interrupt. */
 +
 +int fastcall adeos_trigger_irq (unsigned irq)
 +
@@ -5245,7 +5245,7 @@
 +   in the pipeline will get a chance to process the event. The latter
 +   will eventually be allowed to process its own event too if a valid
 +   handler exists for it.  Handler executions are always scheduled by
-+   the domain which raised the event for the prioritary domains
++   the domain which raised the event for the priority domains
 +   wanting to be notified of such event.  Note: evdata might be
 +   NULL. */
 +
@@ -5289,7 +5289,7 @@
 +	    next_domain->cpudata[cpuid].event_info.propagate = 0;
 +	    __set_bit(IPIPE_XPEND_FLAG,&next_domain->cpudata[cpuid].status);
 +
-+	    /* Let the prioritary domain process the event. */
++	    /* Let the priority domain process the event. */
 +	    __adeos_switch_to(this_domain,next_domain,cpuid);
 +	    
 +	    adeos_load_cpuid();	/* Processor might have changed. */

--------------000704060701050801050607--

