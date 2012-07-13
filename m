From: "Jorge Ramirez Ortiz,  HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Date: Fri, 13 Jul 2012 12:24:18 +0100
Message-ID: <4F534D1A615F544D95E57BFD8460658302FEBD85@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
References: <4F534D1A615F544D95E57BFD8460658301CBE3B9@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE189C.7060504@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE3BD@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE8B7C.60506@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE3C2@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
	<4FFFEB98.7060106@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658302FEBCEB@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
	<500001AC.5040706@xenomai.org>
In-Reply-To: <500001AC.5040706@xenomai.org>
Content-Language: es-ES
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] BUG: Unhandled exception over domain Xenomai -
 switching to ROOT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Yes it does: the caller ignores upfront whether the call will be handled in=
 realtime or non-realtime context by the driver.
The client (of course!) can/should (it doesn't really matter for the sake o=
f the argument) take the adequate measures to make sure it will get into th=
e adequate path. =

But the _interface_ does not guarantee which path it will take. This is a f=
act that you can't disagree with.

But please allow me to re-frame the discussion: I am not discussing here ab=
out realtime design practises or about how to use the framework properly. =

I am merely commenting on  the _interfaces_ to the realtime framework and t=
heir consistency. =



-----Mensaje original-----
De: Philippe Gerum [mailto:rpm@xenomai.org] =

Enviado el: 13 July 2012 12:08
Para: Jorge Ramirez Ortiz, HCL Europe
CC: Gilles Chanteperdrix; xenomai@xenomai.org
Asunto: Re: [Xenomai] BUG: Unhandled exception over domain Xenomai - switch=
ing to ROOT

On 07/13/2012 12:41 PM, Jorge Ramirez Ortiz, HCL Europe wrote:
> Sure, I agree with the implementation issue. Makes a lot of sense (I
> think Gilles also posted on this)
>
> But now thinking about your response ('getting away from violation'
> caught my eye J), it seems to me that RTDM (or its implementation, or my
> interpretation!) might be somehow inconsistent.
>
> To the application developer, RTDM provides a unified interface for
> requests to the driver: the client ignores upfront whether the call will
> be handled in real-time or non-real-time context.

No, absolutely not. Of course not. RTDM provides a unified framework for =

writing real-time device drivers building on a well-defined API, which =

design helps in porting back and forth that code between native linux =

and dual kernel implementations. Nothing less, nothing more.
Originally, once of the mission statements of RTDM was to stop the =

proliferation of ad hoc mechanisms for interfacing user and driver code =

in a real-time context. It is certainly not designed to hide the =

requirements and constraints that each environment imposes on the =

implementation. I could not, anyway.

  Looking at the RTDM
> skin as the front door to the real-time software framework, RTDM is
> telling the client not to worry, /"we will handle your request in the
> right context for you: just send them our way"./ Which is actually quite
> nice and provides a lot of data and flexibility to the driver designer.

Neither the userland client or the kernel space IRQ handle ignore which =

context should the service run in, this is where you badly misinterpret =

the core logic of dual kernel systems, and the dual kernel incarnation =

of RTDM in particular.

The fact that RTDM services can switch context automatically in some =

cases, when the call is issued from user-space is by no mean a waiver for:

- ignoring that doing so might induce latency for the userland caller. =

So the caller should really know what it's doing, including from which =

context.
- assuming that kernel code would benefit from the same feature, which =

would not be achievable with reasonable means.

Again, RTDM is not meant to hide the target context to the issuing code, =

it is meant to make the developer's life easier when ever possible. This =

does not mean that the user code is allowed to fire any random call from =

any random context, hoping for the best.

>
> Similarly, we can look at interrupts as the backdoor to that same
> framework; to the driver developer RTDM provides only _/one/_ interface
> (rtdm_request_irq) to that backdoor. Just like it does to the front door.

No, there must be a reason why we have rtdm_request_irq in addition to =

request_irq: because the former specifically deals with real-time =

interrupts, which can preempt any linux activity. So, we do know that we =

