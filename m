Message-ID: <55DCADD0.9040309@xenomai.org>
Date: Tue, 25 Aug 2015 14:02:56 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55DC76C7.5040606@xenomai.org> <55DC87AB.2040306@xenomai.org>
 <55DC940C.4000408@siemens.com> <55DCA0EB.6070905@xenomai.org>
 <55DCA730.9030002@siemens.com>
In-Reply-To: <55DCA730.9030002@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 08/25/2015 01:34 PM, Jan Kiszka wrote:
> On 2015-08-25 19:07, Jorge Ramirez Ortiz wrote:
>> On 08/25/2015 12:13 PM, Jan Kiszka wrote:
>>> On 2015-08-25 17:20, Jorge Ramirez Ortiz wrote:
>>>> On 08/25/2015 10:08 AM, Philippe Gerum wrote:
>>>>> On 08/25/2015 02:13 AM, Don Mahurin wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> We would like to submit our current work on the arm64 port of
>>>>>> ipipe/xenomai. We hope that this contribution will encourage further
>>>>>> development of arm64 support in ipipe/xenomai.
>>>>>>
>>>>>
>>>>> arm64 support is definitely a high priority item. Thanks for tackling this.
>>>>
>>>> There are a numbers of cheap (<100USD) and well documented aarch64 boards [1]
>>>> that could be used as a reference platform (different SoC vendors)
>>>> I'd suggest we use Qualcomm's Dragon 410c.
>>>
>>> The Qualcomm thing is pretty ugly beast, using a proprietary interrupt
>>> controller instead of the standard GIC as strongly recommended by ARM.
>>> As an ARM kernel developer recently put it when I asked about this
>>> board: "I prefer the Raspberry Pi2 over that one." And the Pi2 is
>>> already broken in its design.
>>
>> do you know the name of the developer?
> 
> Will mail you privately.
> 
>>
>> Incidentally I am working on both boards - I gate keep the HiKey kernel [0] but
>> do some level of support on all 96 boards.
>> It seems to me that Qualcomm might be putting more resources on the the level of
>> support and streaming efforts (hence my recommendation).
> 
> I didn't look into that aspect yet, but this is surely valuable as well.
> 
>>
>> Having said that, HiKey has support for OP-TEE (always interesting [1] ) and in
>> the next release we will ship UEFI which we are currently validating.
> 
> Is UEFI an advantage? Will we be able to hack on it to fix lacking
> features and broken bits (that was always required so far with uboot for
> the boards I tried with Cortex-A7/15)?

It is in this case (the previous bootloader that Hikey was using was proprietary
and not open)
Hikey's UEFI [1] is available just as the ATF [2]

last time I checked though, UEFI only brings up 1 of the 8 cores but this might
be fixed in the next release.

[1] https://github.com/96boards/edk2
[2] https://github.com/96boards/arm-trusted-firmware

uboot support is also on its way (there is also support for JTAG which I dont
think it is present in the Dragon board)


> 
>>
>> The 410c ubuntu kernel is here [2] - the Android kernel is also available on
>> another repo.
>>
>> [0] https://github.com/96boards/linux
>> [1] https://github.com/OP-TEE/optee_os
>> [2]
>> https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/shortlog/refs/heads/release/qcomlt-4.0
>>
>>>
>>> The HiKey looks better in this regard, but one has to check which of the
>>> mentioned boards are already upstream (or very close to this). Same for
>>> uboot support. No one should hack on vendor trees any more.
>>
>> Upstream support is ongoing for both boards (we upstreamed the HiKey basic
>> platform support a couple of months ago but that is not to say that it is in a
>> better shape with respect to drivers and peripherals - graphics are - currently,
>> might change in the near future-  better on the 410c for instance).
>>
>> in any case, I think we should pick one SoC.
>>
> 
> Probably. The HiKey seems to have run out of stock right now or is late
> with shipping.
> 
> The DragonBoard I saw live last week, but when I asked about
> virtualization support, that nasty detail came up. Given that
> Xenomai/I-pipe touches a lot the interrupt handling, having a
> pre-existing well-known controller in place (you can simply use the
> arm32 bits) seemed useful to me. I'm not sure what other things are
> problematic because I stopped digging deeper when that board was
> classified unsuitable for virtualization.

this is good feedback. I will pass it down to the Qualcomm folks.

