Message-ID: <4C6CE4E0.1000609@domain.hid>
Date: Thu, 19 Aug 2010 10:01:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=2kNE2KznfnY0voTbWMFqy5_LESXswjJ25O-hk@domain.hid>	<4C6C019D.1040406@domain.hid>
	<AANLkTi=uuzsAsgt8mk04VJE0-tmd1YQ5KoiTu3a-dO3v@domain.hid>
In-Reply-To: <AANLkTi=uuzsAsgt8mk04VJE0-tmd1YQ5KoiTu3a-dO3v@domain.hid>
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
> On Wed, Aug 18, 2010 at 9:21 PM, Gilles Chanteperdrix <
>> We still receive HTML.
>>
> 
> May be because of simply copy and pasted the old content in the last thread.
> 
> How about the scenario now?.

Nope. Still multipart/alternative with HTML.

> 
> 
>>> Obviously I should improve my C language skills.
>>>
>>> I am using linux kernel 2.6.30.8 on Ubuntu 8.04,
>>> Adeos-ipipe-2.6.30.8-x86-2.4-09.patch and Xenomai-2.5.3
>> What about the kernel configuration and self-contained test exhibiting
>> the behaviour you do not understand?
>>
> 
> My .config file is here, http://pastebin.ca/1919917

This .config is wrong: it has ACPI disabled.

> I tested and understand few test cases below.
> switchtest : I am using Intel Dual core processor. ~5731 context switches
> happening in a second
> cyclictest : Tested with 10 threads. Maximum timer latency is 38us and
> minimum is 1us
> clocktest : Simply prints the time offset, drift value and wraps compare
> with normal linux's gettimeofday(). Not much understand from this test.
> latency : user mode latency test provides maximum latency time is 15us.
> latency : kernel mode latency test provides maximum latency time is 3.6 us
> latency : timer mode latency test provides maximum latency time is 3 us

So, timing works correctly. If there was something wrong with time
keeping, you would have seen latency and switchtest drifting, and
printing infinitely increasing or decreasing latencies.

> 
> Not much understand about the clocktest.
> More helpful if we have any documentations for the all tests rather than how
> to use the tests.

The fact that ACPI must be enabled is documented, though you disabled
it, which proves that you do not read the documentation.

What I would like you is to do is to write a self-contained as simple as
possible test which exhibits the behaviour you find suspicious, and
publish it here so that I can try and reproduce this behaviour.

-- 
					    Gilles.

