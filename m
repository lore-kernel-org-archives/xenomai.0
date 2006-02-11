Message-ID: <43ED3944.1040107@domain.hid>
Date: Fri, 10 Feb 2006 17:09:24 -0800
From: Max Krasnyansky <maxk@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Isolated CPU, SMI problems an thoughts
References: <43EBA31B.2020107@domain.hid>
In-Reply-To: <43EBA31B.2020107@domain.hid>
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
To: John Schipper <jschipper@domain.hid>
Cc: xenomai@xenomai.org

John Schipper wrote:
> Jan Kiszka wrote:
> 
>> John Schipper wrote:
>>  
>>
>>> Hello,
>>> I'm new to this list but have in the past used RTAI in a single
>>> processor off the shelf solution. I'm looking to switch to native
>>> Xenomai api but have a general problem...
>>> The problem is SMI on new systems, and other latency killers that
>>>   
>> What do you mean with "other" precisely?
>>  
>>
> I have seen on systems the need to disable USB Legacy/emulation? and 
> only use a PS/2 keyboard.  The USB interface (tied to a usb keyboard and 
> mouse) are standard on a Dell GX280 without a PS/2 interface.  I believe 
> and have seen real-time having problems.  This is due to to SMM mode, I 
> believe, being a latency killer (not sure if this is SMI related).
> 
> In regard to SMI I poked around the intel chips registers (sorry can't 
> remember what the GX280 chipset was but I could get it if important!  ) 
> and I found that their are lock bits that do not allow disabling global 
> SMI or the watchdog capability.  This was 6 months ago at least so I 
> have not tested the latest smi workaround module (in RTAI at least 
> because I have not use xenomai yet but plan too :) )

I'd say if you do the following:
	- Disable any kind of power management (BIOS, etc)
	- Enabled ACPI but _disable_ ACPI processor module
	- Enable and load USB hci drivers
	- Use "idle=poll"

You should see pretty good worst case latencies on your Dell machines.
Last thing (although not very friendly to power consumption) is pretty important
because what I found out (the hard way) is that ACPI based and MONITOR/MWAIT based
idle loops trigger SMM and introduce horrible latencies with some Intel chipsets
(I've seen it on IBM Z-Pro and HP Intel based lines).

>>> sometimes are not controllable by software always popping up when trying
>>> to migrate to a newer platform.  Can a dual core processor using
>>> isolcpus, preemp-rt and xenomai effectively future proof agains smi/chip
>>> set issues (specificly AMD or Intel dual core solutions) by isolating a
>>> cpu for exclusively xenomai/realtime use?
>>>   
>> SMI can only be addressed with CPU isolation if you are able to redirect
>> the related event only to one CPU. Don't know if this is possible / 
>> default.
Yeah I don't think it's possible. I chatted with HP BIOS folks a bit and they
didn't see any good solutions for that.

>> Using off the shelf standard systems is always risky. I've heard of a
>> larger German automation company ordering standard PC hardware for
>> industrial control purposes only when initial latency tests on a
>> specific charge were successful. Ok, they are ordering large enough
>> quantities, so they can dictate certain conditions...
> 
> Testing the system is done to verify latency and expected real-time 
> isolation from the normal linux tasks. Its done on a standard system and 
> once verified used until the system is no longer available which seems 
> to be happening at an increasing rate.  PCI express may be a reason, 
> maybe money.. but systems don't last much longer then a year and a 
> half.  Either way the motherboards themselves don't stay around to 
> long.  Our quantity is not there for the needed leverage with providers 
> :( .  The system is used for an industrial purpose which is NOT for a 
> life saving/risking situation.  Its used for simulation or simulator 
> purposes.

btw For what it's worth I can recommend HP9300 boxes. I worked with their
BIOS folks to resolve interrupt routing issues and stuff and now it's my
dream machine for RT stuff that requires loads of CPU compute power. The
box is has nice isolation features for example it has 1 PCIe slot that is
dedicated to CPU1 (ie on a separate bus). It's NUMA and so it has dedicated
memory banks per CPU. No shared interrupts, etc. You won't be able to run
Xenomai on it in native 64bit mode but 32bit mode should work.

Max

