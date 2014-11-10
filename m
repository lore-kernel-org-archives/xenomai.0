Message-ID: <5461182E.1060201@web.de>
Date: Mon, 10 Nov 2014 20:55:26 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <04e5e7e2fab241a5916e4e48f9d9b325@EX132MBOX1B.de2.local>
 <20141109155351.GH17476@sisyphus.hd.free.fr>
 <28083d9b9cc34fce9a6d308e8d12fbc6@EX132MBOX1B.de2.local>
 <20141110124308.GK17476@sisyphus.hd.free.fr> <5460D139.7090709@siemens.com>
 <20141110155634.GM17476@sisyphus.hd.free.fr> <54610426.4080707@siemens.com>
 <20141110194606.GO17476@sisyphus.hd.free.fr>
In-Reply-To: <20141110194606.GO17476@sisyphus.hd.free.fr>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] "inconsistent lock state" on boot-up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2014-11-10 20:46, Gilles Chanteperdrix wrote:
> On Mon, Nov 10, 2014 at 07:29:58PM +0100, Jan Kiszka wrote:
>> On 2014-11-10 16:56, Gilles Chanteperdrix wrote:
>>> On Mon, Nov 10, 2014 at 03:52:41PM +0100, Jan Kiszka wrote:
>>>> On 2014-11-10 13:43, Gilles Chanteperdrix wrote:
>>>>> On Mon, Nov 10, 2014 at 09:08:47AM +0000, Stoidner, Christoph wrote:
>>>>>>
>>>>>> Hi Gilles,
>>>>>>
>>>>>>> Do you have the same message with exactly the same kernel
>>>>>>> configuration, only with CONFIG_XENOMAI and CONFIG_IPIPE disabled?
>>>>>>
>>>>>> When CONFIG_XENOMAI and CONFIG_IPIPE are disabled the message does n=
ot =

>>>>>> appear on boot-up.
>>>>>>
>>>>>>> Do you have FCSE enabled? If yes, did you try disabling it? same
>>>>>>> with unlocked context switch.
>>>>>>
>>>>>> FCSE is already disabled at all.
>>>>>>
>>>>>> Do you have an idea how to overcome the problem?
>>>>>
>>>>> I am not sure the lockdep message really is a problem. lockdep could
>>>>> be confused by the fact that the hardware interrupts are not off
>>>>> when running the I-pipe, or because we are missing some bit in the
>>>>> I-pipe arm specific code to get it looking at the virtual mask
>>>>> instead of the hardware mask.
>>>>>
>>>>> As for the scheduling while atomic and random segmentation fault,
>>>>> you should use the I-pipe tracer, configure it with enough back
>>>>> trace points, something like 1000 or 10000, and trigger a trace
>>>>> freeze in the kernell code when the problem happens.
>>>>>
>>>>> Also, for the "scheduling while atomic", it may happen if you call
>>>>> some Linux service which reschedules from primary mode, you can try
>>>>> enabling I-pipe debugging, and in fact all Xenomai debugging, to try
>>>>> and catch such mistakes. This is especially important if you are
>>>>> running a custom skin.
>>>>
>>>> "Scheduling while atomic" may have the same reason why lockdep stumble=
s:
>>>> some changes of I-pipe messe up with IRQ state tracing of Linux. I just
>>>> started to look into this issue again. We tried earlier but got distra=
cted.
>>>
>>> I doubt that very much. Though I never run with lockdep, I sometimes
>>> run with CONFIG_PREEMPT, and never saw this message. From what I can
>>> see, the "scheduling while atomic" message is based on the
>>> preempt_count only and does not use irqs_disabled() (which by the
>>> way is known to work with I-pipe on ARM as well, so, if something is
>>> broken, that should be something more obscure).
>>
>> Let's see. I think I've identified one wrong path:
>>
>> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-head=
er.S
>> index d32f8bd..ab911f8 100644
>> --- a/arch/arm/kernel/entry-header.S
>> +++ b/arch/arm/kernel/entry-header.S
>> @@ -198,7 +198,10 @@
>>  #ifdef CONFIG_TRACE_IRQFLAGS
>>  	@ The parent context IRQs must have been enabled to get here in
>>  	@ the first place, so there's no point checking the PSR I bit.
>> -	bl	trace_hardirqs_on
>> +	tst	\rpsr, #PSR_I_BIT
>> +	bleq	trace_hardirqs_off
>> +	tst	\rpsr, #PSR_I_BIT
>> +	blne	trace_hardirqs_on
>>  #endif
>>  	.else
>>  	@ IRQs off again before pulling preserved data off the stack
>>
>> This is probably no fix, but a with that change applied, the warning is
>> gone. Now the question is what to really test for when returning here. I
>> suppose we want the pipeline state of root here - should I
>> __ipipe_check_root_interruptible?
> =

> This does not make sense, read the comment above that change: there
> is no way an interrupt can be taken, and so entering svc_entry, with
> interrupts off. Besides this is mainline code, so it would be a
> problem for mainline too. We are necessarily returning to a place
> where hardware irqs were on.

Did you also look at the trace I posted?

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141110/3a4c666=
d/attachment.sig>
