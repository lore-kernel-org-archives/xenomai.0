MIME-Version: 1.0
In-Reply-To: <CANKLDmtY=zMPFRExqxMMzVmt4_O3X+oCkgbfLk+gUhiUgmHbcg@mail.gmail.com>
References: <20141120184516.GC4545@sisyphus.hd.free.fr>
 <546EF065.9070206@xenomai.org>
 <CANKLDmuD4evzObPYqd64rfmNLD9NPqS3EZrSUZy_84mL44bpGg@mail.gmail.com>
 <546EF4BF.6070302@xenomai.org>
 <CANKLDmv=GhPfCjFcgjYUv+6geDeY3VX0WUsxjnqqeiRD5YB__g@mail.gmail.com>
 <CANKLDmtgVkgu61k_1zBZ3+FBYJ-zttTheNRW96bRw4_DCHQ_Lw@mail.gmail.com>
 <CANKLDmu3e_gtg-ouqGpX1GzamHDfS5NVywM6DTLin7W4roTGLA@mail.gmail.com>
 <CANKLDmtdtw-SuLpVm7YT=eWWH=ZOFnHFJOPHzm0D6PwjbdNfgA@mail.gmail.com>
 <20141124091840.GT24229@sisyphus.hd.free.fr>
 <CANKLDmvygbwdNXvYxPgwCihDCbUBbWHUFVkSYdAfO2e-OwtZjA@mail.gmail.com>
 <20141124150030.GB26532@sisyphus.hd.free.fr>
 <CANKLDmt-uLDmP-PMoPboVEzrZQkACzTXBHASnN+v9Kxhvdb4kg@mail.gmail.com>
 <5473934F.2070208@xenomai.org>
 <CANKLDmtY=zMPFRExqxMMzVmt4_O3X+oCkgbfLk+gUhiUgmHbcg@mail.gmail.com>
Date: Tue, 25 Nov 2014 11:03:30 +0100
Message-ID: <CANKLDmtP=pa6ZU+BLC79Ynh2EMruhurDYHQQyv=mMJiAiUE5MQ@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] problems with ipipe-3.10 on i.MX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Nov 25, 2014 at 9:40 AM, Henri Roosen <henriroosen@gmail.com> wrote:

