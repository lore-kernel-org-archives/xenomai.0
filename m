From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTikiWqBARgHe+7ZKGwLtqQux_qZMDsqkGGZpXUsm@domain.hid>
References: <AANLkTikiWqBARgHe+7ZKGwLtqQux_qZMDsqkGGZpXUsm@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 10 Jan 2011 16:06:13 +0100
Message-ID: <1294671973.1828.188.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] S3C2440 ipipe_suspend_domain
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Radoslaw Rybaniec <radek.rybaniec@domain.hid>
Cc: adeos-main@gna.org

On Mon, 2011-01-10 at 15:34 +0100, Radoslaw Rybaniec wrote:
> Hi!
> 
> I'm trying to set up adeos ipipe on board EM2440 board based on
> S3C2440 (it's similar to mini2440). Kernel version is 2.6.30.4 with
> I-pipe 1.15-03. System is stable when one domain exists . Now I'm
> trying to write kernel module that will catch interrupts from one of
> the hardware timers of the S3C2440. Unfortunately I can't get it to
> work. There is something wrong with ipipe_suspend_domain. When this
> function is called in a endless loop the system hangs no matter if
> priority of the module is grater or smaller than root domain. If this
> function isn't called in loop than it doesn't affect system stability
> if priority of module is less than kernel and hangs the system if
> module's priority is greater.

What is wrong is in your code, and with your interpretation of what
ipipe_suspend_domain() is there for.

Your code calls it from the domain entry, which is a domain init
callback, so this makes no sense. There is no heavy-weight threading in
adeos, only a cooperative tasking mechanism. So you should not expect
ipipe_suspend_domain() to block but rather to check whether some low
priority domain has some interrupt to handle, and switch the current
pipeline context to it if so. In any case, it does not change the
current thread of execution kernel-wise.

Additionally, we do not support domains with lower priority than linux
nowadays. In fact, only the adeos core should call
ipipe_suspend_domain(), when walking the pipeline. You should not call
it from your domain code.

If you want to see how adeos is being used these days, check out
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Adeos-rev-B.pdf

> 
> Here are some parts of module:
> 
> static int __init adis_init(void)
> {
> 
> 	struct ipipe_domain_attr attr;
> 	
> 	printk("Timer irq jitter test start\n");
> 
> 	ipipe_init_attr (&attr);
>         attr.name      = "TimeJitter";
> 	attr.domid = 2;
>         attr.priority   = IPIPE_ROOT_PRIO+1 ;
>         attr.entry      = &domain_entry;
> 	
> 	return ipipe_register_domain(&this_domain,&attr);
> }
> 
> static void domain_entry(void)
> {
> 	printk("Domain started\n");
> 	printk("%s %s\n", __DATE__, __TIME__);
> 	prepare_timer();
> 	ipipe_virtualize_irq(ipipe_current_domain, IRQ_TIMER3,
> 			(ipipe_irq_handler_t) &adis_timer_interrupt,NULL,NULL,
> 			IPIPE_HANDLE_MASK|IPIPE_PASS_MASK);
> 	ipipe_control_irq(IRQ_TIMER3,0,IPIPE_ENABLE_MASK);
> 
> /*  while(1)*/
>   {
> 	  ipipe_suspend_domain();
>   }
> }
> 
> void adis_timer_interrupt(unsigned irq)
> {
> 	ipipe_control_irq(irq,0,IPIPE_ENABLE_MASK);
> }
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main

-- 
Philippe.



