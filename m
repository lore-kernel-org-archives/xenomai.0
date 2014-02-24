MIME-Version: 1.0
In-Reply-To: <530A8767.4030004@xenomai.org>
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <CAK4EZFRN56pZkzmYwBpyupYkbj+V1mgYUPHk4YfLshSs-zFGGw@mail.gmail.com>
 <CAK4EZFTRhDxJkRdY7epTqQ=f0rpoK570uJckq4aOYnt7z6fzxA@mail.gmail.com>
 <CAEbDrgkAqAGWrap1156fiQnLiuBJ_P6NUdxQQQRBiLkDEKRwGQ@mail.gmail.com>
 <530A8767.4030004@xenomai.org>
Date: Mon, 24 Feb 2014 21:19:15 +0000
Message-ID: <CAEbDrgmf+RtS5gS5SKO7eq66ge-LHoJ0hTOC=yeRmUgk0MXqog@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Gilles,

I compiled the kernel width the stack unwind disabled and it throws the
same warning while booting: http://pastebin.com/mSTnPACr
[    1.948056] WARNING: at kernel/irq/handle.c:146
handle_irq_event_percpu+0x198/0x1c0(
[    1.959568] irq 32 handler usb_hcd_irq+0x0/0x84 enabled interrupts

Also, when unlpugging USB devices I get kernel panics:
http://pastebin.com/Nr87y8Ki

What else would you need to see to identify the actual failure?
How should be the root domain stalled, how to look for it?


Thanks,
Gregory


On 23 February 2014 23:42, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 02/24/2014 12:30 AM, Gregory Dymarek wrote:
> > Gilles,
> >
> > I will give it a try with stack unwinding disabled and report back.
> >
> > Why I picked up this warning was because I mostly get kernel panics when
> > unplugging usb devices:
> > http://pastebin.com/uAhDGuzm
> >
> > I thought this is to do with the warning when booting the kernel.
>
> It is very much likely from the stack trace that the problem is due to
> the root domain not being stalled during the execution of the USB
> handler: we see two USB interrupts piled up, which obviously could not
> happen if interrupts were disabled.
>
>
> --
>                                                                 Gilles.
>
