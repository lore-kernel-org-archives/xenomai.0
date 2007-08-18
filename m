Message-ID: <46C6DE76.1010609@domain.hid>
Date: Sat, 18 Aug 2007 13:56:38 +0200
MIME-Version: 1.0
References: <46C5AC8F.8010708@domain.hid> <46C5B38E.70200@domain.hid>
	<46C5FF29.3050004@domain.hid> <46C69308.9080707@domain.hid>
In-Reply-To: <46C69308.9080707@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] [RTnet-users] system freezes on calling
Reply-To: rolandtollenaar@domain.hid
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
Cc: Xenomai-help@domain.hid, rtnet-users <rtnet-users@domain.hid>

hi,

To all those finished packing more boxes..:)

problem solved. You were right, seemingly an irq conflict.

But I would like to learn something. What solved the problem in the end 
was a BIOS setting whereby for PCI slot 3 (the slot I had the card in) 
the IRQ PRIORITY was set to "Auto".

I selected "3" for the IRQ priority (top of the list and I was in 
trial-&-Error mode) which sorted the problem.

Now what IRQ numbers are used by rtnet, what is the irq "priority" and 
why-oh-why would the PC generate a conflict of its own accord if left to 
select the IRQ priority automatically?

This will help me understand such issues in the future.

TiA

Kind regards,

Roland

Jan Kiszka wrote:
> Roland Tollenaar wrote:
>> Hi,
>>
>> I have bought a new machine. Similar problem. Even running from USB
>> which works on the other machines. The moment rtnet gets started I can
>> only take the power off the machine and restart like that.
>>
>>
>> /usr/local/rtnet/sbin/rtifconfig rteth0 up
>>
>> So to summarize:
>>
>> xenomai kernel seems stable can do everything. Can load peakCAN driver
>> and run my application without rtnet. The moment I start rtnet with
>> above command, the system freezes.
>>
>> rtnet will NOT run on this new system.
>>
>> I sincerely hope there are some suggestions, this is becoming a
>> nightmare :(
> 
> - try a different PCI slot for the NIC (-> different IRQ)
> - try a different NIC adapter (-> different driver)
> - linux/Documentation/serial-console.txt
> - CONFIG_XENO_OPT_WATCHDOG
> - CONFIG_XENO_HW_NMI_DEBUG_LATENCY
> 
> Jan (who's off for packing more boxes...)
> 

