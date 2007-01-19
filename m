Message-ID: <45B086B1.3060105@domain.hid>
Date: Fri, 19 Jan 2007 09:52:01 +0100
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] irq conflict
References: <45ADEDDC.5060407@domain.hid> <45AEA9A7.7000001@domain.hid>	
	<45AFC392.5050705@domain.hid> <45AFD3E2.8090200@domain.hid>
	<1169152829.25556.25.camel@domain.hid>
In-Reply-To: <1169152829.25556.25.camel@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

Philippe Gerum wrote:
> On Thu, 2007-01-18 at 21:09 +0100, Jan Kiszka wrote:
> 
>>Theo Veenker wrote:
>>
>>>Jan Kiszka wrote:
>>>
>>>>Theo Veenker wrote:
>>>>
>>>>>Hi all,
>>>>>
>>>>>I need to run xenomai on a HP Compaq nc6320. I use kernel 2.6.17.14
>>>>>and xenomai 2.2.5. The non-realtime kernel runs fine on this laptop,
>>>>
>>>>Means the same kernel with I-pipe (and Xenomai) disabled or the same
>>>>kernel version and .config, but unpatched?
>>>
>>>The latter.
>>>
>>>
>>>>>but the xenomai pactched kernel gives several of these messages:
>>>>>
>>>>>  IRQ routing conflict for xxxx.xx.xx.x, have irq 11, want irq 10
>>>>>
>>>>>And some things (e.g. mouse, network) then don't work, not properly
>>>>>anyway. The same kernel runs fine however on other systems.
>>>>>
>>>>>Any clue what I can do about it?
>>>>
>>>>Please provide bootlogs for both rt and non-rt kernel startup. And the
>>>>.config.
>>>
>>>I 'solved' it by enabling ACPI (without processor module and others).
>>>Looks good. I don't see high latencies with the latency test. Under
>>>what conditions might ACPI affect real-time behaviour?
>>
>>CONFIG_ACPI_PROCESSOR, because it allows deep sleep states with
>>significant wakeup latencies.
>>
>>But back to your original issue: You mean your notebook booted fine
>>under vanilla Linux with ACPI disabled? That would mean I-pipe relies on
>>ACPI here without stating this anywhere. In that case /something/ needs
>>fixing: code, config deps, or doc.
>>
> 
> 
> It doesn't, at least, not willingly. Before drawing any conclusion,
> please try 2.6.19 with the same configuration first: the generic irq
> layer may have had a positive influence on the I-pipe in this area.

I'd love to try it, but there is no 2.6.19 patch for 2.2.5. When 2.3
was released I tried using that, but failed (unable to load the posix
module or something I don't remember exactly). Since I had only a few
days to convert all our systems (for language and speech research)
from RTLinux to Xenomai I decided to stay at 2.2.5 until quieter
times. Hope to figure it out soon.

Theo



