MIME-Version: 1.0
In-Reply-To: <52CB1F67.1080909@xenomai.org>
References: <CAFnctWFSGJc0Q6ebZ0zBhxRmFEwkvCYKinAEgD-xzcCbfLaPBg@mail.gmail.com>
 <52C7CF1E.2050404@xenomai.org> <52C85088.7020501@xenomai.org>
 <52C86093.4000609@xenomai.org>
 <CAFnctWG1QoQ=f9JCsdxAoU25mc797fKoT9dVS_DdZFRcQ5CP3A@mail.gmail.com>
 <52C891C1.2090007@xenomai.org>
 <CAFnctWFb-dNtNDGf0kckejhQ+tFAj2hBw3gm5Xv8DoALi6f26g@mail.gmail.com>
 <52C949D6.6090904@xenomai.org> <52C9B255.7030702@xenomai.org>
 <52CA622D.806@xenomai.org>
 <CAFnctWGs-mqukTTujenvex9Doq0DoJ_ohFEPDjd7ECYRzu6tpw@mail.gmail.com>
 <52CB0B6A.8080405@xenomai.org>
 <CAFnctWGxXWKL2bdnf4s-Xubw2jGe249uSXim9oqLbiSPqxeXFA@mail.gmail.com>
 <52CB1F67.1080909@xenomai.org>
Date: Mon, 6 Jan 2014 13:40:25 -0800
Message-ID: <CAFnctWGi6cSxDUWN5e3qSbCHFumW7T6_f9XGwWW_Nr+Drj7=Xw@mail.gmail.com>
From: Nima Nourozi <n.nourozi@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] rtdm_task_init call freezes the system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Jan 6, 2014 at 1:25 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 01/06/2014 10:25 PM, Nima Nourozi wrote:
> > On Mon, Jan 6, 2014 at 12:00 PM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> >> On 01/06/2014 08:10 PM, Nima Nourozi wrote:
> >>
> >>> [<c00250a0>] (do_undefinstr+0x0/0x1c8) from [<c002abd4>]
> >>> (__und_svc+0x54/0x80)
> >>>
> >>
> >> What is interesting is what triggers this __und_svc. Will check if I can
> >> reproduce this bug on at91sam9263. Could you try and disable
> CONFIG_KGDB in
> >> the mean-time?
> >>
> >> Regards.
> >>
> >> --
> >>                                             Gilles.
> >>
> >
> > Thanks for the quick reply Gilles. I can verify that CONFIG_KGDB was
> never
> > enabled.
> >
> It is not enabled. Sorry, I did not read your configuration correctly.
>
> --
>                                                                 Gilles.
>

I don't know if this is important but I decided to
disable CONFIG_DEBUG_PREEMPT and here is the new error trace:

I-pipe: Detected illicit call from domain 'Xenomai'

<3>        into a service reserved for domain 'Linux' and below.

Backtrace:

[<c002eb54>] (dump_backtrace+0x0/0x110) from [<c02f29f8>]
(dump_stack+0x18/0x1c)
 r6:c03bd830 r5:c055da40 r4:c055bd20

[<c02f29e0>] (dump_stack+0x0/0x1c) from [<c0079d54>]
(ipipe_check_context+0xb0/0
xd0)

[<c0079ca4>] (ipipe_check_context+0x0/0xd0) from [<c002512c>]
(do_undefinstr+0x8
c/0x1f0)

 r6:c3900050 r5:c0259b10 r4:c3901548

[<c00250a0>] (do_undefinstr+0x0/0x1f0) from [<c002ac74>]
(__und_svc+0x54/0x80)

Nima
