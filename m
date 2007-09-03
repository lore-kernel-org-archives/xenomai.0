From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E099942B@EINT11.einet.ad.eivd.ch>
References: <FDBBB5CC70676540B3EF7CFE83FD94E099942B@EINT11.einet.ad.eivd.ch>
Content-Type: text/plain
Date: Mon, 03 Sep 2007 15:05:53 +0200
Message-Id: <1188824753.6037.27.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Activation of IRQ handler in the Linux domain
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2007-09-03 at 14:11 +0200, ROSSIER Daniel wrote:
> Hello,
> 
>  
> 
> I'm doing a small RT application using the I2C driver from Linux. 
> 
> At a certain time, when the task is activated and data are written to
> the I2C bus,
> 
> the driver waits for a IRQ that confirmed the data have been sent out.
> The write function
> 
> actually polls a variable state until a timeout or a state change
> occurring on reception of that IRQ (done by the handler).
> 
>  
> 
> However, since driver functions are called from the Xenomai domain,
> the IRQ handler is not processed
> 
> at the reception since the hander belongs to the Linux domain. It ends
> up with a timeout 
> 
> during the write.
> 
>  
> 
> I implemented a local ISR within the Xenomai application, but the
> propagation of IRQ is not performed
> 
> while the task is running.

Which is expected. All the pipeline abstraction relies on the very
fundamental assumption that domains run by priority order, which in turn
means that a high priority domain must run until all the pending work is
processed, and a Xenomai task in a runnable state represents some
pending work for the Xenomai domain. Make your Xenomai task sleep on
some synchronization object (likely a RTDM one) for synchronizing with
the code which signals the wakeup condition, and the pending IRQ will
flow down to Linux as expected. Busy waiting for such condition is a
dead end here.

>  Is there a way to tell Adeos to forward the IRQ to the Linux domain
> with no delay
> 
> so that the Linux handler can be called? or do I need to re-implement
> the ISR in the Xenomai application?
> 

Your code cannot be on both side of the same fence. Either you want a
real-time guarantee for interrupt delivery and task dispatching and you
need a Xenomai ISR to process IRQs to wake-up some Xenomai task; or, you
don't need any guarantee, but still want Linux to process the i2c IRQs
just for the purpose of recycling some vanilla code, and in such a case,
you need to make the Linux IRQ handler wake up the Xenomai task. In the
latter case, the Xenomai task (in primary RT mode) must sleep at some
point waiting for the wake up event, there is no sideways possible here.
You may call rt_sem_v() or sem_post(), or a rtdm object signaling
routines from a Linux context to wake up a real-time sleeper.

>  
> 
> Thanks for any hints.
> 
>  
> 
> Daniel
> 
>  
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



