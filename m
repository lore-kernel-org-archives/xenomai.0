Message-ID: <4315B4C7.6090109@domain.hid>
Date: Wed, 31 Aug 2005 16:46:47 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] PATCH: adeos handle_event losing events *corrected*
References: <43159A7C.9020008@domain.hid>
	<20050831143501.8lgyxa05c4o0wgco@domain.hid>
In-Reply-To: <20050831143501.8lgyxa05c4o0wgco@domain.hid>
Content-Type: multipart/mixed; boundary="------------090807060803060604020503"
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org, rtai-dev@domain.hid

This is a multi-part message in MIME format.
--------------090807060803060604020503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Philippe Gerum kirjoitti:
> Quoting Heikki Lindholm <holindho@domain.hid>:
> 
>> Hello,
>>
>> While processing __adeos_handle_event enables interrupts for the 
>> ectual event handler periods. Interrupts might happen then and only 
>> logged for domains lower than the current domain in the 
>> __adeos_handle_event loop. The logged irqs would normally get replayed 
>> at the next real interrupt if the domain that caused the event was 
>> lower than the ones the interrupts were logged in or if it wasn't 
>> lower, at the next suspend_domain. On powersave-enabled ppc machines 
>> this might cause a chain where the cpu goes napping and wakes at the 
>> next timer tick which, having possibly been missed at *handle_event, 
>> happens after maximum decrementer period (~minutes).
>>
>> The following patch seems to help in the described case, but I've also 
>> observed another case where interrupt seems to get dropped altogether. 
>> Performance didn't seem to suffer much from the patch. If anything, 
>> the latency/cruncher results got better. This is for the non-threaded 
>> domains case.
> 
> 
> Good spot, thanks. I'd also suggest a different implementation to solve 
> this,
> still in adeos_handle_event() though:
> 
> - you only need to sync the next domain when it does not handle the current
> event; if it does, then it would suspend calling adeos_suspend_domain() 
> when
> the event is processed, hence switching to the next domain down the 
> pipeline
> that has IRQs to process anyway. Additionally, I don't see how notfirst 
> goes
> non-zero in this patch, and why we'd need to make some exception case 
> for the
> root domain (i.e. you may have domains below it down the pipeline).

GRRRRrr! I failed to incorporate that one "notfirst" line from my 
debug-tree to the CVS tree. No wonder it didn't work there anymore - I 
was banging my head to the wall in vain! Thinking that over again, I 
can't think why would the root domain *need* to be excluded, it just 
seemed to save some work in the "normal" fusion case where most events 
get propagated to root, which caused them anyway.

> - in the !threaded case, calling __adeos_switch_to() instead of changing 
> the
> domain descriptor by hand then syncing the stage would be better, since it
> would perform all the additional housekeeping chores, like calling the 
> switch
> hook and resetting the current descriptor pointer.

Yes. A little more work, but looks neater.

Anyway, here's a corrected version.

-- Heikki Lindholm

--------------090807060803060604020503
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="adeos-handle_event-p2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adeos-handle_event-p2.patch"

--- kernel/adeos.c.orig	2005-08-31 12:01:30.002707784 +0300
+++ kernel/adeos.c	2005-08-31 16:33:06.496264192 +0300
@@ -196,6 +196,7 @@
     adeos_declare_cpuid;
     adevinfo_t evinfo;
     int propagate = 1;
+    int notfirst = 0;
 
     adeos_lock_cpu(flags);
 
@@ -204,11 +205,21 @@
     list_for_each_safe(pos,npos,&__adeos_pipeline) {
 
     	next_domain = list_entry(pos,adomain_t,p_link);
-
+	/* did the previous unlock_cpu gap cause interrupts here? */
+	if (notfirst && !test_bit(IPIPE_STALL_FLAG,
+			&next_domain->cpudata[cpuid].status) &&
+			next_domain->cpudata[cpuid].irq_pending_hi != 0)
+		{
+		__adeos_switch_to(this_domain,next_domain,cpuid);
+		/* in case the domain was changed */
+		this_domain = adp_cpu_current[cpuid]; 
+		}
+	
 	if (next_domain->events[event].handler != NULL)
 	    {
 	    adp_cpu_current[cpuid] = next_domain;
 	    evinfo.domid = start_domain->domid;
+	    notfirst = 1;
 	    adeos_unlock_cpu(flags);
 	    evinfo.event = event;
 	    evinfo.evdata = evdata;

--------------090807060803060604020503--

