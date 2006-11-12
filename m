From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 12 Nov 2006 22:03:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611122203.31192.niklaus.giger@domain.hid>
Subject: [Xenomai-core] r1827 seems to have broken PPC with vxworks skin
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi Philippe

Your commit 1827 "Make rthal_thread_switch() return the last current task 
pointer as expected by the vanilla switch code" seems to trigger a failure in 
my PPC405 vxworks setup.

See http://ngiger.dyndns.org/buildbot/hcu3_vx_q/builds/2/step-xenotest/0
where I got the following error on startup:

I-pipe: Domain Xenomai registered.
Xenomai: hal/powerpc started.
Xenomai: real-time nucleus v2.3-rc1 (Baroque) loaded.
Xenomai: starting native API services.
Xenomai: starting RTDM services.
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C0063384 LR: C0062168 SP: C02CBF50 REGS: c02cbea0 TRAP: 0300    Not 
tainted
MSR: 00021030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000004, DSISR: 00000000
TASK = c02c0b40[1] 'swapper' THREAD: c02ca000
Last syscall: 120 
GPR00: 00000001 C02CBF50 C02C0B40 00000000 00000000 C0328320 00000080 00000120 
GPR08: 00000000 00000000 C0328240 C022DF80 C0200000 00000000 01FFBB00 00000000 
GPR16: 01FFF7C8 FFFFFFFF 00000000 00800000 01FF595C 007FFF00 00200040 C01B0000 
GPR24: C02CBF98 C0230000 00000007 00000080 00008000 C0328324 C0328364 FFFFFFFF 
NIP [c0063384] vrtx_get_id+0x40/0x12c
LR [c0062168] sc_hcreate+0xa4/0x248
Call trace:
 [c0062168] sc_hcreate+0xa4/0x248
 [c006258c] vrtxheap_init+0x60/0xec
 [c0063264] __vrtx_skin_init+0x48/0xd4
 [c000245c] init+0x8c/0x254
 [c0005d0c] kernel_thread+0x44/0x60
Kernel panic - not syncing: Attempted to kill init!

As usual you may find the exact .config in
http://ngiger.dyndns.org/buildbot/hcu3_vx_q/builds/2/step-cfg_kernel/0

I am migrating my whole buildbot setup to use ELDK 4.0 as my cross-compile 
environment. xeno-test does not work yet as there are some differences 
between the denx environment and my old home made setup, which I could not 
yet resolve.

But this problem seems to be in a earlier state of the startup and I just 
wanted to inform you about it.

Best regards

-- 
Niklaus Giger

