Message-ID: <444E383B.6010908@domain.hid>
Date: Tue, 25 Apr 2006 16:54:51 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] test adeos patch
References: <20060425144447.68645.qmail@domain.hid>
In-Reply-To: <20060425144447.68645.qmail@domain.hid>
Content-Type: multipart/mixed; boundary="------------090707030903000905040408"
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Tom Graves <tgraves_cs@domain.hid>
Cc: adeos-main@gna.org

This is a multi-part message in MIME format.
--------------090707030903000905040408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tom Graves wrote:
> Hello all,
> 
> I am new to this mailing list and adeos in general.
> 
> I was wondering if there are any test programs out
> there to verify the adeos patch is applied properly? 
> I am applying it to a kernel running on an arm
> processor.
> 

Attached a trivial test intercepting the timer IRQ, which at least 
demonstrates that the pipeline core works properly.

The definitive test would be to run a complete RTOS like this one over 
the patched kernel:
http://download.gna.org/xenomai/stable/xenomai-2.1.tar.bz2

-- 

Philippe.

--------------090707030903000905040408
Content-Type: text/x-csrc;
 name="ipipe_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe_test.c"

/*
 *   A simple I-PIPE test module.
 *
 *   Copyright (C) 2005 Philippe Gerum.
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
 *   USA; either version 2 of the License, or (at your option) any later
 *   version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 *   This module implements a trivial IPIPE client domain. Basically,
 *   it creates an IPIPE domain which has a higher priority in the
 *   pipeline than the root (i.e. Linux) domain, then virtualizes the
 *   timer interrupt for it. As a result of this, each timer tick is
 *   first processed by this domain's timer_tick() routine, then by
 *   the Linux domain handler.
 */

#include <linux/module.h>
#include <asm/system.h>

MODULE_LICENSE("GPL");

static struct ipipe_sysinfo sys_info;

static struct ipipe_domain this_domain;

static int timer_hits[IPIPE_NR_CPUS];

void timer_tick (unsigned irq)
{
    timer_hits[ipipe_processor_id()]++;
    ipipe_propagate_irq(irq);
}

void domain_entry (void)
{
    printk("Domain %s started on CPU#%d.\n",
	   ipipe_current_domain->name,
	   ipipe_processor_id());

    ipipe_get_sysinfo(&sys_info);

    ipipe_virtualize_irq(sys_info.archdep.tmirq,
			 &timer_tick,
			 NULL,
			 IPIPE_DYNAMIC_MASK);
}

static int __init __ipipe_domain_init (void)
{
    struct ipipe_domain_attr attr;

    ipipe_init_attr(&attr);

    attr.name = "TestDomain";
    attr.domid = 1;
    attr.entry = &domain_entry;
    attr.priority = IPIPE_ROOT_PRI + 1;
 
    return ipipe_register_domain(&this_domain,&attr);
}

static void __exit __ipipe_domain_exit (void)

{
    int cpu;

    ipipe_unregister_domain(&this_domain);

    for (cpu = 0; cpu < sys_info.ncpus; cpu++)
	{
	printk("IPIPE TEST ON CPU #%d:\n",cpu);
	printk("       %d TIMER TICKS ON IRQ #%d\n",timer_hits[cpu],sys_info.archdep.tmirq);
	}
}

module_init(__ipipe_domain_init);
module_exit(__ipipe_domain_exit);

--------------090707030903000905040408--

