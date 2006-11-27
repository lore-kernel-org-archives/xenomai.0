Message-ID: <456ACA35.8030206@domain.hid>
Date: Mon, 27 Nov 2006 12:21:25 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Adeos support for 2.6.18 merged PowerPC
	architecture.
References: <20061124105346.e442448d.benjamin.zores@domain.hid>	<4566C5AF.7030107@domain.hid>	<20061124113009.08c0a490.benjamin.zores@domain.hid>	<4569E699.6050003@domain.hid>
	<20061127092143.e633cd91.benjamin.zores@domain.hid>
In-Reply-To: <20061127092143.e633cd91.benjamin.zores@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Benjamin Zores <benjamin.zores@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Benjamin Zores wrote:
> On Sun, 26 Nov 2006 20:10:17 +0100
> Wolfgang Grandegger <wg@domain.hid> wrote:
> 
>> - NR_IRQS is not defined. This is a problem with the include weirdness 
>> due to radix-tree.h, IIRC. It is set to 512 for all PowerPC archs, puh, 
>> that's overkill (but not our problem for the time being).
> 
> Indeed it seemed so.
> On my private tree, i've fixed/redefined it to 512 to have it compile
> (ugly hack though).

Yes, beause you need "irq.h" sooner than later in IPIPE files.

>> _ipipe_grab_irq(): special IRQ numbers have changed. Check for 
>> NO_IRQ_IGNORE in the attached patch. Also the new IRQ handling needs a 
>> more detailed review (check irq.c in the powerpc tree).
>>
>> - disarm_decr[] has disappeared. It was used to disable the programming 
>> of the decrementer in arch/ppc/kernel/time.c:timer_interrupt(). It needs 
>> an appropriate replacement in the powerpc tree. A quick, untested hack 
>> is in the attached patch.
> 
> I'll try to check on that.
> 
>> Hope this helps you to get a bit further (kernel booted).
> 
> Well, I hack a bit my patch to make it compile and the kernel already booted.
> Though it hangs when loading the SATA driver.
> I have no idea why atm.

Problems with IRQs?

Wolfgang.

