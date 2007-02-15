Message-ID: <45D40FC0.1000703@domain.hid>
Date: Thu, 15 Feb 2007 08:46:08 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] interrupts test
References: <775081.52919.qm@domain.hid>
In-Reply-To: <775081.52919.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai@xenomai.org

Hello,

you program does not use Xenomai services and is therefore off-topic 
here, nevertheless...

mani bhatti wrote:
> Hi
> I have attached a  kernel module parint.c.When i insert parint.ko  into 
> kernel i get the following message from kernel .
> 
> Request_irq returns 0
> Interrupt generated. You should see the handler-message
> Badness in enable_irq at kernel/irq/manage.c:126
>  [<c012da81>] enable_irq+0x68/0xdf
>  [<c80be033>] init_module+0x22/0x52 [parint]
>  [<c80be000>] handler+0x0/0x11 [parint]
>  [<c012c78a>] sys_init_module+0xb5/0x221
>  [<c0102898>] syscall_call+0x7/0xb
> 
> 
> 
> Please if some one can point out the mistake i would be very helpful.
> Thanks.
> 
> ------------------------------------------------------------------------
> Get your own web address. 
> <http://us.rd.yahoo.com/evt=49678/*http://smallbusiness.yahoo.com/domains/?p=BESTDEAL>
> Have a HUGE year through Yahoo! Small Business. < 
> http://us.rd.yahoo.com/evt=49678/*http://smallbusiness.yahoo.com/domains/?p=BESTDEAL> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> #include <linux/module.h>
> #include <linux/interrupt.h>
> #include <asm/io.h>
> 
> #define BASEPORT 0x378
> 
> static int handler(void)
> {
> 	// do stuff
> 	printk(">>> PARALLEL PORT INT HANDLED\n");
> 	return IRQ_HANDLED;
> }
> 
> int xinit_module(void)
> {
> 	int ret;
> 	ret = request_irq(7, handler, SA_INTERRUPT, "parallelport", NULL);
> 	enable_irq(7);

I think that's the reason for the oops. Remove the unbalanced 
enable_irq() and disable_irq() from you code example. request_irq() and 
disable_irq() already enabled/disable the interrupts.

>         printk("\nRequest_irq returns %d \n",ret);
> 
> 	//set port to interrupt mode; pins are output
> 	outb_p(0x10, BASEPORT + 2); 
> 
> //	printk("Generating interrupt now on all output pins (intr/ACK = pin 10)\n");
> 	
> 	//generate interrupt
> 	outb_p(0, BASEPORT);
> 	outb_p(255, BASEPORT);
> 	outb_p(0, BASEPORT);
> //	printk("Interrupt generated. You should see the handler-message\n");
> 	return 0;
> }
> 
> void xcleanup_module(void)
> {
> 	disable_irq(7);
> 	free_irq(7, NULL);
> }
> 
> module_init(xinit_module);
> module_exit(xcleanup_module);
> MODULE_LICENSE("GPL");

In gerneral, you should use RTDM services in a Xenomai driver module.

Wolfgang.

