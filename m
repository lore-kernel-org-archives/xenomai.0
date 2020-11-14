Subject: Re: [PATCH 5/5] lib/cobalt/clock.c:dispatch clock_settime
References: <1604372743-2986-1-git-send-email-chensong@tj.kylinos.cn>
 <0ca03935-6895-f31e-f9ad-c910e0e22e36@siemens.com>
 <5FAB60C5.8030909@tj.kylinos.cn>
 <f4a2d38b-a851-55fb-d85b-f7816d91e87b@siemens.com>
 <5FABAD94.1030108@tj.kylinos.cn>
 <8478f418-2f69-94e5-cc96-87a606ab68b9@siemens.com>
 <5FABB938.8080807@tj.kylinos.cn>
 <c745cfbd-ef39-fa61-190f-26826c4609ad@siemens.com>
From: song <chensong@tj.kylinos.cn>
Message-ID: <747c26fe-001a-ef2b-a26c-4911d31162c4@tj.kylinos.cn>+2AE012B75BF41959
Date: Sat, 14 Nov 2020 15:04:07 +0800
MIME-Version: 1.0
In-Reply-To: <c745cfbd-ef39-fa61-190f-26826c4609ad@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org, henning.schild@siemens.com



On 2020/11/13 下午7:47, Florian Bezdeka wrote:
> Hi all,
> 
> I reviewed all the timeset64 related patches.
> Please note the comments below.
> 
> Did anyone look into testing yet? There are some combinations of kernel
> and library versions we should look at and make sure they all behave as
> expected. Maybe xenomai-images "project" could help here?

That would be great. y2038 is not as difficult as other realtime part, 
but it will bring a lot of compatible problems if we're not cautious enough.


> 
> On 11.11.20 11:13, chensong via Xenomai wrote:
>>
>>
>> On 2020年11月11日 17:43, Jan Kiszka wrote:
>>> On 11.11.20 10:23, chensong wrote:
>>>>
>>>>
>>>> On 2020年11月11日 15:29, Jan Kiszka wrote:
>>>>> On 11.11.20 04:55, chensong wrote:
>>>>>>
>>>>>>
>>>>>> On 2020年11月10日 18:24, Jan Kiszka wrote:
>>>>>>>
>>>>>>> On 03.11.20 04:05, chensong wrote:
>>>>>>>> Regarding sizeof time_t, dispatch 32bit timespec to clock_settime
>>>>>>>> and 64bit timespec to clock_settime64.
>>>>>>>>
>>>>>>>> Signed-off-by: chensong <chensong@tj.kylinos.cn>
>>>>>>>> ---
>>>>>>>>      lib/cobalt/clock.c | 6 +++++-
>>>>>>>>      1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
>>>>>>>> index 11fd1aa..44b2f3f 100644
>>>>>>>> --- a/lib/cobalt/clock.c
>>>>>>>> +++ b/lib/cobalt/clock.c
>>>>>>>> @@ -237,7 +237,11 @@ COBALT_IMPL(int, clock_settime, (clockid_t
>>>>>>>> clock_id, const struct timespec *tp))
>>>>>>>>      {
>>>>>>>>          int ret;
>>>>>>>>
>>>>>>>> -    ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime, clock_id, tp);
>>>>>>>> +    if (sizeof(time_t) > 4)
>>>>>>>> +        ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime64,
>>>>>>>> +                    clock_id, tp);
>>>>>>>> +    else
>>>>>>>> +        ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime, clock_id,
>>>>>>>> tp);
>>>>>>>
>>>>>>> Maybe do a single
>>>>>>>
>>>>>>> XENOMAI_SYSCALL2(sizeof(time_t) > 4 ? sc_cobalt_clock_settime64
>>>>>>>                                         : sc_cobalt_clock_settime,
>>>>>>> ...)
>>>>>>>
>>>>>>> But we need ABI revision negotiation here. If a new lib is run on a
>>>>>>> kernel that does not have settime64, things will fail (the other way
>>>>>>> around is fine). We need to ensure that new userspace can check for
>>>>>>> this
>>>>>>> upfront while old userspace will happily run (hard requirement for
>>>>>>> making these patches part of 3.1.x).
>>>>>>>
>>>>>>> Jan
>>>>>>
>>>>>> As far as my understanding, ABI revision negotiation happens in
>>>>>> low_init
>>>>>> already, it reminds userspace process that lib and kernel are not
>>>>>> compatible at the first place. Therefore, it addresses the scenario
>>>>>> you
>>>>>> are talking about(new userspace, old kernel or the other way around).
>>>>>>
>>>>>
>>>>> Ah, right. Perfect. Then also update those revisions make detection
>>>>> work
>>>>> as required.
>>>>>
>>>> ok, will do.
>>>>
>>>> XENOMAI_ABI_REV is defined in those files:
>>>>
>>>> ./kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h:25:#define
>>>> XENOMAI_ABI_REV   17UL
>>>> ./kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h:22:#define
>>>> XENOMAI_ABI_REV   17UL
>>>> ./kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h:25:#define
>>>> XENOMAI_ABI_REV
>>>>     1UL
>>>> ./kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h:22:#define
>>>>
>>>> XENOMAI_ABI_REV   17UL
>>>>
>>>>
>>>> increase them to 18UL?
>>>>
>>>> if you agree, i will submit a v2 for this one.
>>>
>>> We need to increase, yes, but we need to keep previous revision userland
>>> working.
> 
> Do we really need to increase the ABI revision?
Agree, we don't have to.
Regarding the case, old app old lib and new kernel, my understanding is 
when old app calls clock_settime, old lib will lead it to 
sc_cobalt_clock_settime(24), nothing changes, as a result, nothing broke.

I will give it a try.

> My understanding is, that once the kernel has been updated applications
> using an old library will be locked out. I guess this is not allowed
> when bumping the xenomai minor revision only.
> 
> I will come up with a small patch set that allows some feature detection
> during runtime. That should help with the identification which syscall
> should be used.
> 
> Would be glad if you both could have a look at it.
> 
>>
>> low_init will stop previous revision userland working once we increase it.
>>
>>>
>>>>
>>>>>> what's more, do we or customers release lib without kernel. About
>>>>>> y2038,
>>>>>> vanilla kernel, glibc, libcobalt, xenomai, too many scenarios to be
>>>>>> addressed, to complicated, we'd better simplify it if possible.
>>>>>
>>>>> Xenomai does not issue separate releases for the kernel part
>>>>> implementing the syscalls and for the xenomai libs using them.
>>>>>
>>>>> However, applications may have been bundled with libs from previous
>>>>> releases of *the same stable series*, and users can expect (bugs aside,
>>>>> new features excluded) that their xenomai lib from, say, 3.1 will still
>>>>> work with a core from 3.1.1.
>> if XENOMAI_ABI_REV in lib is different with XENOMAI_ABI_REV in kernel,
>> low_init will stop it running at the first place.
>>
>> Even if it doesn't, old application, old lib, will go to clock_settime,
>> i can't see any impact here.
>>
>> chensong
>>
>>>>>
>>>>> Jan
>>>>>
>>>>
>>>> In those cases, they will get "ABI mismatch, required xxx, provided
>>>> xxx", user will realize they need new kernel with new lib.
>>>>
>>>> My point is, ignore those too old things. arnd Bergmann dropped
>>>> something as well.
>>>>
>>>
>>> We can't break the scenario described above. That's in fact in line with
>>> what kernel and libc do, just that they also account for newer libc
>>> running on older kernels (while we deny that).
>>>
>>> Jan
>>>
>>
>>
>>
>>
> 
> 



