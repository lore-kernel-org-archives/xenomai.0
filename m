References: <20210220124527.401015-1-rpm@xenomai.org>
 <20210220124527.401015-6-rpm@xenomai.org> <6031B089.3010500@kylinos.cn>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 6/8] cobalt/dovetail: provide core-specific context
 extensions
In-reply-to: <6031B089.3010500@kylinos.cn>
Date: Thu, 25 Feb 2021 14:28:53 +0100
Message-ID: <87blc88eei.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: chensong <chensong@kylinos.cn>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


chensong <chensong@kylinos.cn> writes:

> On 2021=E5=B9=B402=E6=9C=8820=E6=97=A5 20:45, Philippe Gerum via Xenomai =
wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>>
>> In order to intimately connect Cobalt to the kernel, Dovetail allows
>> us to extend the latter with data and procedures we need:
>>
>> - we can embed our own context information into a set of critical
>>    kernel data structures. This information should be defined as a set
>>    of core-specific types, such as struct oob_thread_state which is
>>    going to be part of struct thread_info.
>>
>> - we can define preparation and finalization handlers for out-of-band
>>    IRQ handling, which Dovetail should invoke right after entering the
>>    outer interrupt frame, then right before leaving it respectively.
>>
>> Add the couple of interface headers we need to connect those elements
>> to the kernel.
>>
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>>   kernel/cobalt/include/dovetail/irq.h         | 52 ++++++++++++++++++++
>>   kernel/cobalt/include/dovetail/thread_info.h | 33 +++++++++++++
>>   2 files changed, 85 insertions(+)
>>   create mode 100644 kernel/cobalt/include/dovetail/irq.h
>>   create mode 100644 kernel/cobalt/include/dovetail/thread_info.h
>>
>> diff --git a/kernel/cobalt/include/dovetail/irq.h b/kernel/cobalt/includ=
e/dovetail/irq.h
>> new file mode 100644
>> index 000000000..66d020fde
>> --- /dev/null
>> +++ b/kernel/cobalt/include/dovetail/irq.h
>> @@ -0,0 +1,52 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0
>> + *
>> + * Copyright (C) 2017 Philippe Gerum  <rpm@xenomai.org>
>> + */
>> +
>> +#ifndef _COBALT_DOVETAIL_IRQ_H
>> +#define _COBALT_DOVETAIL_IRQ_H
>> +
>> +#ifdef CONFIG_XENOMAI
>> +
>> +#include <cobalt/kernel/sched.h>
>> +
>> +/* hard irqs off. */
>> +static inline void irq_enter_pipeline(void)
>> +{
>> +	struct xnsched *sched =3D xnsched_current();
>> +
>> +	sched->lflags |=3D XNINIRQ;
>> +}
>> +
>> +/* hard irqs off. */
>
> should be "hard irqs on"?
>

The comment is ok, the interrupt pipeline always calls the exit handler
with hard irqs off.

--=20
Philippe.

