References: <20210207160434.2869121-1-rpm@xenomai.org>
 <20210207160434.2869121-12-rpm@xenomai.org>
 <d021db4a-ccc8-aa5a-3d13-d245ef449f52@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 12/18] cobalt/tick: dovetail: add placeholders for tick
 management
In-reply-to: <d021db4a-ccc8-aa5a-3d13-d245ef449f52@siemens.com>
Date: Tue, 09 Feb 2021 10:15:44 +0100
Message-ID: <87sg65mwjj.fsf@xenomai.org>
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

> On 07.02.21 17:04, Philippe Gerum wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>> 
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>>  .../cobalt/kernel/dovetail/pipeline/tick.h    | 12 +++++
>>  kernel/cobalt/dovetail/Makefile               |  2 +-
>>  kernel/cobalt/dovetail/tick.c                 | 45 +++++++++++++++++++
>>  3 files changed, 58 insertions(+), 1 deletion(-)
>>  create mode 100644 include/cobalt/kernel/dovetail/pipeline/tick.h
>>  create mode 100644 kernel/cobalt/dovetail/tick.c
>> 
>> diff --git a/include/cobalt/kernel/dovetail/pipeline/tick.h b/include/cobalt/kernel/dovetail/pipeline/tick.h
>> new file mode 100644
>> index 000000000..409581a3c
>> --- /dev/null
>> +++ b/include/cobalt/kernel/dovetail/pipeline/tick.h
>> @@ -0,0 +1,12 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0
>> + */
>> +
>> +#ifndef _COBALT_KERNEL_IPIPE_TICK_H
>> +#define _COBALT_KERNEL_IPIPE_TICK_H
>> +
>> +int pipeline_install_tick_proxy(void);
>> +
>> +void pipeline_uninstall_tick_proxy(void);
>> +
>> +#endif /* !_COBALT_KERNEL_IPIPE_TICK_H */
>> diff --git a/kernel/cobalt/dovetail/Makefile b/kernel/cobalt/dovetail/Makefile
>> index 24320b3f2..84788f9ce 100644
>> --- a/kernel/cobalt/dovetail/Makefile
>> +++ b/kernel/cobalt/dovetail/Makefile
>> @@ -2,4 +2,4 @@ ccflags-y += -I$(srctree)/kernel
>>  
>>  obj-y +=	pipeline.o
>>  
>> -pipeline-y :=	init.o kevents.o sched.o
>> +pipeline-y :=	init.o kevents.o sched.o tick.o
>> diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
>> new file mode 100644
>> index 000000000..02cd86690
>> --- /dev/null
>> +++ b/kernel/cobalt/dovetail/tick.c
>> @@ -0,0 +1,45 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0
>> + *
>> + * Copyright (C) 2001,2002,2003,2007,2012 Philippe Gerum <rpm@xenomai.org>.
>> + * Copyright (C) 2004 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> + */
>> +
>> +#include <linux/tick.h>
>> +#include <cobalt/kernel/intr.h>
>> +#include <pipeline/tick.h>
>> +
>> +extern struct xnintr nktimer;
>> +
>> +int pipeline_install_tick_proxy(void)
>> +{
>> +	int ret;
>> +
>> +	ret = pipeline_request_timer_ipi(xnintr_core_clock_handler);
>
> Why calling an abstraction here? We know that we are in dovetail land.
>
> I know we do the same on ipipe already. But maybe fix that first and
> avoid this over-abstraction here in the first place.
>

Yes, we can remove that one. We need to keep the call hooking the
rescheduling IPI though, this one needs to be pulled in from the generic
scheduler core.

-- 
Philippe.