are dealing with a real-time context. Incidentally, this is where your =

IRQ handler failed at, by calling a wake_up function from the regular =

linux core.

By your logic, we should be able to hook regular linux IRQs using =

rtdm_request_irq, which we can't.

>
> So, from the __system__ perspective, I don't see any reasons why that
> backdoor - the interrupt handler- couldn't do the same and
> handle/delegate the notification of the non-realtime paths that were
> allowed in via the front door. And I am only talking from an
> architecture point of view of the framework

You are mentioning a design which is at odds with the basic constraints =

imposed on RTDM and its clients by the dual kernel nature of the system, =

which won't fly.

>
> Anyhow, thanks for the details and the patch.
>
> -----Mensaje original-----
> De: Philippe Gerum [mailto:rpm@xenomai.org]
> Enviado el: 13 July 2012 10:34
> Para: Jorge Ramirez Ortiz, HCL Europe
> CC: Gilles Chanteperdrix; xenomai@xenomai.org
> Asunto: Re: [Xenomai] BUG: Unhandled exception over domain Xenomai -
> switching to ROOT
>
> On 07/12/2012 11:29 PM, Jorge Ramirez Ortiz, HCL Europe wrote:
>
>> Hi Gilles
>
>>
>
>>  Information and context below.
>
>>
>
>> kernel:  2.6.35.9
>
>>  xenomai:2.6.0
>
>>  ipipe:2.8-04
>
>> cpu atom  z530 1.6HH
>
>>
>
>> Error
>
>>>>>  [242.962195] BUG: Unhandled exception over domain Xenomai at 0x892160
> - switching to ROOT
>
>>>>>  [242.990052] Pid: 972, comm: InterruptTest Not tainted
> 2.6.35.9-prot-xeno-atom #4
>
>>>>>  [243.015979] Call Trace:
>
>>>>>  [243.025121][<c041b0b3>] __ipipe_handle_exception+0x203/0x210
>
>>>>>  [243.048691][<c07ef4fb>] error_code+0x63/0x70
>
>>
>
>> System:
>
>> 1.  Xenomai thread calling ~9000 PCI writes in a loop. Each of these 9000
> IOCTLs is processed in the realtime path of the RTDM driver.
>
>> 2. A  library has an interrupt notifier on the same RTDM device.
>
>>The interrupt notifier is a wait queue in the non-realtime path of the
> RTDM driver. Events are raised from the RTDM interrupt handler to notify
> the sleeping threads.
>
>>The interrupt notifier is a timed wait every 100ms. When it times out,
> the linux application reads (msgrcv) from a queue in a shared memory
> segment (shmget created).
>
>>
>
>> The  problem with the design is obvious and the issue above solved by
> modifying the library.
>
>> The  interrupt notifier should be sleeping in an rtdm_event_t in the
> realtime path of the device instead of a linux wait queue.
>
>>
>
>> However,  the other design, even if wrong, shouldnt have caused exceptio=
ns.
>
> Your assumption is wrong: you cannot parry a real-time context
>
> reentering the regular linux kernel from an unsafe place through a plain
>
> function call, absolutely none. We can only detect this situation after
>
> the facts to give some debug hints, hopefully before the complete crash,
>
> by instrumenting code paths which may be spuriously called that way, e.g:
>
> diff --git a/kernel/sched.c b/kernel/sched.c
>
> index 2d1e23a..2e0ba74 100644
>
> --- a/kernel/sched.c
>
> +++ b/kernel/sched.c
>
> @@ -3819,6 +3819,8 @@ static void __wake_up_common(wait_queue_head_t *q,
>
> unsigned int mode,
>
> {
>
> wait_queue_t *curr, *next;
>
> +ipipe_check_context(ipipe_root_domain);
>
> +
>
> list_for_each_entry_safe(curr, next, &q->task_list, task_list) {
>
> unsigned flags =3D curr->flags;
>
> At any rate, you should not expect the system to help you getting away
>
> with violations of basic dual kernel programming rules from kernel
>
> space, this won't happen.
>
>>
>
>> Anyhow, I  am as impressed as always with this piece of software. This i=
s the
> toolkit that any embedded developer needs. And RTDM has been a great
> addition.
>
>>
>
>> thanks
>
>> Jorge
>
>>
>
>>  ________________________________________
>
>> From:  Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
>
>> Sent: 12  July 2012 09:31
>
>> To: Jorge  Ramirez Ortiz,HCL Europe
>
>> Cc:  xenomai@xenomai.org
>
>> Subject:  Re: [Xenomai] BUG: Unhandled exception over domain Xenomai - s=
witching
> to ROOT
>
>>
>
>> On  07/12/2012 10:16 AM, Jorge Ramirez Ortiz, HCL Europe wrote:
>
>>>  Thanks Gilles. Yes unfortunately I cant recompile this kernel so I
>
>>> was  wondering about the system context of this fault within Xenomai.
>
>>> BTW  how come the stack frame is not printed by default.
>
>>
>
>> Because  it may not be safe to use show_stack() from RT context (for
>
>> instance,  the print_symbol function to print symbol names need to take a
>
>> spinlock  when a symbol is defined by a kernel module, and this spinlock
>
>> is not  rt-safe). Anyway, the error message normally prints the PC of the
>
>> error.
>
>>
>
>> Could you  give us the exact error messsage? The version of Xenomai, the
>
>> Linux  kernel, the version of the I-pipe patch you use?
>
>>
>
>> --
>
>>Gilles.
>
>>
>
>>
>
>>  ::DISCLAIMER::
>
>>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------
>
>>
>
>> The  contents of this e-mail and any attachment(s) are confidential and
> intended for the named recipient(s) only.
>
>> E-mail  transmission is not guaranteed to be secure or error-free as
> information could be intercepted, corrupted,
>
>> lost,  destroyed, arrive late or incomplete, or may contain viruses in
> transmission. The e mail and its contents
>
>> (with or  without referred errors) shall therefore not attach any liabil=
ity on
> the originator or HCL or its affiliates.
>
>> Views or  opinions, if any, presented in this email are solely those of =
the
> author and may not necessarily reflect the
>
>> views or opinions  of HCL or its affiliates. Any form of reproduction, d=
issemination,
> copying, disclosure, modification,
>
>>  distribution and / or publication of this message without the prior
> written consent of authorized representative of
>
>> HCL is  strictly prohibited. If you have received this email in error pl=
ease
> delete it and notify the sender immediately.
>
>> Before  opening any email and/or attachments, please check them for viru=
ses
> and other defects.
>
>>
>
>>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------
>
>>
>
>>
>
>>  _______________________________________________
>
>> Xenomai  mailing list
>
>>  Xenomai@xenomai.org
>
>> http://www.xenomai.org/mailman/listinfo/xenomai
>
>>
>
> --
>
> Philippe.
>


-- =

Philippe.




::DISCLAIMER::
---------------------------------------------------------------------------=
-------------------------------------------------------------------------

The contents of this e-mail and any attachment(s) are confidential and inte=
nded for the named recipient(s) only.
E-mail transmission is not guaranteed to be secure or error-free as informa=
tion could be intercepted, corrupted,
lost, destroyed, arrive late or incomplete, or may contain viruses in trans=
mission. The e mail and its contents
(with or without referred errors) shall therefore not attach any liability =
on the originator or HCL or its affiliates.
Views or opinions, if any, presented in this email are solely those of the =
author and may not necessarily reflect the
views or opinions of HCL or its affiliates. Any form of reproduction, disse=
mination, copying, disclosure, modification,
distribution and / or publication of this message without the prior written=
 consent of authorized representative of
HCL is strictly prohibited. If you have received this email in error please=
 delete it and notify the sender immediately.
Before opening any email and/or attachments, please check them for viruses =
and other defects.

---------------------------------------------------------------------------=
-------------------------------------------------------------------------


