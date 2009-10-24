From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AE333E9.5040802@domain.hid>
References: <4AE333E9.5040802@domain.hid>
Content-Type: text/plain
Date: Sat, 24 Oct 2009 19:37:48 +0200
Message-Id: <1256405868.2862.512.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Virtual IRQ Numbers in powerpc?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "A. Nolson" <alohanono@domain.hid>
Cc: xenomai@xenomai.org

On Sat, 2009-10-24 at 19:05 +0200, A. Nolson wrote:
> Hi,
> 
>  i have a PowerPC 405 based system using a 2.6.30 Xenomai patched kernel
> and I want to manage some interrupts in userspace for some non-critical
> custom drivers. I have an OF device-tree where I indicate my HW
> interrupts (the ones I need to use are not shared with any already
> managed interrupt in the kernel). I have been trying to initialize an
> interrupt handler in userspace with rt_intr_create by using the real
> interrupt numbers indicated in the dts . The handler gets loaded but no
> interrupt shows up. I have seen that rt_intr_create indicates that the
> irq number is "architecture dependant", but I haven't been able to spot
> further explanations on this. I know that arch=powerpc use virtual
> interrupts and I am wondering if I first need to map the real interrupt
> in a virtual interrupt number before using it( like one would do in a
> normal linux kernel driver ).

Yes, Xenomai/ppc uses virtual interrupt mappings (which are NOT related
at all with virtual I-pipe interrupts though). You should always use the
same IRQ numbers as the vanilla kernel exposes to its drivers, this is a
rule of thumb with all archs Xenomai supports.

To sum up, you should replace the real (OF) hw IRQ number in the call to
rt_intr_create() by its remapped counterpart.

> 
> I am doing this:
> 
>     if( (err = rt_intr_create(&(dev->intr_desc), "GPIO IRQ", irqno,
> I_NOAUTOENA)) < 0 ){
>         pdbg(DBG_WARN, "Cannot create interrupt for GPIO
> rt_intr_create=%i\n", err);
>         return err;
>     }
>        
>     rt_intr_enable (&(dev->intr_desc));
> 
>     if( (err = rt_task_spawn(&(dev->interrupt_task), "Int", 0, irq_prio,
> 0,fisr, (void*)&(dev->intr_desc))) < 0){
>         pdbg(DBG_WARN, "Cannot Spawn ISR for GPIO. err = %d\n", err);
>         return err;
>     }
> 
>  What am I missing?
> 
> Thanks!
> 
>  /Alfred
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



