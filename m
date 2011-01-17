From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4D348625.2050607@domain.hid>
References: <4D348625.2050607@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 17 Jan 2011 19:35:48 +0100
Message-ID: <1295289348.1857.45.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Ext. Interrupt with POSIX skin from user - space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Joerg Mohre <jmohre@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2011-01-17 at 19:10 +0100, Joerg Mohre wrote:
> Hi all, 
> 
> i am using a MPC52000 and try to handle external interrupts (IRQ1)
> with linux kernel 2.6.32 and Xenomai 2.5.5.2.
> I use the POSIX skin functions to setup interrupt and wait for
> interrupt in user-space. 
> 
> First for testing, i wrote a kernel module to setup and handle the
> interrupts.
> This worked well. 
> 
> Now it tried to do the same from user-space with the posix functions.
> But unfortunately this wasn't successful. 
> 
> I have to load the kernel module before i use my user-space
> application (see code).
> Otherwise pthread_intr_control_np will fail with error -1 and errono =
> -19. 
> 
> 
> static int mpc5200_intr_setup(void) 
> { 
>     int                     iret = 0; 
>         int                                        err = 0; 
>     pthread_attr_t          ThreadAttribute; 
>         struct sched_param        sched_param; 
>         unsigned char                 byPriority; 
> 
>         unsigned int                i = 0; 
> 
>         byPriority = 90; 
>         sched_param.sched_priority = byPriority; 
>         memset (&sched_param, 0, sizeof (sched_param)); 

Are you sure you want to do these operations in that order?

> 
>     if ( (pRegsIntCtrl = (int_ctrl_regs*)ioremap( MBAR_VALUE +
> MBAR_INT_CTRL, REMAP_SIZE )) == NULL) { 
>                 printf("ioremap failed for MBAR_INT_CTRL\n"); 
>         return -1;                 
>         } 
> 
>     //pRegsIntCtrl->irqctl =  0x00201401; //bit 10,21 => 1: IRQ1
> rising edge active; enable IRQ1 
>     pRegsIntCtrl->irqctl =  0x00201001; //bit 10 => 1: IRQ1 rising
> edge active; disbable IRQ1 
> 
>         if (pthread_intr_attach_np (&irq_object, 65, 0)) { 
>         printf("Interrupt source not found!\n"); 
>         return -1; 
>     } 
>         else { 
>                 printf("Interrupt source found!\n"); 
>         } 
> 
>         printf("pregs->irqctl = %08X\n",pRegsIntCtrl->irqctl); 
> 
>         sleep(5); 
> 
>         printf("%i\n", i+=1); 
>     pthread_attr_init( &ThreadAttribute); 
>         printf("%i\n", i+=1); 
>     if (pthread_attr_setstacksize(&ThreadAttribute,0x80000)) { 
>                 printf("Failed to set stack size\n"); 
>                 return -1; 
>         } 
>         printf("%i\n", i+=1); 
>            if (pthread_create( &Thread, &ThreadAttribute,
> cyclic_interrupt_receiver, NULL)) { 
>                 printf("Failed to create thread\n"); 
>                 return -1; 
>         } 
>         printf("%i\n", i+=1); 
>         if (pthread_setschedparam (Thread,SCHED_FIFO,&sched_param)) { 
>                 printf("Failed to set scheduling parameter\n"); 
>                 return -1; 
>         } 

Creating the thread with the proper attributes upfront would remove the
need for hairy code.

>         printf("%i\n", i+=1); 
>         iret = pthread_intr_control_np (irq_object, PTHREAD_IENABLE); 
>         if (iret) 
>         { 
>                 err = errno; 
>                 printf("Failed to enable interrupt (%i, errno = %
> i)\n", iret, err); 
>                 return -1; 
>         } 
>         
>         printf("%i\n", i+=1); 
>     return iret; 
> } 
> 
> If i enable IRQ1 with 
> //pRegsIntCtrl->irqctl =  0x00201401; //bit 10,21 => 1: IRQ1 rising
> edge active; enable IRQ1
> the CPU seams to be blocked. 
> 

If that is PCI I/O memory, using no accessor is wrong. Another reason to
create an RTDM driver for accessing it properly.

> I searched the internet but i couldn't find any help for handling
> external interrupts with posix skin in user-space. 

This interface was never documented on purpose: it is bad, for internal
use only, deprecated, and not supported. The butterfingers guy who wrote
it did it all by mistake. Actually, it has been removed from the next
Xenomai 3 API.

You should really use an RTDM driver to control your IRQ. Interrupts are
inherently kernel resources and should remain so. Synchronizing with
IRQs from userland can be done almost trivially using an ad hoc
ioctl_rt() handler your RTDM driver would expose to applications.

> 
> Is it necessary to request an irq with native functions from kernel
> module? 
> 
> I would expect that all (request, enable setup type ....) is done by
> the posix functions. 
> 
> Does any one have some ideas? 
> 
> Thanks 
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



