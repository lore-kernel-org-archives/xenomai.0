Message-ID: <4856E1A7.1020608@domain.hid>
Date: Mon, 16 Jun 2008 17:56:55 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <4856B7AE.9030805@domain.hid>
In-Reply-To: <4856B7AE.9030805@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Compile-time bug,
	and problem with PPC440 ethernet
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

A bit more info: Interrupt numbers are 0x15 (txeob) and 0x16 (rxeob). 
I've added some printk, and at the point where the DHCP message is sent
out, I get:

DHCP: sending class identifier "hydra_temp"
stalled stage                     <- printed in __ipipe_walk_pipeline
(see below)
__ipipe_grab_irq 15               <- printed at the beginning of
__ipipe_grab_irq
ready to walk 15                  <- printed at the finalize:, before
__ipipe_walk_pipeline is called
stalled stage                     <- printed in __ipipe_walk_pipeline
(see below)
__ipipe_grab_irq 16               <- printed at the beginning of
__ipipe_grab_irq
ready to walk 16                  <- printed at the finalize:, before
__ipipe_walk_pipeline is called
stalled stage                     <- see below
stalled stage                     <- etc
ipipe_cpudom_var != 0            
next_domain == this_domain
stalled stage

So, while I don't pretend to understand this yet, it looks like the
interrupts are coming into ipipe, but perhaps not getting delivered for
some reason?

    Steve


void __ipipe_walk_pipeline(struct list_head *pos)
{
    struct ipipe_domain *this_domain = ipipe_current_domain, *next_domain;

    while (pos != &__ipipe_pipeline) {

        next_domain = list_entry(pos, struct ipipe_domain, p_link);

        if (test_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(next_domain,
status))) {
            printk("stalled stage\n");
            break;    /* Stalled stage -- do not go further. */
        }

        if (ipipe_cpudom_var(next_domain, irqpend_himask) != 0) {
            printk("ipipe_cpudom_var != 0\n");

            if (next_domain == this_domain) {
                printk("next_domain == this_domain\n");
                __ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
            } else {

                printk("next_domain != this_domain\n");
                ipipe_cpudom_var(this_domain, evsync) = 0;
                ipipe_current_domain = next_domain;
                ipipe_suspend_domain();    /* Sync stage and propagate
interrupts. */

                if (ipipe_current_domain == next_domain)
                    ipipe_current_domain = this_domain;
                /*
                 * Otherwise, something changed the current domain under our
                 * feet recycling the register set; do not override the new
                 * domain.
                 */

                if (ipipe_cpudom_var(this_domain, irqpend_himask) != 0 &&
                    !test_bit(IPIPE_STALL_FLAG,
                          &ipipe_cpudom_var(this_domain, status))) {
                    printk("recycling the register set\n");
                    __ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
                }
            }

            break;
        } else if (next_domain == this_domain) {
            printk("ipipe_cpudom_var == 0\n");
            printk("next_domain == this_domain\n");
            break;
        }

        pos = next_domain->p_link.next;
    }
}


