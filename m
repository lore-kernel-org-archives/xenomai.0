MIME-Version: 1.0
References: <20210127054348.2128285-1-greg@embeddedgreg.com>
 <20210127054348.2128285-2-greg@embeddedgreg.com>
 <c89fe8d4-c7d8-4767-5d27-b365eb66467a@siemens.com>
In-Reply-To: <c89fe8d4-c7d8-4767-5d27-b365eb66467a@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 27 Jan 2021 09:26:56 -0500
Message-ID: <CALLqZ8RBmWaT=jVkbPozqWQ-U2d-dOHQwFB_qKs-UgaQFjRKkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel: cobalt: Remove header file for newer kernels
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Jan 27, 2021 at 1:14 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 27.01.21 06:43, Greg Gallagher via Xenomai wrote:
> > 5.4 kernels do not have compiler.h, only include this header file for
> kernels older then 5.4
> >
> > Signed-off-by: Greg Gallagher <greg@embeddedgreg.com>
> > ---
> >  kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h
> b/kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h
> > index 7444cc823..17be10339 100644
> > --- a/kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h
> > +++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h
> > @@ -29,7 +29,11 @@
> >  #define XNARCH_HOST_TICK_IRQ __ipipe_hrtimer_irq
> >
> >  #include <asm/barrier.h>
> > +
> > +#if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,0)
> >  #include <asm/compiler.h>
> > +#endif
> > +
> >  #include <asm/cmpxchg.h>
> >  #include <asm/switch_to.h>
> >  #include <asm/system_misc.h>
> >
>
> How about fixing arm as well at this chance? Same pattern.
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>

ACK, will send up another patch shortly.
