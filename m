MIME-Version: 1.0
In-Reply-To: <4C3380FB.7010700@domain.hid>
References: <AANLkTikaVz0DcwnQHbAkRf5LzrBy3zXxHhhJzYEAIgYD@mail.gmail.com> 
	<4C3380FB.7010700@domain.hid>
From: Peter Soetens <peter@domain.hid>
Date: Wed, 7 Jul 2010 22:51:17 +0200
Message-ID: <AANLkTin8Hw2Zb4j4aooB2l6F6PXB6HUYm_R6NYyU_4G7@domain.hid>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai-help] 2.5.2 + 2.6.32 patched kernel causes system reset
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
Cc: xenomai-help <xenomai@xenomai.org>

On Tue, Jul 6, 2010 at 9:16 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Peter Soetens wrote:
>> Hi,
>>
>> We have a single-core Pentium M industrial PC equiped with Xenomai
>> 2.5.2 patched vanilla Linux 2.6.32.7.
>> We have two builds of the kernel: one that causes a reliable system
>> reset when starting a 'heavy' Orocos application (lot of thread
>> creation/deletions), the other is rock solid. We think it is related
>> to thread creation in the native skin, since we could at least twice
>> cause the reset by just creating a native thread (that was meant to
>> block on a semaphore) but this was hard to reproduce. Stack size was
>> set to 128k, but only trivial code was executed.We had the impression
>> that enlarging the stack size to 256k caused less resets, but it was
>> still very frequent. Setting the stack size too low caused segfaults
>> in the app, not a kernel crash.
>>
>> The stable config and the diffs between both configs are in
>> attachment. Read it as: apply this patch to make it unstable. Any
>> clues what is the most likely suspect ? Could the xenomai watchdog
>> cause the reset ?
>>
>> Thanks for any pointers, we're prepared to bisect this, if any one
>> knows a tool to do a bisect on a set of config options, we'll be glad
>> to use it.
>
> Before investing any more time, please upgrade to Xenomai 2.5.3.

X 2.5.3 has exactly the same behaviour. We enabled the UP_APIC, but
that didn't help. We then enabled COMFIG_SMP, which caused noticable
slowdown during booting (boot takes 2x as long compared to both
good/bad configs which have equal speed). We then disabled the Xenomai
watchdog, to no avail.

It's really a bisecting issue between the two configs. As I said
before, it's as good as 100% reproducible on our setup.

'They' are pulling me of this and someone else will do further testing
hopefully next week (you know how these things go though...).

We've struck something, we just have to corner it.

Peter

