Message-ID: <51DD49A7.5060109@mitrol.it>
Date: Wed, 10 Jul 2013 13:46:47 +0200
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
References: <51DBF6B8.1000000@mitrol.it> <51DD4760.6050908@xenomai.org>
In-Reply-To: <51DD4760.6050908@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Make a block of code atomic
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Il 10/07/2013 13.37, Gilles Chanteperdrix ha scritto:
> On 07/09/2013 01:40 PM, Paolo Minazzi wrote:
>
>> Hi,
>>
>> I would like to make a block of kernel code atomic, so that no one (both
>> xenomai and Linux) can interrupt it.
>> I use the following :
>>
>> #define my_local_irq_save(x)    ((x) =
>> ipipe_test_and_stall_pipeline_head()&  1)
>> #define my_local_irq_restore(x) ipipe_restore_pipeline_head(x)
>>
>> my_local_irq_save(flags);
>> <  critical section>
>> my_local_irq_restore(flags);
>>
>> It works well enough, but rarely an rtdm irq enter into my critical
>> section.
>> The rtdm irq is registered in this way : rtdm_irq_request(&priv->irqHnd,
>> ETH_PORT_IRQ_NUM(priv->port), irqHandler, RTDM_IRQTYPE_EDGE, "rtdm_eth",
>> priv);
>>
>> Is it normal ? Are you sure that it cannot happen ?
>
>
> Looking at ipipe_test_and_stall_head implementation on the I-pipe 
> patch for Linux 3.8:
>
> static inline unsigned long ipipe_test_and_stall_head(void)
> {
>     hard_local_irq_disable();
>     return __test_and_set_bit(IPIPE_STALL_FLAG, &__ipipe_head_status);
> }
>
> getting an interrupt in your critical section would mean that 
> "hard_local_irq_disable" is broken on the architecture where you use it.
>
> That being said, I do not know if I look at the implementation you are 
> using, since you did not give us any information about version and 
> architecture you are using.
>
Hi Gilles, thanks for your answer.
I found this morning that was linux to re-enable interrupts.

The following

#define my_local_irq_save(x)    ((x) = 
ipipe_test_and_stall_pipeline_head()&  1)
#define my_local_irq_restore(x) ipipe_restore_pipeline_head(x)

works well if no one touch irq flags directly. Unfortunately was not my 
case.

Thanks again,
Paolo


