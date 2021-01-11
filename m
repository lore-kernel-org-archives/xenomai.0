References: <20210109160233.921972-1-rpm@xenomai.org>
 <6632491e-7834-1a6e-f488-9b9077111adf@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH Dovetail 0/4] Get rid of the APC interface
In-reply-to: <6632491e-7834-1a6e-f488-9b9077111adf@siemens.com>
Date: Mon, 11 Jan 2021 14:07:33 +0100
Message-ID: <87im83k4fe.fsf@xenomai.org>
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

> On 09.01.21 17:02, Philippe Gerum wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>> 
>> This patch starts a series aiming at dropping the (functionally
>> redundant) APC interface entirely.
>> 
>> APCs are a relic from the Dark Ages, with no upside compared to open
>> coded requests triggering virtual/synthetic IRQs to be handled by the
>> root domain. As a matter of fact, an APC does run as a client handler
>> of a synthetic IRQ under the hood. In other words, the APC
>> encapsulation adds nothing but useless overhead.
>> 
>> Philippe Gerum (4):
>>   cobalt/pipe: drop dependency on APCs
>>   cobalt/registry: drop dependency on APCs
>>   cobalt/select: drop dependency on APCs
>>   cobalt/apc: drop obsolete APC mechanism
>> 
>>  include/cobalt/kernel/apc.h                   |  32 ---
>>  .../cobalt/kernel/ipipe/pipeline/machine.h    |   2 -
>>  include/cobalt/kernel/rtdm/driver.h           |   1 -
>>  kernel/cobalt/ipipe/Makefile                  |   2 +-
>>  kernel/cobalt/ipipe/apc.c                     | 202 ------------------
>>  kernel/cobalt/ipipe/init.c                    |  19 --
>>  kernel/cobalt/pipe.c                          |  26 ++-
>>  kernel/cobalt/procfs.c                        |  42 ----
>>  kernel/cobalt/registry.c                      |  30 +--
>>  kernel/cobalt/rtdm/core.c                     |   1 -
>>  kernel/cobalt/select.c                        |  23 +-
>>  11 files changed, 49 insertions(+), 331 deletions(-)
>>  delete mode 100644 include/cobalt/kernel/apc.h
>>  delete mode 100644 kernel/cobalt/ipipe/apc.c
>> 
>
> Would it make sense to introduce the pipeline abstraction of those
> services first? Then you won't touch the core code twice, once again for
> removing all the ipipe references.
>

I'd rather do it the way it is: first we prove that there is no
regression in open coding APCs based on virtual IRQs, then we do a 1:1
mapping from the I-pipe virtual IRQs to Dovetail's synthetic IRQs which
have the very same semantics.

-- 
Philippe.

