Message-ID: <4AC62D0D.4000907@domain.hid>
Date: Fri, 02 Oct 2009 18:40:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4AC5E895.8010107@domain.hid> <1254490822.2703.310.camel@domain.hid>
	<4AC60AA9.5060209@domain.hid>
In-Reply-To: <4AC60AA9.5060209@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Freeze on SMP x86-64
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roman Pisl <rpisl@domain.hid>
Cc: xenomai@xenomai.org

Roman Pisl wrote:
> On 2.10.2009 15:40, Philippe Gerum wrote:
>> On Fri, 2009-10-02 at 13:48 +0200, Roman Pisl wrote:
>>> Hello,
>>> I just tried x86-64 SMP Linux/Xenomai on my workstation (Intel Core2
>>> Quad) but it freezes immediately after latency test or clocktest is
>>> started. It freezes even during the boot, when Xenomai debbuging is
>>> enabled.
>>>
>>> The same kernel binary runs seamlessly in KVM on the same machine.
>>>
>>> When I completely disable ACPI, the kernel recognizes only one CPU and
>>> the latency test works.
>>>
>>> The same configuration but for 32bit x86 also runs without freeze.
>>>
>>> Do you have any ideas?
>>>
>> Try disabling PM_TIMER.
>>
> 
> Do you mean CONFIG_X86_PM_TIMER? PM/ACPI probably requires this and as I 
> described before - without ACPI Linux brings up only one CPU, the 
> latency test works and doesn't freeze the machine.

No, PM does not require this. The only reason why PM_TIMER is called a
PM_TIMER is that it is a timer which continues to run independently on
the modes of the processor. The x86 local timers stop when the processor
is idle on some mahcines, this does not happen with the PM timer.


-- 
					    Gilles.

