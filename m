Message-ID: <475C120F.9020107@domain.hid>
Date: Sun, 09 Dec 2007 17:04:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b054e88e0711290957v17aac9b1vf30cd76c171bc1ac@domain.hid>
In-Reply-To: <b054e88e0711290957v17aac9b1vf30cd76c171bc1ac@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] BUG while modprobing nucleus - no SMI workaround
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Giammarco Zacheo <g.zacheo@domain.hid>
Cc: xenomai@xenomai.org

Giammarco Zacheo wrote:
> Just installed kernel 2.6.23.9 with Xenomai 2.4-rc7 on my quad-core
> machine, and I got this on the console:
> 
> BUG: using smp_processor_id() in preemptible [00000001] code: modprobe/4776
> caller is flat_send_IPI_allbutself+0x17/0x32
> 
> Call Trace:
>  [<ffffffff80319796>] debug_smp_processor_id+0xde/0xec
>  [<ffffffff80219fb5>] flat_send_IPI_allbutself+0x17/0x32
>  [<ffffffff8021651a>] ipipe_critical_enter+0x84/0xaf
>  [<ffffffff80253239>] ipipe_register_domain+0x65/0x225
>  [<ffffffff8025387e>] rthal_init+0x164/0x1fd
>  [<ffffffff803da4e7>] rthal_domain_entry+0x0/0x3d
>  [<ffffffff88103059>] :xeno_nucleus:__xeno_sys_init+0x3e/0x1d4
>  [<ffffffff8024bfb2>] sys_init_module+0x1565/0x16c5
>  [<ffffffff8020b482>] system_call+0x92/0x97

Looks like a harmless false positive. Does this patch help?

Index: linux-2.6.23.8-xeno_64/lib/smp_processor_id.c
===================================================================
--- linux-2.6.23.8-xeno_64.orig/lib/smp_processor_id.c
+++ linux-2.6.23.8-xeno_64/lib/smp_processor_id.c
@@ -19,7 +19,7 @@ unsigned int debug_smp_processor_id(void
 	if (likely(preempt_count))
 		goto out;

-	if (irqs_disabled())
+	if (irqs_disabled() || irqs_disabled_hw())
 		goto out;

 	/*

Jan

