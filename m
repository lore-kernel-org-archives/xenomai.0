Subject: Re: [PATCH 2/3] cobalt: Add ptrace debugging helper interface
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <cover.1625688977.git.jan.kiszka@siemens.com>
 <38334cd4bacae85a759591823d6e8898e7d52f76.1625688977.git.jan.kiszka@siemens.com>
 <1b34cb70-ba44-8083-e197-2159f0db48e8@siemens.com>
 <254d53bb-2b0b-f682-3bfc-687a8dd4bdb4@siemens.com>
 <2bf5330d-9b30-4c73-231c-c3b2ead73c24@189.cn>
 <999c9753a276eba679c8a818aa54e8cd8a750a5b.camel@siemens.com>
 <e54ec9f7-e3fc-e019-f69d-fc66d79ba79e@siemens.com>
Message-ID: <8eb87ecb-a664-b080-c58a-bf893651ae1f@siemens.com>
Date: Thu, 8 Jul 2021 17:24:40 +0200
MIME-Version: 1.0
In-Reply-To: <e54ec9f7-e3fc-e019-f69d-fc66d79ba79e@siemens.com>
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "chensong_2000@189.cn" <chensong_2000@189.cn>

On 08.07.21 17:23, Jan Kiszka wrote:
> On 08.07.21 11:16, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
>> On Thu, 2021-07-08 at 17:03 +0800, chensong_2000@189.cn wrote:
>>>
>>> 在 2021/7/8 下午4:05, Jan Kiszka 写道:
>>>> On 08.07.21 09:58, Florian Bezdeka wrote:
>>>>> On 07.07.21 22:16, Jan Kiszka via Xenomai wrote:
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> This introduces the concept of a debugging helper thread. It can
>>>>>> register itself with the cobalt core and then wait for ptrace stop and
>>>>>> resumption events. This can be used to bring the connected devices or
>>>>>> other parts of the system into a state that can tolerate the potentially
>>>>>> long interruption and also synchronize again with it to continue.
>>>>>>
>>>>>> On stop events (breakpoints, debugger interceptions), the core will
>>>>>> ensure that the helper is run after all primary-mode threads were put on
>>>>>> hold and before the debugger will gain control over the whole process.
>>>>>> For that purpose, the helper will receive a notification when it was
>>>>>> pending on the corresponding event-wait syscall and will release the
>>>>>> process into debugging by invoking that syscall to wait for the
>>>>>> resumption event.
>>>>>>
>>>>>> When the debugger resumes the whole process, the helper is resumed
>>>>>> first, right before all threads that will continue in primary mode are
>>>>>> released (threads in secondary mode may run earlier but will have to
>>>>>> wait when trying to enter primary mode). Again, the helper thread
>>>>>> decides when to continue by calling the event-wait system again, in
>>>>>> that case in order to wait for the next stop event.
>>>>>>
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> ---
>>>>>>   include/cobalt/Makefile.am      |  1 +
>>>>>>   include/cobalt/ptrace.h         | 37 ++++++++++++++
>>>>>>   include/cobalt/uapi/Makefile.am |  1 +
>>>>>>   include/cobalt/uapi/ptrace.h    | 24 +++++++++
>>>>>>   include/cobalt/uapi/syscall.h   |  2 +
>>>>>>   kernel/cobalt/posix/process.c   | 34 +++++++++++-
>>>>>>   kernel/cobalt/posix/process.h   |  5 ++
>>>>>>   kernel/cobalt/posix/syscall.c   | 86 +++++++++++++++++++++++++++++++
>>>>>>   lib/cobalt/Makefile.am          |  1 +
>>>>>>   lib/cobalt/ptrace.c             | 91 +++++++++++++++++++++++++++++++++
>>>>>>   10 files changed, 280 insertions(+), 2 deletions(-)
>>>>>>   create mode 100644 include/cobalt/ptrace.h
>>>>>>   create mode 100644 include/cobalt/uapi/ptrace.h
>>>>>>   create mode 100644 lib/cobalt/ptrace.c
>>>>>>
>>>>>> diff --git a/include/cobalt/Makefile.am b/include/cobalt/Makefile.am
>>>>>> index 19e96112e8..e0b203193d 100644
>>>>>> --- a/include/cobalt/Makefile.am
>>>>>> +++ b/include/cobalt/Makefile.am
>>>>>> @@ -4,6 +4,7 @@ includesub_HEADERS =    \
>>>>>>         fcntl.h         \
>>>>>>         mqueue.h        \
>>>>>>         pthread.h       \
>>>>>> +       ptrace.h        \
>>>>>>         sched.h         \
>>>>>>         semaphore.h     \
>>>>>>         signal.h        \
>>>>>> diff --git a/include/cobalt/ptrace.h b/include/cobalt/ptrace.h
>>>>>> new file mode 100644
>>>>>> index 0000000000..f5bec56c9d
>>>>>> --- /dev/null
>>>>>> +++ b/include/cobalt/ptrace.h
>>>>>> @@ -0,0 +1,37 @@
>>>>>> +/*
>>>>>> + * Copyright (C) Siemens AG, 2015-2021
>>>>>> + *
>>>>>> + * Authors:
>>>>>> + *  Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> + *
>>>>>> + * This library is free software; you can redistribute it and/or
>>>>>> + * modify it under the terms of the GNU Lesser General Public
>>>>>> + * License as published by the Free Software Foundation; either
>>>>>> + * version 2 of the License, or (at your option) any later version.
>>>>>> + *
>>>>>> + * This library is distributed in the hope that it will be useful,
>>>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>>>> + * Lesser General Public License for more details.
>>>>>> + *
>>>>>> + * You should have received a copy of the GNU Lesser General Public
>>>>>> + * License along with this library; if not, write to the Free Software
>>>>>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.
>>>>>> + */
>>>>>> +#ifndef _COBALT_PTRACE_H
>>>>>> +#define _COBALT_PTRACE_H
>>>>>> +
>>>>>> +#include <cobalt/uapi/ptrace.h>
>>>>>> +
>>>>>> +#ifdef __cplusplus
>>>>>> +extern "C" {
>>>>>> +#endif
>>>>>> +
>>>>>> +int cobalt_ptrace_helper_init(void);
>>>>>> +int cobalt_ptrace_event_wait(int event);
>>>>>> +
>>>>>> +#ifdef __cplusplus
>>>>>> +}
>>>>>> +#endif
>>>>>> +
>>>>>> +#endif /* !_COBALT_PTRACE_H */
>>>>>> diff --git a/include/cobalt/uapi/Makefile.am b/include/cobalt/uapi/Makefile.am
>>>>>> index d887213f8e..41076e23d9 100644
>>>>>> --- a/include/cobalt/uapi/Makefile.am
>>>>>> +++ b/include/cobalt/uapi/Makefile.am
>>>>>> @@ -6,6 +6,7 @@ includesub_HEADERS =    \
>>>>>>         event.h         \
>>>>>>         monitor.h       \
>>>>>>         mutex.h         \
>>>>>> +       ptrace.h        \
>>>>>>         sched.h         \
>>>>>>         sem.h           \
>>>>>>         signal.h        \
>>>>>> diff --git a/include/cobalt/uapi/ptrace.h b/include/cobalt/uapi/ptrace.h
>>>>>> new file mode 100644
>>>>>> index 0000000000..4e61d458c1
>>>>>> --- /dev/null
>>>>>> +++ b/include/cobalt/uapi/ptrace.h
>>>>>> @@ -0,0 +1,24 @@
>>>>>> +/*
>>>>>> + * Copyright (C) Siemens AG, 2015-2021
>>>>>> + *
>>>>>> + * This library is free software; you can redistribute it and/or
>>>>>> + * modify it under the terms of the GNU Lesser General Public
>>>>>> + * License as published by the Free Software Foundation; either
>>>>>> + * version 2 of the License, or (at your option) any later version.
>>>>>> + *
>>>>>> + * This library is distributed in the hope that it will be useful,
>>>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>>>> + * Lesser General Public License for more details.
>>>>>> + *
>>>>>> + * You should have received a copy of the GNU Lesser General Public
>>>>>> + * License along with this library; if not, write to the Free Software
>>>>>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
>>>>>> + */
>>>>>> +#ifndef _COBALT_UAPI_PTRACE_H
>>>>>> +#define _COBALT_UAPI_PTRACE_H
>>>>>> +
>>>>>> +#define COBALT_PTRACE_EVENT_STOP       0x1
>>>>>> +#define COBALT_PTRACE_EVENT_RESUME     0x2
>>>>>> +
>>>>>> +#endif /* !_COBALT_UAPI_PTRACE_H */
>>>>>> diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
>>>>>> index a2795a3644..1fb4009d64 100644
>>>>>> --- a/include/cobalt/uapi/syscall.h
>>>>>> +++ b/include/cobalt/uapi/syscall.h
>>>>>> @@ -128,6 +128,8 @@
>>>>>>   #define sc_cobalt_clock_nanosleep64           105
>>>>>>   #define sc_cobalt_clock_getres64              106
>>>>>>   #define sc_cobalt_clock_adjtime64             107
>>>>>> +#define sc_cobalt_ptrace_helper_init           108
>>>>>> +#define sc_cobalt_ptrace_event_wait            109
>>>>>
>>>>> Just a note that this affects the onoing Y2038 work. Song, we might have
>>>>> to adjust the syscall numbers again (assuming that Jan is coming in earlier)
>>>>>
>>>>
>>>> If you already know how many additional calls you need, I can move my
>>>> reservation up and keep you block together.
>>>
>>> sc_cobalt_mutex_timedlock64
>>> sc_cobalt_mq_timedsend64
>>> sc_cobalt_mq_timedreceive64
>>> sc_cobalt_sigtimedwait64
>>> sc_cobalt_thread_setschedparam_ex64
>>> sc_cobalt_thread_getschedparam_ex64
>>> cond_wait_prologue64
>>> monitor_wait64
>>> event_wait64
>>> select64
>>> recvmmsg64
>>>
>>> those implementations are ongoing, please reserve, thanks.
>>
>> According to our list in [1] clock_adjtime64 is missing.
>>
> 
> That one is already upstream.
> 
> So I'm reserving now
> 
> /* 108-119 reserved for 64-bit time_t syscalls */
> 

Classic off-by-one: 108-108, i.e. 11 IDs.

Jan

>> We should follow the order defined in [1] as well.
>>
>> [1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/wikis/y2038/Y2038_Affected_Syscalls
>>
> 
> Well, then make sure to send a patch soon that reassigns IDs accordingly.
> 
> Jan
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