>
>
> On Mon, Nov 24, 2014 at 9:21 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>
>> On 11/24/2014 06:01 PM, Henri Roosen wrote:
>> >
>> >
>> > On Mon, Nov 24, 2014 at 4:00 PM, Gilles Chanteperdrix
>> > <gilles.chanteperdrix@xenomai.org
>> > <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
>> >
>> >     On Mon, Nov 24, 2014 at 03:56:46PM +0100, Henri Roosen wrote:
>> >     > On Mon, Nov 24, 2014 at 10:18 AM, Gilles Chanteperdrix <
>> >     > gilles.chanteperdrix@xenomai.org
>> >     <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
>> >     >
>> >     > > On Mon, Nov 24, 2014 at 09:43:25AM +0100, Henri Roosen wrote:
>> >     > > > I don't want to be rude or push anyone, as I know everyone has
>> >     a lot to
>> >     > > do
>> >     > > > by himself. But it would really help me forward if someone
>> >     could have a
>> >     > > > look at the trace I made and answer the questions above.
>> >     > > > If there is no apparent sign in the trace, please point me to
>> >     some places
>> >     > > > where I can add some extra tracing to get down to the root
>> cause.
>> >     > >
>> >     > > Hi Henri,
>> >     > >
>> >     > > I know I said I would help you, but I am not very familiar with
>> this
>> >     > > code, so Philippe will be much more efficient. But he is busy
>> at the
>> >     > > moment and will not be able to help you before some time.
>> >     > >
>> >     >
>> >     > Thanks Gilles, I appreciate the update. However the following
>> short
>> >     > question might be something you are familiar with and I would
>> >     appreciate if
>> >     > you could answer it:
>> >     > In the traces I see gic_mute and gic_unmute, while in between the
>> >     > gic_handle_irq is traced, which triggers our fpga-handler too.
>> >     >
>> >     > Does that mean we have a problem with the gic-muting? What can I
>> do to
>> >     > verify?
>> >
>> >     No, gic_mute only prevents the secondary mode interrupts from being
>> >     delivered. And since the GPIO irq has a primary mode interrupt, the
>> >     mute function does not mute it. So, everything seems fine so far.
>> >
>> > Ok thanks Gilles!
>> >
>> > Maybe a short question that you or Philippe can shortly answer:
>> > I see two __ipipe_sync_pipeline() calls running concurrently. Is that
>> > allowed? If not, which flag or check should prevent both to be running
>> > concurrently?
>>
>>
>> Yes, this is allowed, when the head domain preempts the root one, which
>> is the case here if the gpio path is a real-time one.
>>
>> >
>> > One (triggered from the virtual interrupt) makes an explicit switch to
>> > secondary domain:
>> > __ipipe_set_current_domain(ipipe_root_domain) in
>> __ipipe_do_sync_pipeline().
>> > This triggers the domain switch in the other current call
>> > to __ipipe_do_sync_stage.
>> >
>> > virtual irq path:
>> >
>> > __ipipe_restore_head(0)
>> > __ipipe_sync_pipeline(ipipe_head_domain) // __ipipe_current_domain !=
>> top
>> > __ipipe_do_sync_pipeline(ipipe_head_domain);
>> > __ipipe_set_current_context(ipipe_head_domain);
>> > __ipipe_sync_stage();
>> > __ipipe_do_sync_stage() // for irq 1027
>> > __ipipe_set_current_domain(ipipe_root_domain); //  <------- secondary
>> > domain switch!
>> >
>> > gpio-interrupt path:
>> >
>> > __ipipe_dispatch_irq()
>> > __ipipe_sync_pipeline() // !test_bit(IPIPE_STALL_FLAG,
>> > &ipipe_this_cpu_context(top)->status)
>> > __ipipe_sync_stage()
>> > __ipipe_do_sync_stage()
>> >
>>
>> I can't see this happening in the fr7 trace you sent, at least not at
>> line 3790 as you mentioned. What can be seen soon after, at line 3820 is
>> the control being given back to the regular kernel, with a virq being
>> handled to run an APC, on behalf of a task called "LTRmgr.e<something>"
>> (i.e. which was preempted by the virq in the root domain, which has been
>> delayed by rt activity before it could call the APC handler).
>>
>> I don't see any forced transition from rt to nrt mode in this particular
>> time span, only the nrt mode getting the CPU back at line 3820, once the
>> rt activity goes to sleep, and therefore relinquishes control to the
>> regular kernel.
>>
>> What I can see is a quite long rt processing (1.62 ms, from spot 1771 ->
>> 151) preempting the root domain, and no relax in between.
>>
>> You may want to add user-defined traces using ipipe_trace_special(),
>> when you think the domain has spuriously changed, or when some assertion
>> does not hold true unexpectedly. Looking at the complete trace flow may
>> shed some light.
>>
>> The exact patch with your instrumentation is needed too, so that we can
>> understand your assumptions, and how you check them. You may want to
>> simplify it to the bone, only with the very minimal traces required to
>> demonstrate the bad behavior you suspect.
>>
>> Maybe there is a bug, but so far I could find not any manifestation of
>> it in the traces you sent.
>>
>
> Thanks Philippe for your answers!
>
> The virtual irq path and gpio path described above were a conclusion from
> a different trace file, which is now attached as well as the code
> instrumentation patch.
>
> So please have a look at trace file fr20.txt.
>
> The interesting lines:
> 3578: virtual irq 0x403 gets dispatched
> 3586: __ipipe_do_sync_pipeline sets the current domain to the head
> (primary) domain
> 3592: __ipipe_do_sync_stage handling irq 0x403 (this only ends on line
> 3803)
> 3642: __irq_svc for irq 0x62 (this is the GPIO1_0-15 multiplexed interrupt
> on the gic)
> 3658: irq 0xa4 is dispatched, the GPIO1_4 interrupt
> 3675: __ipipe_do_sync_stage handling irq 0xa4, while the one started at
> line 3592 did not end yet. Also, this one started here is not ended before
> the end of the trace!
> 3803: __ipipe_do_sync_stage ends for irq 0x403
> 3804: __ipipe_do_sync_stage ends as a whole
> 3807: __ipipe_do_sync_pipeline explicitly switched to ipipe_root_domain
> (secondary domain) using __ipipe_set_current_domain(ipipe_root_domain);
>
> In my opinion this breaks rule 'no domain migration during sync_stage' you
> mentioned in one of your earlier emails as sync_stage for irq 0xa4 is still
> ongoing and later triggers the freeze at line 4012.
>
> So this was the reason for my question about __ipipe_do_sync_pipeline
> being allowed to run concurrently, as the one explicitly switches the
> domain to primary and the other path doesn't allow for domain switching
> while still in __ipipe_do_sync_stage().
>
> So where did this go wrong?
> - should __ipipe_do_sync_pipeline() really be allowed to run concurrently?
> - or should __ipipe_do_sync_stage() for irq 0xa4 already have finished
> before the other path switches domains. I guess the other path played all
> head - interrupts already.
> - or is there something else I overlooked or should trace further into?
> Please let me know.
>
>
Please read my previous email with the attached traces and questions first.
But to find out why __ipipe_do_sync_stage() for irq 0xa4 doesn't complete,
I've added some ipipe_trace_special to xnintr_irq_handler() and it turns
out it runs until the xnpod_schedule(); call in xnintr_irq_handler(). It
only returns from the schedule call just before the freeze gets triggered.

I'll patiently await your response for now and wait with providing new
traces because that might get confusing. I'm sure the last trace (fr20.txt)
and this email provide enough clarity to draw some conclusions and/or push
me in a direction where to best trace down the root cause.

Thanks!
Henri

Thanks for your time and effort!
> Henri
>
>
>> --
>> Philippe.
>>
>
>
