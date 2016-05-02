From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 2 May 2016 13:26:20 -0400
Message-ID: <20160502172620.GG2055@csclub.uwaterloo.ca>
References: <20160502152530.GC2055@csclub.uwaterloo.ca>
 <57278183.6090800@siemens.com>
 <20160502165416.GD2055@csclub.uwaterloo.ca>
 <20160502171732.GF2055@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160502171732.GF2055@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] ipipe enabled 4.1 kernel crash
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Mon, May 02, 2016 at 01:17:32PM -0400, Lennart Sorensen wrote:
> On Mon, May 02, 2016 at 12:54:16PM -0400, Lennart Sorensen wrote:
> > That's what I am trying to do.  Pretty sure I determined the irq_hold
> > function pointer is NULL on whatever it is.  So far my attempt to printk
> > in __ipipe_ack_fasteoi_irq+0x1c/0x20 seemed unsuccessful.  I wasn't
> > really expecting it to work there.  Going to try a pr_alert instead...
> > 
> > [    2.485100] irq chip has NULL irq_hold function pointer
> > [    2.495581] irq chip (name=CBAR)
> > [    2.502054] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > 
> > OK, seems to be this one:
> > drivers/irqchip/irq-crossbar.c: .name                   = "CBAR",
> > 
> > Makes sense, since that is certainly part of this CPU.
> > 
> > Same hardware is running 3.14 OK, but clearly something is missing in 4.1.
> > 
> > Comparing the irq-crossbar.c between 3.14 and 4.1, it looks like in 4.1
> > it is defined as an irq_chip, while in 3.14 it was not, unless I am
> > misreading the code.  Hmm.
> 
> Well this simplistic patch made it boot to user space:
> 
> Index: linux-4.1.22.rr1/drivers/irqchip/irq-crossbar.c
> ===================================================================
> --- linux-4.1.22.rr1.orig/drivers/irqchip/irq-crossbar.c
> +++ linux-4.1.22.rr1/drivers/irqchip/irq-crossbar.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/slab.h>
> +#include <linux/ipipe.h>
>  
>  #include "irqchip.h"
>  
> @@ -74,6 +75,10 @@ static struct irq_chip crossbar_chip = {
>  #ifdef CONFIG_SMP
>         .irq_set_affinity       = irq_chip_set_affinity_parent,
>  #endif
> +#ifdef CONFIG_IPIPE
> +       .irq_hold               = irq_chip_hold_parent,
> +       .irq_release            = irq_chip_release_parent,
> +#endif
>  };
>  
>  static int allocate_gic_irq(struct irq_domain *domain, unsigned virq,
> 
> 
> 
> Can it be that simple?  That seemed to easy.

Well switchtest and latency and cyclictest all seem to at least be
willing to run now, so I guess it can't be all wrong.

If this looks like a sane solution, I will submit a proper patch with it.

-- 
Len Sorensen

