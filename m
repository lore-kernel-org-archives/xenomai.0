Subject: Re: [PATCH] ipipe: tracer: Hook into panic path just like ftrace does
References: <89d53aa4-dce0-a519-8f53-09b7e1733208@siemens.com>
 <CAFLxGvzPB=BWy8Hy3-Ecw8YyLFVwUtUZ6G5mzXufM=KZQ7hbiQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <76ce4148-ea3c-fd50-f300-a019b17e8f01@siemens.com>
Date: Tue, 14 Apr 2020 11:18:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvzPB=BWy8Hy3-Ecw8YyLFVwUtUZ6G5mzXufM=KZQ7hbiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 14.04.20 11:10, Richard Weinberger wrote:
> On Tue, Apr 14, 2020 at 8:10 AM Jan Kiszka via Xenomai
> <xenomai@xenomai.org> wrote:
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This uses the same pattern as ftrace for calling ipipe_trace_panic_dump,
>> resulting in one fill less that needs to be patched for ipipe.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   kernel/ipipe/tracer.c | 37 +++++++++++++++++++++++++++++++++++++
>>   lib/bust_spinlocks.c  |  1 -
>>   2 files changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/ipipe/tracer.c b/kernel/ipipe/tracer.c
>> index d0f7cc95c799..181d4df20a6a 100644
>> --- a/kernel/ipipe/tracer.c
>> +++ b/kernel/ipipe/tracer.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/module.h>
>>   #include <linux/version.h>
>>   #include <linux/kallsyms.h>
>> +#include <linux/kdebug.h>
>>   #include <linux/seq_file.h>
>>   #include <linux/proc_fs.h>
>>   #include <linux/ctype.h>
>> @@ -745,6 +746,36 @@ void ipipe_trace_panic_dump(void)
>>   }
>>   EXPORT_SYMBOL_GPL(ipipe_trace_panic_dump);
>>
>> +static int ipipe_trace_panic_handler(struct notifier_block *this,
>> +                                    unsigned long event, void *unused)
>> +{
>> +       ipipe_trace_panic_dump();
>> +       return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block ipipe_trace_panic_notifier = {
>> +       .notifier_call  = ipipe_trace_panic_handler,
>> +       .priority       = 150,
> 
> Are you using the same priorities as ftrace on purpose?
> I'd expect to get dumps from the ipipe tracer and ftrace in a well
> defined order.

Actually, I just copied over and thought of this panic trace as a 
replacement of ftrace because the latter is not pipeline-aware, lacking 
state information about it. I don't see the use case of have both 
enabled yet, do you?

Jan

> 
>> +};
>> +
>> +static int ipipe_trace_die_handler(struct notifier_block *self,
>> +                                  unsigned long val, void *data)
>> +{
>> +       switch (val) {
>> +       case DIE_OOPS:
>> +               ipipe_trace_panic_dump();
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +       return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block ipipe_trace_die_notifier = {
>> +       .notifier_call = ipipe_trace_die_handler,
>> +       .priority = 200,
>> +};
>> +
>>   #endif /* CONFIG_IPIPE_TRACE_PANIC */
>>
>>
>> @@ -1484,4 +1515,10 @@ void __init __ipipe_init_tracer(void)
>>          __ipipe_create_trace_proc_val(trace_dir, "enable",
>>                                        &ipipe_trace_enable);
>>   #endif /* !CONFIG_IPIPE_TRACE_MCOUNT */
>> +
>> +#ifdef CONFIG_IPIPE_TRACE_PANIC
>> +       atomic_notifier_chain_register(&panic_notifier_list,
>> +                                      &ipipe_trace_panic_notifier);
>> +       register_die_notifier(&ipipe_trace_die_notifier);
>> +#endif /* CONFIG_IPIPE_TRACE_PANIC */
>>   }
>> diff --git a/lib/bust_spinlocks.c b/lib/bust_spinlocks.c
>> index 4ed2db7609f5..def8e659a0c1 100644
>> --- a/lib/bust_spinlocks.c
>> +++ b/lib/bust_spinlocks.c
>> @@ -27,7 +27,6 @@ void __attribute__((weak)) bust_spinlocks(int yes)
>>                  unblank_screen();
>>   #endif
>>                  console_unblank();
>> -               ipipe_trace_panic_dump();
>>                  if (--oops_in_progress == 0)
>>                          wake_up_klogd();
>>          }
>> --
>> 2.16.4
>>
> 
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

