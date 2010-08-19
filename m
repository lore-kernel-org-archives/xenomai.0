Message-ID: <4C6D1213.5010104@domain.hid>
Date: Thu, 19 Aug 2010 13:14:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=2kNE2KznfnY0voTbWMFqy5_LESXswjJ25O-hk@domain.hid>	<4C6C019D.1040406@domain.hid>	<AANLkTi=uuzsAsgt8mk04VJE0-tmd1YQ5KoiTu3a-dO3v@domain.hid>	<4C6CE4E0.1000609@domain.hid>
	<AANLkTimS-p0OWzrhuwuLwN27hUvQqTML8B-YALRwLuxz@domain.hid>
In-Reply-To: <AANLkTimS-p0OWzrhuwuLwN27hUvQqTML8B-YALRwLuxz@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Timing calculation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Prakash A S <asprakash83@domain.hid>
Cc: xenomai@xenomai.org

Prakash A S wrote:
> On Thu, Aug 19, 2010 at 1:31 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> Prakash A S wrote:
>>> On Wed, Aug 18, 2010 at 9:21 PM, Gilles Chanteperdrix <
>>>> We still receive HTML.
>>>>
>>> May be because of simply copy and pasted the old content in the last
>> thread.
>>> How about the scenario now?.
>> Nope. Still multipart/alternative with HTML.
>>
> 
> Sorry, I have no clue why its happening.
> 
> 
> 
>>>
>>>>> Obviously I should improve my C language skills.
>>>>>
>>>>> I am using linux kernel 2.6.30.8 on Ubuntu 8.04,
>>>>> Adeos-ipipe-2.6.30.8-x86-2.4-09.patch and Xenomai-2.5.3
>>>> What about the kernel configuration and self-contained test exhibiting
>>>> the behaviour you do not understand?
>>>>
>>> My .config file is here, http://pastebin.ca/1919917
>> This .config is wrong: it has ACPI disabled.
>>
>>
> I will enabled the ACPI, recompile the kernel and get back to you later.
> 
> 
>>> I tested and understand few test cases below.
>>> switchtest : I am using Intel Dual core processor. ~5731 context switches
>>> happening in a second
>>> cyclictest : Tested with 10 threads. Maximum timer latency is 38us and
>>> minimum is 1us
>>> clocktest : Simply prints the time offset, drift value and wraps compare
>>> with normal linux's gettimeofday(). Not much understand from this test.
>>> latency : user mode latency test provides maximum latency time is 15us.
>>> latency : kernel mode latency test provides maximum latency time is 3.6
>> us
>>> latency : timer mode latency test provides maximum latency time is 3 us
>> So, timing works correctly. If there was something wrong with time
>> keeping, you would have seen latency and switchtest drifting, and
>> printing infinitely increasing or decreasing latencies.
>>
> 
> Valuable information.

Well, not really, just common sense.

>>> Not much understand about the clocktest.
>>> More helpful if we have any documentations for the all tests rather than
>> how
>>> to use the tests.
>> The fact that ACPI must be enabled is documented, though you disabled
>> it, which proves that you do not read the documentation.
>>
> 
> Let me know which document you are talking about?.

It was repeated many times on this mailing list. Every time someone asks
about how to configure Xenomai on x86. Because a lot of people are doing
this error.

The document is:
http://www.xenomai.org/index.php/FAQs#Which_kernel_settings_should_be_avoided.3F

Which says to disable ACPI_PROCESSOR, not ACPI.

> From the beginners point of view, he/she is trying to install a software
> successfully first and not to worry about the performance scale at initial
> stage. In the kernel compilation part disabling power management option is
> one of the usual step followed by the beginners. I did the same and later,
> forgot that its an important factor.

If the beginner is not worried about performances, then it does not have
to disable power management.

Anyway, that is exactly my point: you did not read the documentations.
Because the documentations do not say to disable power management, they
say to disable CONFIG_APM and CONFIG_ACPI_PROCESSOR.
http://www.xenomai.org/index.php/FAQs#Which_kernel_settings_should_be_avoided.3F

And you did not read the mailing lists archives either.

> 
> Hope you remember that the issue was posted by another community person
> regarding the booting issue after he compiled the kernel. I suggested to use
> "noacpi" "nolapci" in boot argument.  Though the system was booted properly,
> your suggestion was, not to use this option. Bcoz the kernel unable to use
> ACPI. So we have two scenarios here.
> [1]If we disable the ACPI in BIOS level then the kernel is booting properly.
> But, the real time system can not use ACPI
> [2] ACPI enabled. But system will not boot properly.

No, it was noapic nolapic, you are confusing APIC and ACPI. And you can
get the system to boot without APIC, you simply have to disable it in
the kernel configuration. Disabling it at run-time will not work with
Xenomai. This too has been repeated many times on this mailing list. But
it is not advised, as written here:

http://www.xenomai.org/index.php/Embedded_Device_Support#x86

using APIC leads to better performances.

> 
> So how to resolve the above issue and please share if you have any specific
> documents/guidelines/howto/articles on how this ACPI affects the normal
> Linux and real time systems & why it is mandatory for xenomai.
> 

Keeping the ACPI enabled is not only about performances (one of its
sides effects is to disable the BIOS "legacy" power management, so some
SMIs sources), it is also a way to get the kernel to properly configure
some hardware details by reading them in the ACPI tables. When it fails
to do that, unexpected effect may be expected, ranging from interrupt
storms to boot failures. We experienced this in the past, you may find
traces in the mailing list archives.

-- 
					    Gilles.

