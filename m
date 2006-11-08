Message-ID: <4551B5D7.1030505@domain.hid>
Date: Wed, 08 Nov 2006 11:47:51 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai on Athlon XP (and PIII)
References: <4550E7A6.9090408@domain.hid> <45518795.5070507@domain.hid>
	<4551A02A.7090503@domain.hid>
In-Reply-To: <4551A02A.7090503@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>
>>> Hello,
>>>
>>> I'm currently setting up a PC for Xenomai-Tests. I'm using my good old
>>> PC with an Athlon XP (Thunderbird) for this purpose. The kernel hangs at
>>> boot time when I enable APIC via boot argument (lapic). With local APIC
>>> disabled the kernel boots but I see some Opps messages while running the
>>> latency test and trying a slogin to the system (in the scheduler). Are
>>> there any known issues with this X86 arch? I remember, that I have seen
>>> similar problems with my (old) PIII-Notebook (lapic did not work).
>>
>>
>> No known issues, both scenarios *must* work, the P-III at least in PIC
>> mode when Linux refuses to enabled lapic on boot.
> 
> Some athlons have a buggy local APIC, so disabling it may be the best
> option.

Ah, I found some similar statement on the RTAI mailing list as well.

Thanks for the info.

Wolfgang.


