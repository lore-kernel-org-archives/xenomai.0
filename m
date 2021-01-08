Subject: Re: [PATCH] cobalt/posix/process: pipeline: abstract kernel event
 handlers
References: <20201217180246.48589-1-rpm@xenomai.org>
 <8a3259f5-507d-0c8f-ae06-7ad5613e6f88@siemens.com>
 <a1f5a95b-aed6-5bd8-c002-72d2646e4d2f@siemens.com>
 <79fdf3b2-ad56-5f99-d825-1368cfb5edcd@siemens.com>
 <787f49a3-8fb4-fb86-af5b-87016ee4b528@siemens.com>
 <87im87n4hc.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9eea0851-e685-35c0-5944-1cf1d2b5ee7f@siemens.com>
Date: Fri, 8 Jan 2021 11:07:10 +0100
MIME-Version: 1.0
In-Reply-To: <87im87n4hc.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 08.01.21 10:49, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 08.01.21 08:08, Jan Kiszka via Xenomai wrote:
>>> On 07.01.21 19:27, Jan Kiszka via Xenomai wrote:
>>>> On 07.01.21 18:56, Jan Kiszka via Xenomai wrote:
>>>>> On 17.12.20 19:02, Philippe Gerum wrote:
>>>>>> From: Philippe Gerum <rpm@xenomai.org>
>>>>>>
>>>>>> Although there are significant commonalities between the I-pipe and
>>>>>> Dovetail when it comes to dealing with synchronous kernel events,
>>>>>> there is no strict 1:1 mapping between the two kernel interfaces.
>>>>>>
>>>>>> As an initial step, move all the code handling the kernel events to
>>>>>> the I-pipe section. We may exploit commonalities between the I-pipe
>>>>>> and Dovetail in this area as we gradually merge support for the
>>>>>> latter.
>>>>>>
>>>>>> No functional change is introduced.
>>>>>>
>>>>>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>>>>>> ---
>>>>>>  .../cobalt/kernel/ipipe/pipeline/kevents.h    |  31 +
>>>>>>  kernel/cobalt/ipipe/Makefile                  |   4 +-
>>>>>>  kernel/cobalt/ipipe/kevents.c                 | 860 ++++++++++++++++++
>>>>>>  kernel/cobalt/posix/process.c                 | 846 +----------------
>>>>>>  kernel/cobalt/posix/process.h                 |   4 +
>>>>>>  kernel/cobalt/posix/signal.c                  |   5 +
>>>>>>  kernel/cobalt/posix/signal.h                  |   2 +
>>>>>>  kernel/cobalt/thread.c                        |   4 +-
>>>>>>  kernel/cobalt/trace/cobalt-core.h             |  12 +-
>>>>>>  9 files changed, 930 insertions(+), 838 deletions(-)
>>>>>>  create mode 100644 include/cobalt/kernel/ipipe/pipeline/kevents.h
>>>>>>  create mode 100644 kernel/cobalt/ipipe/kevents.c
>>>>>>
>>>>>> diff --git a/include/cobalt/kernel/ipipe/pipeline/kevents.h b/include/cobalt/kernel/ipipe/pipeline/kevents.h
>>>>>> new file mode 100644
>>>>>> index 000000000..30425a96b
>>>>>> --- /dev/null
>>>>>> +++ b/include/cobalt/kernel/ipipe/pipeline/kevents.h
>>>>>> @@ -0,0 +1,31 @@
>>>>>> +/*
>>>>>> + * SPDX-License-Identifier: GPL-2.0
>>>>>> + *
>>>>>> + * Copyright (C) 2019 Philippe Gerum  <rpm@xenomai.org>
>>>>>> + */
>>>>>> +
>>>>>> +#ifndef _COBALT_KERNEL_IPIPE_KEVENTS_H
>>>>>> +#define _COBALT_KERNEL_IPIPE_KEVENTS_H
>>>>>> +
>>>>>> +struct cobalt_process;
>>>>>> +struct cobalt_thread;
>>>>>> +
>>>>>> +static inline
>>>>>> +int pipeline_attach_process(struct cobalt_process *process)
>>>>>> +{
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static inline
>>>>>> +void pipeline_detach_process(struct cobalt_process *process)
>>>>>> +{ }
>>>>>> +
>>>>>> +int pipeline_prepare_current(void);
>>>>>> +
>>>>>> +void pipeline_attach_current(struct xnthread *thread);
>>>>>> +
>>>>>> +int pipeline_trap_kevents(void);
>>>>>> +
>>>>>> +void pipeline_enable_kevents(void);
>>>>>> +
>>>>>> +#endif /* !_COBALT_KERNEL_IPIPE_KEVENTS_H */
>>>>>> diff --git a/kernel/cobalt/ipipe/Makefile b/kernel/cobalt/ipipe/Makefile
>>>>>> index 6021008fb..5170bb32b 100644
>>>>>> --- a/kernel/cobalt/ipipe/Makefile
>>>>>> +++ b/kernel/cobalt/ipipe/Makefile
>>>>>> @@ -1,3 +1,5 @@
>>>>>> +ccflags-y += -Ikernel
>>
>> "... -I$(srctree)/kernel" - or 5.4 and newer does not build. Also fixed
>> up now.
>>
> 
> Please wait. You see way too many issues on merging this patch. Although
> I'm not building on 4.14 (only covering the two latest LTS, i.e. 5.10
> and 4.19), 4.19 does build here. So this may be an issue with options,
> and there might be several other annoying bugs ahead. It would be better
> for me to include 4.14 in my test list, using your .config(s), and
> re-submit from this patch and on.

Just have a look at our CI/CT. That last issue here was just not caught
by the build test of the Xenomai repo, only by xenomai-image, because
the former does in-tree builds.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

