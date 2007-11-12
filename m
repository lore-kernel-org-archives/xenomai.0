Message-ID: <4738945D.2030503@domain.hid>
Date: Mon, 12 Nov 2007 18:58:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <fd6a47a90711120739n11b803cfy8bc4b8b09a995fef@domain.hid>	
	<4738839E.8020203@domain.hid>	
	<fd6a47a90711120911q34d2fba5w22683bd06598b150@domain.hid>	
	<47388CA0.6070405@domain.hid>
	<fd6a47a90711120936m6c8eb691na49fae868b803470@domain.hid>
In-Reply-To: <fd6a47a90711120936m6c8eb691na49fae868b803470@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Long execution time inside
	__ipipe_unstall_iret_root()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: Xenomai-core@domain.hid

[Save the CCs!]

Jeroen Van den Keybus wrote:
>> Indeed, 300 us are too long. Maybe long DMA bursts on your PCI bus? Can
>> you exclude certain devices from your load to check for this (no hardisk
>> load e.g., use nfs instead, then no network load, etc.)?
> 
> 
> I already tried setting PCI latency timers of everything except my card to
> e.g. 0x08. No difference though.
> 
>>> What you say is that between tracepoint 0x27 and 0x29, we may have
>> entered
>>> userland. But where does this happen, given that point 0x28 is not
>> executed
>>> ?
>> Nope, user land is entered _after_ 0x29 (you need to read the numbers
>> with an offset of one: the delay is between
>> __ipipe_unstall_iret_root+0xb6 and _ipipe_handle_irq+0xe).
> 
> 
> Ah!  Now I see. So basically I would have some user space code that is doing
> something that would delay my interrupts considerably, irrespective of the
> fact that IRQs are enabled.
> 
> I once tried a WBINVD in a user space task and it has a really devastating
> effect on RT (basically locks the CPU for 200us). If there was a way of
> preventing this kind of instructions...
> 

Ouch, this shouldn't be allowed in user space! WBINVD is a privileged
instruction. Do we leak privileges to user land??? Please check if your
execution mode (privilege ring) is correct there.

But indeed, wbinvd is devastating if you can execute it, causing
typically around 300 us latencies, at worst even milliseconds
(cache-size and state dependent)!

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

