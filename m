Message-ID: <43DE1DAD.8050302@domain.hid>
Date: Mon, 30 Jan 2006 15:07:41 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [BUG] Interrupt problem on powerpc
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

On a PrPMC800 (PPC 7410 processor) withe Xenomai-2.1-rc2, I get the following if 
the interrupt handler takes too long (i.e. next interrupt gets generated before 
the previous one has finished)

[   42.543765]  [c00c2008] spin_bug+0xa8/0xc4
[   42.597617]  [c00c22d4] _raw_spin_lock+0x180/0x184
[   42.660637]  [c000f388] __ipipe_ack_irq+0x88/0x130
[   42.723657]  [c000efe4] __ipipe_handle_irq+0x140/0x268
[   42.791259]  [c000f144] __ipipe_grab_irq+0x38/0xa4
[   42.854279]  [c0005058] __ipipe_ret_from_except+0x0/0xc
[   42.923029]  [00000000] 0x0
[   42.959695]  [c0038348] __do_IRQ+0x134/0x164
[   43.015839]  [c000ed04] __ipipe_do_IRQ+0x2c/0x44
[   43.076567]  [c000eb08] __ipipe_sync_stage+0x1ec/0x228
[   43.144170]  [c0039420] ipipe_suspend_domain+0x7c/0xc4
[   43.211774]  [c000f0b0] __ipipe_handle_irq+0x20c/0x268
[   43.279377]  [c000f144] __ipipe_grab_irq+0x38/0xa4
[   43.342396]  [c0005058] __ipipe_ret_from_except+0x0/0xc
[   43.411145]  [c0006524] default_idle+0x10/0x60


Any ideas of where to look?

Regards

Anders Blomdell



