Message-ID: <45B083A0.5020908@domain.hid>
Date: Fri, 19 Jan 2007 09:38:56 +0100
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] irq conflict
References: <45ADEDDC.5060407@domain.hid> <45AEA9A7.7000001@domain.hid>
	<45AFC392.5050705@domain.hid> <45AFD3E2.8090200@domain.hid>
In-Reply-To: <45AFD3E2.8090200@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

Jan Kiszka wrote:
> Theo Veenker wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Theo Veenker wrote:
>>>
>>>>Hi all,
>>>>
>>>>I need to run xenomai on a HP Compaq nc6320. I use kernel 2.6.17.14
>>>>and xenomai 2.2.5. The non-realtime kernel runs fine on this laptop,
>>>
>>>Means the same kernel with I-pipe (and Xenomai) disabled or the same
>>>kernel version and .config, but unpatched?
>>
>>The latter.
>>
>>
>>>>but the xenomai pactched kernel gives several of these messages:
>>>>
>>>>  IRQ routing conflict for xxxx.xx.xx.x, have irq 11, want irq 10
>>>>
>>>>And some things (e.g. mouse, network) then don't work, not properly
>>>>anyway. The same kernel runs fine however on other systems.
>>>>
>>>>Any clue what I can do about it?
>>>
>>>Please provide bootlogs for both rt and non-rt kernel startup. And
> 
> the
> 
>>>.config.
>>
>>I 'solved' it by enabling ACPI (without processor module and others).
>>Looks good. I don't see high latencies with the latency test. Under
>>what conditions might ACPI affect real-time behaviour?
> 
> 
> CONFIG_ACPI_PROCESSOR, because it allows deep sleep states with
> significant wakeup latencies.
> 
> But back to your original issue: You mean your notebook booted fine
> under vanilla Linux with ACPI disabled? That would mean I-pipe relies on
> ACPI here without stating this anywhere. In that case /something/ needs
> fixing: code, config deps, or doc.

Just tried that. Things don't work (properly) with acpi=off (jumpy mouse,
no network, sound loops). I tried the ubuntu 6.06 2.6.15-23-386 kernel,
a vanilla 2.6.17.14 kernel and a xenomai patched 2.6.17.14 kernel. All
with same result. So that's reassuring I guess.

I recently converted my stuff from RTLinux to Xenomai and just assumed it
would be saver to turn off ACPI for real-time operation. Didn't know some
systems actually rely on ACPI.

> 
> Jan
> 
> 
> PS: Please take care to not drop the list from CC.

I'm sorry. The mistake occurred to me the moment I clicked send.

Theo



