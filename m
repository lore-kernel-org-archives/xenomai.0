Message-ID: <20020618071723.91139.qmail@domain.hid>
Date: Tue, 18 Jun 2002 00:17:23 -0700 (PDT)
From: mohan kumar <mohan_knb@domain.hid>
In-Reply-To: <3D0DD94D.EE781A5E@opersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Adeos-main] Re: My first tests with adeos!!!
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: karim@domain.hid
Cc: adeos-main@gna.org

hi,
I assume that resetting the control word (with the
IPIPE_PASS_MASK bit set) will dispatch the interrupt
to the next domain. So i reset the control word once
every 100 interrupts and reset it in the next
interrupt.

Well, my code is not elobrate :)

cheers,
Mohan S

p.s:i am not subsribed to this mailing list. please cc
me the reply.

#include <linux/version.h>
#include <linux/module.h>
#include <linux/wrapper.h>
#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/init.h>
#include <asm/system.h>
#include <asm/io.h>
#define INT_NUM 1

#if INT_NUM == 0
#define REPROGRAM_8254
#define LATCH_NEW LATCH/100
#endif

MODULE_LICENSE("GPL");

static adomain_t this_domain;

void timer_tick (void)

{
    static int i , mod;
    
    mod=(++i % 100);
    switch (mod)
    {
    case 0:
	    adeos_control_irq(INT_NUM,0,IPIPE_PASS_MASK);
	    break;
    case 1:
	    adeos_control_irq(INT_NUM,IPIPE_PASS_MASK,0);
	    break;
    default:
	    break;
    }

    __asm("iret");
}

void domain_entry (void)

{
    printk("Domain %s started.\n",adp_current->name);

    adeos_virtualize_irq( INT_NUM ,&timer_tick,NULL); 
  

adeos_control_irq(INT_NUM,IPIPE_PASS_MASK,0);    

    for (;;)
	/* This is this domain's idle loop. */
	adeos_suspend_domain();	/* Yield control back to
ADEOS. */
}
	

static int __init __adtest_init (void)

{
    int ret;
    adattr_t attr;
#ifdef REPROGRAM_8254
	outb_p(0x34,0x43);	
	outb_p(LATCH_NEW & 0xff , 0x40);
	outb(LATCH_NEW >> 8 , 0x40);
#endif
    attr.name = "TestDomain";
    attr.entry = &domain_entry;
    attr.estacksz = 0;	/* Let ADEOS choose a
reasonable stack size */
    attr.priority = ADEOS_ROOT_PRI + 1;
    
    ret = adeos_register_domain(&this_domain,&attr);
    return ret;
}

static void __exit __adtest_exit (void)

{
#ifdef REPROGRAM_8254
	outb_p(0x34,0x43);	
	outb_p(LATCH & 0xff , 0x40);
	outb(LATCH >> 8 , 0x40);
#endif	
    adeos_unregister_domain(&this_domain);
}

module_init(__adtest_init);
module_exit(__adtest_exit);




__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com

