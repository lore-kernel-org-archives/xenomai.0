Subject: Re: [PATCH 1/3] cobalt/kernel: Introduce XNDBGCTRL to block
 SIGINT/SIGSTOP
References: <cover.1625688977.git.jan.kiszka@siemens.com>
 <75aec4107a2741b0bf356dc0e1a3164a160c70b7.1625688977.git.jan.kiszka@siemens.com>
 <4e81109d423791a791e09c6064cf0cd6eff04157.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9d9e2c84-1735-2459-9a2d-3277647e7278@siemens.com>
Date: Thu, 8 Jul 2021 10:04:12 +0200
MIME-Version: 1.0
In-Reply-To: <4e81109d423791a791e09c6064cf0cd6eff04157.camel@siemens.com>
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08.07.21 09:44, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> On Wed, 2021-07-07 at 22:16 +0200, Jan Kiszka via Xenomai wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Setting XNDBGCTRL for a thread will prevent its migration to secondary
>> if only the debugging signals SIGINT or SIGSTOP are pending. Such
>> threads will still be able to trigger migration on other signals, such
>> as SIGDEBUG (watchdog), SIGCANCEL (SIGRTMIN) or synchronous SIGTRAP.
>>
>> This is a building block for the debug helper feature.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  include/cobalt/uapi/kernel/thread.h |  1 +
>>  kernel/cobalt/posix/syscall.c       | 12 +++++++++++-
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/cobalt/uapi/kernel/thread.h b/include/cobalt/uapi/kernel/thread.h
>> index 664def08ef..74007ac0d6 100644
>> --- a/include/cobalt/uapi/kernel/thread.h
>> +++ b/include/cobalt/uapi/kernel/thread.h
>> @@ -51,6 +51,7 @@
>>  #define XNTRAPLB  0x00100000 /**< Trap lock break (i.e. may not sleep with sched lock) */
>>  #define XNDEBUG   0x00200000 /**< User-level debugging enabled */
>>  #define XNDBGSTOP 0x00400000 /**< Stopped for synchronous debugging */
>> +#define XNDBGCTRL 0x00800000 /**< Thread is protected against SIGSTOP/SIGINT */
>>
>>
>>
>>
>>  /** @} */
>>
>>
>>
>>
>> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
>> index cd72b22d14..618f965c2a 100644
>> --- a/kernel/cobalt/posix/syscall.c
>> +++ b/kernel/cobalt/posix/syscall.c
>> @@ -86,6 +86,8 @@ static void prepare_for_signal(struct task_struct *p,
>>                              struct pt_regs *regs,
>>                              int sysflags)
>>  {
>> +     sigset_t pending;
>> +     int ignore = 0;
> 
> Why not bool?

Good point, will change.

Jan

> 
>>       int notify = 0;
>>       spl_t s;
>>
>>
>>
>>
>> @@ -100,13 +102,21 @@ static void prepare_for_signal(struct task_struct *p,
>>                       xnthread_clear_info(thread, XNBREAK);
>>               }
>>               xnthread_clear_info(thread, XNKICKED);
>> +     } else if (xnthread_test_state(thread, XNDBGCTRL)) {
>> +             /* only ignore thread-specific SIGSTOP/SIGINT */
>> +             pending = p->pending.signal;
>> +             sigdelset(&pending, SIGSTOP);
>> +             sigdelset(&pending, SIGINT);
>> +             if (sigisemptyset(&pending))
>> +                     ignore = 1;
>>       }
>>
>>
>>
>>
>>       xnlock_put_irqrestore(&nklock, s);
>>
>>
>>
>>
>>       xnthread_test_cancel();
>>
>>
>>
>>
>> -     xnthread_relax(notify, SIGDEBUG_MIGRATE_SIGNAL);
>> +     if (!ignore)
>> +             xnthread_relax(notify, SIGDEBUG_MIGRATE_SIGNAL);
>>  }
>>
>>
>>
>>
>>  static COBALT_SYSCALL(migrate, current, (int domain))
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

