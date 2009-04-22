Message-ID: <49EF0CFE.90405@domain.hid>
Date: Wed, 22 Apr 2009 14:26:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] BUG on xnintr_attach
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

Hi all,

issuing  rtdm_irq_request and, thus, xnintr_attach can trigger a
"I-pipe: Detected stalled topmost domain, probably caused by a bug." if
the interrupt type is MSI:

  [<ffffffff80273cce>] ipipe_check_context+0xe7/0xe9
  [<ffffffff8049dae9>] _spin_lock_irqsave+0x18/0x54
  [<ffffffff8037dcc2>] pci_bus_read_config_dword+0x3c/0x87
  [<ffffffff80387c1d>] read_msi_msg+0x61/0xe1
  [<ffffffff8021c5b8>] ? assign_irq_vector+0x3e/0x49
  [<ffffffff8021d7b2>] set_msi_irq_affinity+0x6d/0xc8
  [<ffffffff8021fa5d>] __ipipe_set_irq_affinity+0x6c/0x77
  [<ffffffff80274231>] ipipe_set_irq_affinity+0x34/0x3d
  [<ffffffff8027c572>] xnintr_attach+0xaa/0x11e

Two option to fix this, but I'm currently undecided which one to go:
 - harden pci_lock (drivers/pci/access.c) - didn't we applied such a
   MSI-related workaround before?
 - move xnarch_set_irq_affinity out of intrlock (but couldn't we face
   even more pci_lock related issues?)

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

