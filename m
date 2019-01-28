Subject: Re: [I-PIPE] ipipe-core-4.14.89-x86-2 released
References: <E1gaKub-0002DE-4r@xenomai.org>
 <1368965303.3936165.1545600892860@mail.yahoo.com>
 <91ae88c0-4fb5-9e98-e08b-669ffe607bd1@xenomai.org>
 <7d356b91-90bb-ddd1-30a4-9b52ac362e62@web.de>
 <123395f3-a80e-c883-3fea-f3a6a5c39ed5@siemens.com>
 <b8b577f7-0ac3-92dd-92e2-6a2f4fc244d9@xenomai.org>
 <5051b042-b2c2-ecee-e3ef-c4457e6663c2@xenomai.org>
 <419440a3-79aa-2e38-08b1-ab2761777fdd@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6dd3272a-2422-393e-fce9-ed932bebcef6@xenomai.org>
Date: Mon, 28 Jan 2019 18:15:57 +0100
MIME-Version: 1.0
In-Reply-To: <419440a3-79aa-2e38-08b1-ab2761777fdd@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Alec Ari <neotheuser@ymail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, Henning Schild <henning.schild@siemens.com>

On 1/28/19 5:48 PM, Jan Kiszka wrote:
> On 28.01.19 16:31, Philippe Gerum wrote:
>> On 1/28/19 4:18 PM, Philippe Gerum via Xenomai wrote:
>>> On 1/28/19 12:22 PM, Jan Kiszka wrote:
>>>> On 27.12.18 17:17, Jan Kiszka via Xenomai wrote:
>>>>> On 24.12.18 11:06, Philippe Gerum via Xenomai wrote:
>>>>>> On 12/23/18 10:34 PM, Alec Ari via Xenomai wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>>
>>>>>>> I'm not sure if the patch generator was believed to be fixed yet or
>>>>>>> not, but files for other arches (arch/arm/include/asm/arch_timer.h)
>>>>>>> are still included. If this still being worked on, disregard this
>>>>>>> message.
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> The upstream tree at https://gitlab.denx.de/Xenomai/ipipe-x86 still
>>>>>> exports I-pipe bits for multiple architectures (at least for x86 and
>>>>>> arm) but does not include scripts/ipipe/genpatches.sh, so the
>>>>>> generator
>>>>>> does a plain diff, assuming a single-arch tree.
>>>>>>
>>>>>> The ARM bits are likely left-overs and should be dropped to fix the
>>>>>> tree.
>>>>>>
>>>>>
>>>>> Going through the commits, it seems we have a couple of ARM-only
>>>>> driver and timer patches in the x86 tree but no general ARM enabling.
>>>>> Those should be removed, indeed.
>>>>
>>>> In fact, the problem is imported from ipipe-noarch: There are many
>>>> ARM-related driver changes that, strictly spoken, do not belong into
>>>> the
>>>> noarch tree. Some touch arch/arm, others just change drivers that are
>>>> practically ARM-only.
>>>>
>>>> Philippe, do we want to remove those commits from noarch and add
>>>> them to
>>>> ARM? Or should we filter out arch-unrelated diffs when generating the
>>>> patches?
>>>>
>>>
>>> The drivers you mention are shared between different archs (several arm/
>>> drivers are used by arm64) so instead of maintaining multiple copies,
>>> all these drivers have  been merged into noarch eventually.
>>>
>>> This is a patch generation issue for kernel series 4.14+, the easiest
>>> way may be to provide an exclude file to the generator on a per-arch
>>> basis. A filter rule excluding arm/ for anything but arm and arm64
>>> should be enough. I'll have a look at this.
>>>
>>> Please note that this does not apply to pre-4.14 trees; those should
>>> provide scripts/ipipe/genpatches.sh as the legacy I-pipe series normally
>>> does, which should filter contents appropriately.
>>>
>>
>> Those files should not be part of noarch though:
>>
>>   arch/arm/mach-imx/mach-imx51.c            |    5 +
>>   arch/arm/mach-imx/mach-imx53.c            |    5 +
>>   arch/arm/plat-omap/dmtimer.c              |   17 +-
>>   arch/arm/plat-omap/include/plat/dmtimer.h |    6 +
>>
> 
> So these three should go:
> 
> a1edb318ad047d0582de66482efa3b76b30b6e1a
> 09cafa0ee6b1547133eee438c37c8703e70a88d1
> 5fc1baae9cc27adc771c67aee131993612e88ff2
> 
> There is also 9f33ef39090f5f100f056e208733fef2e02bd373, which also
> contains a "FIXME" in the commit log.
> 

This is a timer vs clocksource split for arm, this won't impact your
architecture.


-- 
Philippe.

