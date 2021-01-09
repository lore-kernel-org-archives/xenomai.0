References: <20210102093353.3195090-1-rpm@xenomai.org>
 <20210102093353.3195090-14-rpm@xenomai.org>
 <bacb5da0-9bca-c9c7-70b4-3490626426a4@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH Dovetail 13/13] cobalt/syscall: pipeline: abstract
 syscall entry points
In-reply-to: <bacb5da0-9bca-c9c7-70b4-3490626426a4@siemens.com>
Date: Sat, 09 Jan 2021 11:58:44 +0100
Message-ID: <87im86l6l7.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 02.01.21 10:33, Philippe Gerum wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>> 
>> The I-pipe and Dovetail differ only marginally with respect to syscall
>> handling. Abstract only the few details we need to cope with both
>> interfaces.
>> 
>> No functional change is introduced.
>> 
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>>  .../cobalt/kernel/ipipe/pipeline/kevents.h    |  3 ++
>>  .../cobalt/kernel/ipipe/pipeline/pipeline.h   |  2 ++
>>  include/cobalt/kernel/sched.h                 |  2 --
>>  kernel/cobalt/ipipe/Makefile                  |  2 +-
>>  kernel/cobalt/ipipe/syscall.c                 | 29 +++++++++++++++++++
>>  kernel/cobalt/posix/process.h                 |  3 --
>>  kernel/cobalt/posix/syscall.c                 | 28 ++++--------------
>>  kernel/cobalt/posix/syscall.h                 |  7 +++++
>>  8 files changed, 47 insertions(+), 29 deletions(-)
>>  create mode 100644 kernel/cobalt/ipipe/syscall.c
>> 
>> diff --git a/include/cobalt/kernel/ipipe/pipeline/kevents.h b/include/cobalt/kernel/ipipe/pipeline/kevents.h
>> index 30425a96b..2f186a57e 100644
>> --- a/include/cobalt/kernel/ipipe/pipeline/kevents.h
>> +++ b/include/cobalt/kernel/ipipe/pipeline/kevents.h
>> @@ -7,6 +7,9 @@
>>  #ifndef _COBALT_KERNEL_IPIPE_KEVENTS_H
>>  #define _COBALT_KERNEL_IPIPE_KEVENTS_H
>>  
>> +#define KEVENT_PROPAGATE   0
>> +#define KEVENT_STOP        1
>> +
>>  struct cobalt_process;
>>  struct cobalt_thread;
>>  
>> diff --git a/include/cobalt/kernel/ipipe/pipeline/pipeline.h b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
>> index 0ffc9b00b..fb0465fb2 100644
>> --- a/include/cobalt/kernel/ipipe/pipeline/pipeline.h
>> +++ b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
>> @@ -11,6 +11,8 @@
>>  
>>  #include <pipeline/machine.h>
>>  
>> +#define xnsched_realtime_domain  cobalt_pipeline.domain
>> +
>
> Why not use the chance and call also this xnsched_primary_domain?

Agreed on the reasoning. However I'll push that change on top top of my
current patch queue, without affecting this intermediate patch only for
a cosmetic change, not to cause useless merge conflicts - I have several
other series of changes pending for kernel/cobalt/ipipe/{init, intr}.c
typically.

-- 
Philippe.

