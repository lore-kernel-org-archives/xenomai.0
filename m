From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1aa9845a1002050816s714ae6afq2373dcb243462186@domain.hid>
References: <1aa9845a1002040751o549d86efh19c7c0c033dae2c1@domain.hid>
	<1265300097.2348.158.camel@domain.hid>
	<1aa9845a1002050816s714ae6afq2373dcb243462186@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Feb 2010 17:43:56 +0100
Message-ID: <1265388236.2348.246.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] User interrupt handling in Xenomai running into
 probs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Saravanan S <sarans1987@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2010-02-05 at 21:46 +0530, Saravanan S wrote:
> 
> 
> On Thu, Feb 4, 2010 at 9:44 PM, Philippe Gerum <rpm@xenomai.org>
> wrote:
>         On Thu, 2010-02-04 at 21:21 +0530, Saravanan S wrote:
>         > Hi,
>         >
>         >     I tried to implement the hardware interrupt handling
>         feature of
>         > xenomai in user space.I read the native-api document and ran
>         the
>         > user_irq.c program with one change ,i tried to intercept the
>         eth0
>         > interrupt on my system(using interrupt number from
>         > cat /proc/interrupts).When i ran the program the system
>         froze!!!!!
>         >
>         > What am i doing wrong??
>         
>         
>         The thing is that your tiny little change has some impact. You
>         just
>         can't intercept a random interrupt without knowing how it
>         interacts with
>         the Linux kernel, and expect this to work.
>         
>         The Linux NIC driver won't get interrupts because of this,
>         since
>         usr_irq.c does not care of propagating them to the standard
>         kernel, so
>         your device is likely going to bury your box under an
>         interrupt storm.
> 
> To prevent that i used (as given in  native-api document) the option
> I_PROPAGATE while creating the interrupt  object which is supposed to
> forward the interrupt to the kernel after ADEOS services it but still
> the system froze....

This won't be enough. I'm telling you that you should first understand
how intercepting an interrupt in a high priority domain like Xenomai
could (badly) interact with the kernel.

What if your IRQ is level-triggered?
- Xenomai grabs the incoming IRQ, pends it for later processing by Linux
- Your ethernet device keeps chiming in, leaving the interrupt signaled,
because your sample task did not care of clearing the cause of that IRQ.

What do you think will happen next, when interrupts are enabled for
Linux later, or even by Xenomai upon return from its own handler? The
NIC driver won't have the opportunity to run its ISR, because it's
already too late: you have been stormed by interrupts from your ethernet
device.

That could even happen with edge-triggered IRQs, depending on the
device.

I should have added the following in my previous reply: sharing IRQs
between the Linux and Xenomai domains is wrong. All wrong. This is a
limitation induced by the co-kernel design. That is the reason why
usr_irq.c, which is x86-biased, hooks IRQ #7. This one is not associated
with an I/O device. This also explains why changing this to any random
I/O device IRQ number is triggering the issue.

>  
>         What is in snippets/ is not meant to be run blindly. Those are
>         pieces of
>         code to illustrate the use of services in a general way, not
>         examples
>         tailored to run on any platform, not even yours.
>         
>         Read the "Life with Adeos" doc to understand why it can't work
>         the way
>         you did it.
>         
>         >
>         > What  is the purpose of this feature of allowing user space
>         handling
>         > of interrupts.Can a user space driver be written using
>         this???
>         >
>         
>         
>         Sure. When done properly.
> 
> I want to experiment with this feature and need your help on how to do
> it properly.I have read the "Life with Adeos" document. 
> 

Ok, the best help I can give is: forget about doing this. Write a RTDM
device driver in kernel space, to serve a RT app in userland.

Indeed this set of API services to process IRQs in userland is there,
but kept mostly for legacy reasons. But I would not recommend to use
them these days. At all. RTDM is your friend. Really.

> 
>         
>         > Thanks in advance.
>         >
>         > With regards,
>         >
>         > S Saravanan
>         
>         > _______________________________________________
>         > Xenomai-help mailing list
>         > Xenomai-help@domain.hid
>         > https://mail.gna.org/listinfo/xenomai-help
>         
>         
>         --
>         Philippe.
>         
>         
> 


-- 
Philippe.



