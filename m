Message-ID: <4896D85D.2010004@domain.hid>
Date: Mon, 04 Aug 2008 12:22:21 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <001b01c8f600$0c5a5a60$09201fac@domain.hid>
	<4896B492.4000404@domain.hid>
	<005b01c8f615$db466930$09201fac@domain.hid>
	<4896D6CC.1040103@domain.hid>
In-Reply-To: <4896D6CC.1040103@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Buffer over flow in /proc/xenomai/stat
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Atsushi Katagiri <a-katagiri@domain.hid>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Atsushi-san,
> 
> Atsushi Katagiri wrote:
>> Yes, I actually encountered this bug and my Linux was crashed by NULL pointer dereference.
>>
>> I think this is a very simple bug.
>> It happens "everytime" we open /proc/xenomai/stat,
>> because the last iter->nentries++; (line 466) surely reaches the value of the count,
>> and the next iteration, line 449, surely overwrites zero on out of the kmalloced area.
>>
> 
> Please try this fix instead:
>

Actually, this one is better:

--- ksrc/nucleus/module.c	(revision 4074)
+++ ksrc/nucleus/module.c	(working copy)
@@ -440,13 +440,13 @@
 	/* Iterate over all IRQ numbers, ... */
 	for (irq = 0; irq < XNARCH_NR_IRQS; irq++) {
 		xnintr_t *prev = NULL;
-		int cpu = 0;
+		int cpu = 0, _cpu;
 		int err;

 		/* ...over all shared IRQs on all CPUs */
 		while (1) {
 			stat_info = &iter->stat_info[iter->nentries];
-			stat_info->cpu = cpu;
+			_cpu = cpu;

 			err = xnintr_query(irq, &cpu, &prev, intr_rev,
 					   stat_info->name,
@@ -458,6 +458,7 @@
 			if (err)
 				break; /* line unused or end of chain */

+			stat_info->cpu = _cpu;
 			stat_info->pid = 0;
 			stat_info->state =  0;
 			stat_info->ssw = 0;

-- 
Philippe.

