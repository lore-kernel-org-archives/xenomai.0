Message-ID: <b054e88e0711290957v17aac9b1vf30cd76c171bc1ac@domain.hid>
Date: Thu, 29 Nov 2007 18:57:38 +0100
From: "Giammarco Zacheo" <g.zacheo@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-core] BUG while modprobing nucleus - no SMI workaround
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Just installed kernel 2.6.23.9 with Xenomai 2.4-rc7 on my quad-core
machine, and I got this on the console:

BUG: using smp_processor_id() in preemptible [00000001] code: modprobe/4776
caller is flat_send_IPI_allbutself+0x17/0x32

Call Trace:
 [<ffffffff80319796>] debug_smp_processor_id+0xde/0xec
 [<ffffffff80219fb5>] flat_send_IPI_allbutself+0x17/0x32
 [<ffffffff8021651a>] ipipe_critical_enter+0x84/0xaf
 [<ffffffff80253239>] ipipe_register_domain+0x65/0x225
 [<ffffffff8025387e>] rthal_init+0x164/0x1fd
 [<ffffffff803da4e7>] rthal_domain_entry+0x0/0x3d
 [<ffffffff88103059>] :xeno_nucleus:__xeno_sys_init+0x3e/0x1d4
 [<ffffffff8024bfb2>] sys_init_module+0x1565/0x16c5
 [<ffffffff8020b482>] system_call+0x92/0x97

BUG: using smp_processor_id() in preemptible [00000001] code: modprobe/4776
caller is flat_send_IPI_allbutself+0x17/0x32

Call Trace:
 [<ffffffff80319796>] debug_smp_processor_id+0xde/0xec
 [<ffffffff80219fb5>] flat_send_IPI_allbutself+0x17/0x32
 [<ffffffff802ac2d4>] create_proc_entry+0x73/0x8a
 [<ffffffff8021651a>] ipipe_critical_enter+0x84/0xaf
 [<ffffffff802532e6>] ipipe_register_domain+0x112/0x225
 [<ffffffff8025387e>] rthal_init+0x164/0x1fd
 [<ffffffff803da4e7>] rthal_domain_entry+0x0/0x3d
 [<ffffffff88103059>] :xeno_nucleus:__xeno_sys_init+0x3e/0x1d4
 [<ffffffff8024bfb2>] sys_init_module+0x1565/0x16c5
 [<ffffffff8020b482>] system_call+0x92/0x97

I-pipe: Domain Xenomai registered.
Xenomai: hal/x86_64 started.
Xenomai: real-time nucleus v2.4-rc7 (Bells Of Lal) loaded.
Xenomai: SMI-enabled chipset found
Xenomai: SMI workaround failed!
Xenomai: starting native API services.
Xenomai: starting RTDM services.

if you need my .config file, let me know

Giammarco

