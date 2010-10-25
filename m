Message-ID: <4CC5AC7D.9090700@domain.hid>
Date: Mon, 25 Oct 2010 18:12:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Enabling classic MSI for real-time domains
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main <adeos-main@gna.org>, Xenomai core <Xenomai-core@domain.hid>

Hi,

for the past days, I had a look at the issue of classic MSIs (ie. not
MSI-X) under non-Linux I-pipe domains. Actually, the path that matters
most, IRQ delivery, is perfectly OK as is: just a simple ack on the APIC
and a NOP on completion.

Problematic are IRQ enable/disable (which automatically includes
setup/cleanup) and affinity updates. The point is that we specified at
least the first two services to be usable from RT context as well.
That's a nice-to-have with fast IRQ chips, but its a nightmare with
others. Classic MSI belongs to the latter category.

So we basically have two main options now, each having two variants:

 1) disallow IRQ enabled/disable over non-root contexts
    1a) confine this to certain IRQs like MSI or
    1b) make it a generic API property

 2) provide ipipe_irq_mask/unmask services and use them in Xenomai
    2a) for MSI, either to map them on a software mask or
    2b) to map them on MSI-specific services that bypass the ordinary
        [un]mask_msi_irq and use hardened ones (*)

I would prefer to go for the cheaper option 1), probably 1a) as we have
non-MSI users out there that do disable/enable trickery from RT
contexts. Unfortunately, also 1a) will require some new interface
between I-pipe and Xenomai to inform the user about the limited
usability of enable/disable and likely even enforce it at Xenomai level.

Comments, ideas?

Jan

(*) Previously posted patches to address the MSI issue by hardening both
pci_config_lock and pci_lock likely failed as the latter is of too broad
scope, including wake_up_all.

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

