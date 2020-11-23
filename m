Subject: Re: [PATCH v2 1/3] [y2038]clock_settime:introduce old_timespec32 in
 clock_settime
References: <1605774986-4553-1-git-send-email-chensong@tj.kylinos.cn>
 <82cca45bd82473a3bb7a207474722d48017f3c96.camel@siemens.com>
 <5FBB970B.8040204@tj.kylinos.cn>
 <1ceebc3f881ea41052b2060c62922ee4c723b58d.camel@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5FBBAEC1.7070304@tj.kylinos.cn>+4F806CB9645345A8
Date: Mon, 23 Nov 2020 20:44:49 +0800
MIME-Version: 1.0
In-Reply-To: <1ceebc3f881ea41052b2060c62922ee4c723b58d.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>



On 2020年11月23日 20:19, florian.bezdeka@siemens.com wrote:
> On Mon, 2020-11-23 at 19:03 +0800, chensong wrote:
>>
>> On 2020年11月19日 20:11, florian.bezdeka@siemens.com wrote:
>>> On Thu, 2020-11-19 at 16:36 +0800, chensong wrote:
>>>> old_timespec32 was introduced in vanilla kernel at version 4.19
>>>> for y2038, it replaces timespec in syscalls to keep compatibility
>>>> for 32bit timespec.
>>>>
>>>> In this patch, i follow it's idea, replace timespec with
>>>> old_timespec32 as the argument passed to clock_settime from user
>>>> space. Inside clock_settime, timespec is replaced by timespec64.
>>>>
>>>> V2:
>>>> 1, remove trace point trace_cobalt_clock_gettime.
>>>>
>>>> Signed-off-by: chensong <chensong@tj.kylinos.cn>
>>>> ---
>>>>
> < snipped >
>>>>
>>>> -	trace_cobalt_clock_settime(clock_id, ts);
>>>> -
>>>>    	return 0;
>>>>    }
>>>>
>>>> @@ -243,14 +241,18 @@ int __cobalt_clock_adjtime(clockid_t clock_id, struct timex *tx)
>>>>    }
>>>>
>>>>    COBALT_SYSCALL(clock_settime, current,
>>>> -	       (clockid_t clock_id, const struct timespec __user *u_ts))
>>>> +	       (clockid_t clock_id, const struct old_timespec32 __user *u_ts))
>>>
>>> Sorry, but that's wrong.
>>>
>>> Consider a 64 bit kernel (where the internal data type was "long", so
>>> 64 bit): It is now changed to a 32 bit data type (s32), which is wrong.
>>
>> yes, it's correct.
>> If i just leave the argument as timespec, like what you said "untouch",
>> and implement clock_settime64 specific for timespec64, how does it sound
>> to you?
>>
>>> I guess you are following a pattern from Arnd Bergmann which cannot be
>>> applied here. The patch from Arnd may look as he was updating the "old"
>>> syscall but he was introducing a new one instead.
>>>
>>
>> Arnd Bergmann's solution is clear, one is for 32bit, the other is for
>> 64bit.
>> If we keep clock_settime(const struct timespec __user *u_ts) untouched,
>> in 64bit kernel, timespect is 64bit, in 32bit, timespec is 32bit, it can
>> handle both of them although it's a little blurry.
>> If in 32bit kernel, a process with 64bit timespec, it must have been
>> recompiled, which mean libcobalt is new and be able to redirect syscall
>> to 64bit variant.
>> Is it ok for you?
>
> My current idea is to leave all the existing syscalls as they are.
The arguments from userspace can stay as timespec, but internal 
implementation, it should be timespec64, like glibc did.

  So
> we are "only" missing the syscalls expecting time64_t on kernel side.
> They have to be added.
agree.

>
> Before we start sending out patches we should summarize all the work
> that has to be done in [1]. (I noticed that you already improved the
> document, so I will start reviewing now...).
agree, i'm still working on it, let me know when you think it's ready.

>
> Yes, to enable time64_t (or 64 bit time_t) we will need to recompile
> applications and update the kernel. That's fine. We just have to make
> sure that applications that are not re-compiled (= old applications)
> still work with an updated kernel. The combination of old libcobalt and
> updated kernel will fail during feature negotiation. The old kernel
> does not offer the time64 support feature flag.
>
> One interesting part I'm currently looking into is the decision inside
> libcobalt on which syscall has to be used. That depends on the size of
> time_t. I compared glibc and musl implementations so far and as it
> turns out they solved the problem differently (names of defines
> differs). All findings will make it into [1] as well.
i had a couple of emails with Arnd Bergmann back and forth this weekend, 
quote from him
"I believe both musl and glibc in their latest version try calling
sys_clock_settime() first, but fall back to calling sys_clock_settime32()
when running on an old kernel that does not have sys_clock_settime().
"

the implementation of clock_gettime in musl is checking sizeof(time_t)

>
> [1] https://gitlab.com/fbezdeka/xenomai/-/wikis/Y2038_Roadmap
>>
>>> The introduction may be hidden because he did some magic in the syscall
>>> table. The position / index of the syscall changed. So he was not
>>> updating an existing one but adding a new one...
>>>
>>> All "old" syscalls, so the native ones (which were 32 for 32 bit
>>> systems) have a "32" suffix now, so "clock_gettime32".
>>>
>>> Instead of upating existing Cobalt syscalls we have to introduce a new
>>> set of syscalls.
>>>>    {
>>>>



