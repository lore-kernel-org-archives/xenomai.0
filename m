Message-ID: <20020619051755.75505.qmail@domain.hid>
Date: Tue, 18 Jun 2002 22:17:55 -0700 (PDT)
From: mohan kumar <mohan_knb@domain.hid>
Subject: Re: [Adeos-main] Re: My first tests with adeos!!!
In-Reply-To: <3D0F0BA2.969434A3@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: adeos <adeos-main@gna.org>

hi,
I think iam not clear...

ok, i think the below code gotta work, but does not:)
I have registered for int 1 and controled the flow so
that it does not go to linux.

i compile the module and invoke it using

$ insmod adtest.o;sleep 1;rmmod adtest

since the keyboard int is not dispatched to linux i do
the insmod and rmmod commands oneshot.

It still hangs :(

I get the timer interrupts. But EVEN ADEOS is not able
to see other interrupts. Iam not able to telnet to the
machine or use the serial cable.

But i will work with the new code in CVS and mail u
the results.

Cheers,
Mohan S

/****adtest.c****/

MODULE_LICENSE("GPL");

static adomain_t this_domain;

void handler(void)
{
    __asm("iret");
}

void domain_entry (void)

{
    printk("Domain %s started.\n",adp_current->name);

    adeos_virtualize_irq( 1 ,&handler,NULL); 
    adeos_control_irq(1,IPIPE_PASS_MASK,0);    

    for (;;)
	/* This is this domain's idle loop. */
	adeos_suspend_domain();	/* Yield control back to
ADEOS. */
}
	

static int __init __adtest_init (void)

{
    int ret;
    adattr_t attr;
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
    adeos_unregister_domain(&this_domain);
}

module_init(__adtest_init);
module_exit(__adtest_exit);



__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com

