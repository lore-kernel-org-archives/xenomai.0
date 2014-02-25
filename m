MIME-Version: 1.0
In-Reply-To: <530D0205.9050406@xenomai.org>
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <CAK4EZFRN56pZkzmYwBpyupYkbj+V1mgYUPHk4YfLshSs-zFGGw@mail.gmail.com>
 <CAK4EZFTRhDxJkRdY7epTqQ=f0rpoK570uJckq4aOYnt7z6fzxA@mail.gmail.com>
 <CAEbDrgkAqAGWrap1156fiQnLiuBJ_P6NUdxQQQRBiLkDEKRwGQ@mail.gmail.com>
 <530A8767.4030004@xenomai.org>
 <CAEbDrgmf+RtS5gS5SKO7eq66ge-LHoJ0hTOC=yeRmUgk0MXqog@mail.gmail.com>
 <530BC103.3010809@xenomai.org>
 <CAEbDrgnFr7YvfoMmFQx=PBKSFEWvwJftx0wZx39ySMqRO2X6gQ@mail.gmail.com>
 <530CFB0D.8040001@xenomai.org>
 <CAEbDrgkJCnbWu_J4svoXOU1x2rz=n95A5+3Ee=R_9CpMgx-JmA@mail.gmail.com>
 <530CFC27.5050700@xenomai.org>
 <CAEbDrgnmM_dD3WX42PYawhkW8zTaYczzfozEe1EX7Z5HnERz3g@mail.gmail.com>
 <530D0205.9050406@xenomai.org>
Date: Tue, 25 Feb 2014 21:09:34 +0000
Message-ID: <CAEbDrgmwch94crHAcrbJDj9MxaiBNaYeLH2U9NtS0tuJKmdDDw@mail.gmail.com>
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

So the frame freeze I got on my version is on line 145 in here:
https://github.com/raspberrypi/linux/blob/rpi-3.8.y/kernel/irq/handle.c

The dwc_otg_hcd_handle_intr is here:
https://github.com/raspberrypi/linux/blob/rpi-3.8.y/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c


Is the line 523 the problem?
    local_fiq_enable();



On 25 February 2014 20:50, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 02/25/2014 09:43 PM, Gregory Dymarek wrote:
> > Here we go: http://pastebin.com/aDskYjnU
> >
> > so line 47 is the call handle_irq_event_percpu
> > looking up of it there is one call to ipipe_unstall_root
> >
> > I guess some more domain knowledge is needed in here than mine...
> >
> > What does this tell us?
>
> This tells us that dwc_otg_hcd_handle_intr is the function which
> re-enables interrupt around dwc_otg_hcd_handle_intr+0x134
>
> Some time before a call to DWC_READ_REG32
>
> Could you make the corresponding code available somewhere?
>
> --
>                                                                 Gilles.
>
