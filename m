Message-ID: <43F220D7.6040705@domain.hid>
Date: Tue, 14 Feb 2006 19:26:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
References: <fd6a47a90602140744lc1d4365q@domain.hid>	<43F21867.8070002@domain.hid>
	<fd6a47a90602141007g7830d31fu@domain.hid>
	<43F21ED7.3030501@domain.hid>
In-Reply-To: <43F21ED7.3030501@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jeroen Van den Keybus wrote:
> 
>>One moment. I'm trying to locate rthal_disable_irq()...
>>
>>
>>
>>>Does calling rthal_disable_irq() instead of returning RTDM_IRQ_ENABLE, but
>>>rather
>>>0, prevents the freeze?
>>>
> 
> 
> Disable or enable (I guess the latter one)?
> 
> In either case, there are equivalent wrappers in RTDM:
> rtdm_irq_enable/disable.
>

disable. I suspect an IRQ storm due to some bad eoi/acknowledge at Adeos level.

> Jan
> 


-- 

Philippe.

