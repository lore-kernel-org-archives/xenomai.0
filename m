Subject: Re: [PATCH 2/4] [y2038]cobalt: posix: clock: Adding clock_settime64
References: <1615430812-23822-1-git-send-email-chensong@tj.kylinos.cn>
 <d77a82d1c4738402500af7b9b7bbb0f7ab70e66d.camel@siemens.com>
 <6049E2F0.5010003@tj.kylinos.cn> <6049E9AE.7000103@tj.kylinos.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c2b70e9c-6f9f-4c49-397b-cfc106311f9e@siemens.com>
Date: Thu, 11 Mar 2021 11:37:31 +0100
MIME-Version: 1.0
In-Reply-To: <6049E9AE.7000103@tj.kylinos.cn>
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
To: chensong <chensong@tj.kylinos.cn>, "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>, "rpm@xenomai.org" <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11.03.21 10:58, chensong via Xenomai wrote:
> 
> 
> On 2021年03月11日 17:29, chensong via Xenomai wrote:
>>
>>
>> On 2021年03月11日 17:03, florian.bezdeka@siemens.com wrote:
>>> On Thu, 2021-03-11 at 10:46 +0800, chensong wrote:
>>>> Adding a new syscall clock_settime64 specific for timespec64,
>>>> It can solve y2038 in below scenarios:
>>>>
>>>> 1, 64bit kernel, y2038 safe
>>>> 2, 32bit kernel, 32bit time_t, go to clock_settime, no break,
>>>>     y2038 not safe.
>>>> 3, 32bit kernel, 64bit time_t, go to clock_settime64 by the help
>>>>     of libcobalt, no break, y2038 safe.
>>>>
>>>> Signed-off-by: chensong <chensong@tj.kylinos.cn>
>>>> ---
>>>>   include/cobalt/uapi/syscall.h |  1 +
>>>>   kernel/cobalt/posix/clock.c   | 12 ++++++++++++
>>>>   kernel/cobalt/posix/clock.h   |  4 ++++
>>>>   3 files changed, 17 insertions(+)
>>>>
>>>> diff --git a/include/cobalt/uapi/syscall.h
>>>> b/include/cobalt/uapi/syscall.h
>>>> index 8895d2b..291b550 100644
>>>> --- a/include/cobalt/uapi/syscall.h
>>>> +++ b/include/cobalt/uapi/syscall.h
>>>> @@ -123,6 +123,7 @@
>>>>   #define sc_cobalt_clock_adjtime            100
>>>>   #define sc_cobalt_thread_setschedprio        101
>>>>   #define sc_cobalt_sem_timedwait64        102
>>>> +#define sc_cobalt_clock_settime64        103
>>>
>>> I assume we should keep the order of affected syscalls. The next one
>>> would be sc_cobalt_clock_gettime64.
>>
>> yes, i thought about catagorizing them in order, probably adjust
>> sc_cobalt_sem_timedwait64 later, next is sc_cobalt_clock_gettime64.
>>
>>
>>>
>>> And I'm missing the tests... Please add tests for everything you add /
>>> fix.
>>
>> ongoing.
>>
>> Song
> 
> by the way, i think it's better test clock_settime64 and clock_gettime64
> together, is it ok for you?
> 
> if i set time at 2038 and set it back at the end of test, will it have
> impact to the testing devices?

Yes, if something is depending on the absence of time jumps while the
test is running. But I think it is fine to require that nothing critical
is running in parallel to the test anyway.

BTW, with Dovetail and the unified clocksource, we have to require that
the user disables any ntp services because they can get upset and work
against the test. I-pipe based Xenomai has a separate time base, though.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

