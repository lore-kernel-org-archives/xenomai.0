Message-ID: <4551D859.5070509@domain.hid>
Date: Wed, 08 Nov 2006 14:15:05 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai on Athlon XP (and PIII)
References: <4550E7A6.9090408@domain.hid> <45518795.5070507@domain.hid>
	<4551A02A.7090503@domain.hid>
	<4551B5D7.1030505@domain.hid> <4551D531.8000501@domain.hid>
In-Reply-To: <4551D531.8000501@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Wolfgang Grandegger wrote:
>>>>
>>>>> Hello,
>>>>>
>>>>> I'm currently setting up a PC for Xenomai-Tests. I'm using my good old
>>>>> PC with an Athlon XP (Thunderbird) for this purpose. The kernel
>>>>> hangs at
>>>>> boot time when I enable APIC via boot argument (lapic). With local APIC
>>>>> disabled the kernel boots but I see some Opps messages while running
>>>>> the
>>>>> latency test and trying a slogin to the system (in the scheduler). Are
>>>>> there any known issues with this X86 arch? I remember, that I have seen
>>>>> similar problems with my (old) PIII-Notebook (lapic did not work).
>>>>
>>>> No known issues, both scenarios *must* work, the P-III at least in PIC
>>>> mode when Linux refuses to enabled lapic on boot.
>>> Some athlons have a buggy local APIC, so disabling it may be the best
>>> option.
>> Ah, I found some similar statement on the RTAI mailing list as well.
> 
> Still, it must neither oops nor hang in this case - or does plain Linux
> so as well?

On my Athlon, plain Linux boots and runs with the boot argument "lapic" 
and reports that APIC is enabled, but I'm don't know if it's used. With 
Xenomai in the kernel and "lapic" the kernel hangs shortly after the 
Xenomai services have been successfully enabled. The Oops happened with 
local APIC _disabled_ but I cannot reproduce it today. Likely a "make 
clean" helped. And with the PIII, I just remembered that I had similar 
problems half a year ago. Sorry for confusion. I have now a Xenomai test 
PC up and running and was already able to test the PEAK CAN dongle :-). 
The latency test reports latencies around 15..20us, which looks good.

Thanks.

Wolfgang.

