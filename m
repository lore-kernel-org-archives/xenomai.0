From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <49EF0CFE.90405@domain.hid>
References: <49EF0CFE.90405@domain.hid>
Content-Type: text/plain
Date: Wed, 22 Apr 2009 18:23:04 +0200
Message-Id: <1240417384.6987.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] BUG on xnintr_attach
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Wed, 2009-04-22 at 14:26 +0200, Jan Kiszka wrote:
> Hi all,
> 
> issuing  rtdm_irq_request and, thus, xnintr_attach can trigger a
> "I-pipe: Detected stalled topmost domain, probably caused by a bug." if
> the interrupt type is MSI:
> 
>   [<ffffffff80273cce>] ipipe_check_context+0xe7/0xe9
>   [<ffffffff8049dae9>] _spin_lock_irqsave+0x18/0x54
>   [<ffffffff8037dcc2>] pci_bus_read_config_dword+0x3c/0x87
>   [<ffffffff80387c1d>] read_msi_msg+0x61/0xe1
>   [<ffffffff8021c5b8>] ? assign_irq_vector+0x3e/0x49
>   [<ffffffff8021d7b2>] set_msi_irq_affinity+0x6d/0xc8
>   [<ffffffff8021fa5d>] __ipipe_set_irq_affinity+0x6c/0x77
>   [<ffffffff80274231>] ipipe_set_irq_affinity+0x34/0x3d
>   [<ffffffff8027c572>] xnintr_attach+0xaa/0x11e
> 
> Two option to fix this, but I'm currently undecided which one to go:
>  - harden pci_lock (drivers/pci/access.c) - didn't we applied such a
>    MSI-related workaround before?

This did not work as expected: pathological latency spots. This said,
the vanilla code has evolved since I tried this quick hack months ago,
so it may be worth to look at this option once again.

>  - move xnarch_set_irq_affinity out of intrlock (but couldn't we face
>    even more pci_lock related issues?)
> 

Since upstream decided to use PCI config reads even inside hot paths
when processing MSI interrupts, the only sane way would be to make the
locking used there Adeos-aware, likely virtualizing the interrupt mask.
The way upstream generally deals with MSI is currently a problem for us.

> Jan
> 
-- 
Philippe.



