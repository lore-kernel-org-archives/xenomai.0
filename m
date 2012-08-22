MIME-Version: 1.0
In-Reply-To: <50335C18.1090202@xenomai.org>
References: <CAKKWdtfX7f-c7ZK5JXcPGFxK=cJDGK10sMz7JXY_AgO2qkxETQ@mail.gmail.com>
	<50335C18.1090202@xenomai.org>
Date: Wed, 22 Aug 2012 09:36:39 +0430
Message-ID: <CAKKWdtdin4Dbr9K1BkdV+H7KW+N=2c=eFQSsqfoHdnrLz4-wog@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] a question about "life-with-adeos" manual
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Dear Philippe,

I do not understand the function of interrupt enable/disable and also
the domain stage stall/unstall!!!

If xenomai domain uses =A0rthal_irq_disable()  and then i switch to
Linux domain, will that irq be disabled for Linux domain too?

in your document in the section of "Sharing=A0interrupts=A0between=A0domain=
s":
the fuction, realtime_eth_handler() does rthal_irq_disable(irq);
It seems that this function does two things: 1) it disables the
interrupt physically 2) it stalls xenomai pipeline stage
So when we go to Linux domain and  linux_eth_handler() is executed and
rthal_irq_enable(irq); is run, when we get back to xenomai again, that
interrupt is enabled physically.
But xenomai pipeline stage is stalled so if that interrupt happens, it
will be logged only in xenoimai domain.
Is that correct? It is what i understand from your words. Can you
please explain disabling/enabling the interrupts and also
stalling/unstalling the pipeline stages more easily?
It seems difficult to understand.


On Tue, Aug 21, 2012 at 2:29 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 08/21/2012 11:28 AM, ali hagigat wrote:
>>
>> I have copied part of  "life-with-adeos"  document:
>>
>> ------------------------------
>> Sharing interrupts between domains
>> void realtime_eth_handler (unsigned irq, void *cookie)
>> {
>> /*
>> This interrupt handler has been installed using
>> rthal_irq_request(), so it will always be invoked on behalf of
>> the Xenomai (primary) domain.
>> */
>> rthal_irq_disable(irq);
>> /* The Xenomai domain won't receive this irq anymore */
>> rthal_irq_host_pend(irq);
>> /* This irq has been marked as pending for Linux */
>> }
>>
>> In the non=ADworking example above, since Xenomai always uses the
>> explicit propagation
>> mode for all interrupts it intercepts, the next ethernet interrupt
>> will be marked as pending
>> in the Xenomai log only, waiting for the Xenomai handler to possibly
>> propagate it
>> manually down to Linux.
>> ------------------------------
>>
>> We know that calling rthal_irq_disable(irq), makes that interrupt
>> disabled at PIC level and also stops enabling to propagate it.
>
>
> No, this does not stop propagation. It stops internal delivery by the log
> syncer to the target domain, which is different.
>
>
>> If that interrupt is disabled in hardware, how the manual says that
>> the next ethernet interrupt will be marked in the interrupt xenomai
>> log only?
>
>
> "next" in this context means the "after you read this code", not "after t=
his
> code has run".
>
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>>
>
>
> --
> Philippe.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

