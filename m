Message-ID: <47388CA0.6070405@domain.hid>
Date: Mon, 12 Nov 2007 18:25:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <fd6a47a90711120739n11b803cfy8bc4b8b09a995fef@domain.hid>	
	<4738839E.8020203@domain.hid>
	<fd6a47a90711120911q34d2fba5w22683bd06598b150@domain.hid>
In-Reply-To: <fd6a47a90711120911q34d2fba5w22683bd06598b150@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

Jeroen Van den Keybus wrote:
>> So, unless the IRQ below
>> should have been raised much earlier, there is no issue here.
> 
> 
> The point is: I actually do have interrupts (not the IPI that is visible
> here) that are being withheld (on average 80 us late) during this period. On
> this particular setup, I have seen numbers exceeding 300 us. Strangely
> enough, the latency test does not show these hiccups. I'm suspecting cache
> issues, but I would think these numbers are a bit large for that.

Indeed, 300 us are too long. Maybe long DMA bursts on your PCI bus? Can
you exclude certain devices from your load to check for this (no hardisk
load e.g., use nfs instead, then no network load, etc.)?

> 
> What you say is that between tracepoint 0x27 and 0x29, we may have entered
> userland. But where does this happen, given that point 0x28 is not executed
> ?

Nope, user land is entered _after_ 0x29 (you need to read the numbers
with an offset of one: the delay is between
__ipipe_unstall_iret_root+0xb6 and _ipipe_handle_irq+0xe).

> 
> I also do understand that, if a cli or sti would still lurk somewhere in
> this configuration, I'm going to have a real bad time... Although I doubt
> it, since the unexpected latencies always happen at this particular point.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

