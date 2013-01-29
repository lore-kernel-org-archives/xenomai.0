Message-ID: <510856DF.1000906@ebus.com>
Date: Tue, 29 Jan 2013 15:10:23 -0800
From: Doug Brunner <dbrunner@ebus.com>
MIME-Version: 1.0
References: <5106D736.1050402@ebus.com> <5107BFBE.4060506@siemens.com>
In-Reply-To: <5107BFBE.4060506@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] 16550: Fix crossed timeouts in rt_16550_write
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 01/29/2013 04:25 AM, Jan Kiszka wrote:
> On 2013-01-28 20:53, Doug Brunner wrote:
>> rt_16550_write currently initializes its timeout sequence using
>> rx_timeout. Because xnsynch_acquire ignores the value of timeout (apart
>> from making sure it's positive) when it is passed a non NULL timeout
>> sequence, this means that serial writes are using the read timeout,
>> except for when the user sets a zero tx timeout.
> I would make the description shorter: We accidentally use rx_timeout
> instead of tx_timeout in parts of rt_dev_write. This fixes the obvious
> copy&paste mistake.
>
>> (Should xnsynch_acquire
>> be changed to (timeout + current time) to *timeout_seq to decide which
>> will lead to timing out sooner? Seems more consistent but might break
>> existing code...)
> That's controlled by timeout_mode (XN_RELATIVE vs. XN_ABSOLUTE).
>
>> This changes the initialization of the timeout sequence to use
>> tx_timeout. I also changed the first call to rtdm_mutex_timedlock to use
>> tx_timeout, since this more accurately reflects what is happening.
>>
>> *******************
> Use "---" as separator - or git format-patch.
>
>> diff --git a/ksrc/drivers/serial/16550A.c b/ksrc/drivers/serial/16550A.c
>> index 3672539..e92017d 100644
>> --- a/ksrc/drivers/serial/16550A.c
>> +++ b/ksrc/drivers/serial/16550A.c
>> @@ -979,10 +979,10 @@ ssize_t rt_16550_write(struct rtdm_dev_context *
>> context,
>>
>>          ctx = (struct rt_16550_context *)context->dev_private;
>>
>> -       rtdm_toseq_init(&timeout_seq, ctx->config.rx_timeout);
>> +       rtdm_toseq_init(&timeout_seq, ctx->config.tx_timeout);
>>
>>          /* Make write operation atomic. */
>> -       ret = rtdm_mutex_timedlock(&ctx->out_lock, ctx->config.rx_timeout,
>> +       ret = rtdm_mutex_timedlock(&ctx->out_lock, ctx->config.tx_timeout,
>>                                     &timeout_seq);
>>          if (ret)
>>                  return ret;
>>
>> *******************
> This line may confuse "git am" while applying, but I didn't test.
>
> Anyway, the patch content is fine.
>
> Thanks,
> Jan
>
Thanks for the info on formatting Jan. Next time I will get it right! :)

I meant to say, should rtdm_mutex_timedlock compare (timeout + now) to 
*timeout_seq to decide which one times out sooner, or require that 
either (a) timeout == 0 && timeout_seq != NULL (to use timeout_seq) or 
(b) timeout_seq == NULL (to use timeout? This would make the meaning of 
a call to rtdm_mutex_timedlock more obvious (and might have led to 
catching this bug earlier), but would break code that has relied on the 
non-obvious behavior that currently exists.

     --Doug Brunner

