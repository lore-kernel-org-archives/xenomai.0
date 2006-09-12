Message-ID: <45068DFE.3090408@domain.hid>
Date: Tue, 12 Sep 2006 12:37:50 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] No hardware interrupts with xenomai on ppc405
References: <4503EB88.2040309@domain.hid>
	<200609111904.16512.matthias.fuchs@domain.hid>
	<4505A75B.8000601@domain.hid>
	<200609120932.20196.matthias.fuchs@domain.hid>
In-Reply-To: <200609120932.20196.matthias.fuchs@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Matthias Fuchs <matthias.fuchs@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Matthias Fuchs wrote:
> On Monday 11 September 2006 20:13, Wolfgang Grandegger wrote:
>> In 2.6 the interrupts are disabled by default. Then the attached patch 
>> for Xenomai should help.
>>
>> Wolfgang.
>>
> Your patch also works fine. Now what's the recommended solution? I noticed 
> that Philippe already checked in an Adeos fix.

As mentioned, in Linux 2.6 (generic IRQ layer), IRQs are disabled by 
default in kernel/irq/handle.c:

   irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
         [0 ... NR_IRQS-1] = {
                 .status = IRQ_DISABLED,
                 .handler = &no_irq_type,
                 .lock = SPIN_LOCK_UNLOCKED
         }
   };

Till now, I haven't found IPIPE/Xenomai related code removing the 
IRQ_DISABLED bit. But I wonder why it's working for x86. Maybe I have 
missed something.

In Linux 2.4, the "status" field is initialized to 0 (in 
arch/ppc/kernel/irq.c) not making trouble:

   irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
         { [0 ... NR_IRQS-1] = { 0, NULL, NULL, 0, SPIN_LOCK_UNLOCKED}};

At least my CAN PCI card on a MPC5200 works fine.

Philippe, do we really need these ugly PIC patches?

Wolfgang.

