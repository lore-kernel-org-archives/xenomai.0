Message-ID: <43159A7C.9020008@domain.hid>
Date: Wed, 31 Aug 2005 14:54:36 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090605010408070209040207"
Subject: [Adeos-main] PATCH: adeos handle_event losing events
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: rtai-dev@domain.hid, Philippe Gerum <rpm@xenomai.org>

This is a multi-part message in MIME format.
--------------090605010408070209040207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

While processing __adeos_handle_event enables interrupts for the ectual 
event handler periods. Interrupts might happen then and only logged for 
domains lower than the current domain in the __adeos_handle_event loop. 
The logged irqs would normally get replayed at the next real interrupt 
if the domain that caused the event was lower than the ones the 
interrupts were logged in or if it wasn't lower, at the next 
suspend_domain. On powersave-enabled ppc machines this might cause a 
chain where the cpu goes napping and wakes at the next timer tick which, 
having possibly been missed at *handle_event, happens after maximum 
decrementer period (~minutes).

The following patch seems to help in the described case, but I've also 
observed another case where interrupt seems to get dropped altogether. 
Performance didn't seem to suffer much from the patch. If anything, the 
latency/cruncher results got better. This is for the non-threaded 
domains case.

-- Heikki Lindholm

--------------090605010408070209040207
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="adeos-handle_event-p1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adeos-handle_event-p1.patch"

--- kernel/adeos.c.orig	2005-08-31 12:01:30.002707784 +0300
+++ kernel/adeos.c	2005-08-31 13:10:25.148070136 +0300
@@ -196,6 +196,7 @@
     adeos_declare_cpuid;
     adevinfo_t evinfo;
     int propagate = 1;
+    int notfirst = 0;
 
     adeos_lock_cpu(flags);
 
@@ -204,7 +205,20 @@
     list_for_each_safe(pos,npos,&__adeos_pipeline) {
 
     	next_domain = list_entry(pos,adomain_t,p_link);
-
+	/* did the previous unlock_cpu gap cause interrupts here? */
+	if (notfirst && next_domain != adp_root && !test_bit(IPIPE_STALL_FLAG,
+			&next_domain->cpudata[cpuid].status) &&
+			next_domain->cpudata[cpuid].irq_pending_hi != 0)
+		{
+		adp_cpu_current[cpuid] = next_domain;
+		__adeos_sync_stage(IPIPE_IRQMASK_ANY);
+		
+		if (adp_cpu_current[cpuid] != next_domain)
+			/* Something has changed the current domain under our
+			 * feet recycling the register set; take note. */
+			this_domain = adp_cpu_current[cpuid];
+		}
+	
 	if (next_domain->events[event].handler != NULL)
 	    {
 	    adp_cpu_current[cpuid] = next_domain;

--------------090605010408070209040207--

