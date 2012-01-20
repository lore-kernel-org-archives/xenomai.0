From: "Terry Fryar" <terry.fryar@domain.hid>
References: <C65BAE4E2DF04BD68697066C4075EC78@domain.hid>	<4F19B046.6090504@domain.hid>	<D2F2766145E048789E0063D6F386E760@domain.hid>	<4F19B324.8080001@domain.hid>
	<DE531AD0193E45018B21711AD3A8DB03@domain.hid>
	<4F19D2D6.2020501@domain.hid>
In-Reply-To: <4F19D2D6.2020501@domain.hid>
Date: Fri, 20 Jan 2012 15:12:37 -0600
Message-ID: <BEDC33647FDC40B8B2C7FCDFA84AAFA7@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtdm difficulties...not fixed....
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Philippe Gerum' <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Spoke too soon...after about 20 minutes, I got:

[ 1870.675437] WARNING: at kernel/softirq.c:137
__local_bh_enable+0x44/0xac()
[ 1870.682629] Modules linked in: vme_pd_drv [last unloaded: vme_pd_drv]
[ 1870.689415] [<c00566fc>] (unwind_backtrace+0x0/0xe0) from [<c007db0c>]
(warn_slowpath_common+0x4c/0x64)
[ 1870.871240] [<c007db0c>] (warn_slowpath_common+0x4c/0x64) from
[<c007db3c>] (warn_slowpath_null+0x18/0x1c)
[ 1870.881352] [<c007db3c>] (warn_slowpath_null+0x18/0x1c) from [<c0083138>]
(__local_bh_enable+0x44/0xac)
[ 1871.271582] [<c0083138>] (__local_bh_enable+0x44/0xac) from [<c008481c>]
(irq_enter+0x44/0x60)
[ 1871.280600] [<c008481c>] (irq_enter+0x44/0x60) from [<c0046018>]
(asm_do_IRQ+0x18/0x98)
[ 1871.288987] [<c0046018>] (asm_do_IRQ+0x18/0x98) from [<c00b9af0>]
(__ipipe_sync_stage+0x154/0x188)

Guess I'll turn on all the debugging and see what pops....dang..... 

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org] 
Sent: Friday, January 20, 2012 2:47 PM
To: Terry Fryar
Cc: 'Gilles Chanteperdrix'; xenomai@xenomai.org
Subject: Re: [Xenomai-help] rtdm difficulties

On 01/20/2012 08:37 PM, Terry Fryar wrote:
> Ok, I'll try the patch.  A question though...on the beagle, there is a 
> OMAP register GPIO_IRQSTATUSx that I am not manually clearing out.  
> This is the only place to ack an irq I know of...I assumed that was 
> being handled by the kernel?  Or is this what the patch is adding??  
> I'm very new to writing irq handlers, as you can tell!
>
> Honestly, all that's in my current handler is this:
>
> int irqdrv_rtdm_isr(rtdm_irq_t* handle) {
> 	return(RTDM_IRQ_HANDLED);
> }
>
> And here's the register func:
>
> if ((err = rtdm_irq_request(&irqdrv_isr_handle, irqno, 
> irqdrv_rtdm_isr, RTDM_IRQTYPE_EDGE, IRQDRV_NAME, NULL)) == 0)
>     rtdm_irq_enable(&irqdrv_isr_handle);
>
> And I'm running against a square waveform and getting this:
>
> [   56.522948] WARNING: at kernel/softirq.c:137
> __local_bh_enable+0x44/0xac()
> [   56.530153] Modules linked in: vme_pd_drv
> [   56.534399] [<c00566fc>] (unwind_backtrace+0x0/0xe0) from [<c007db0c>]
> (warn_slowpath_common+0x4c/0x64)
> [   56.574419] [<c007db0c>] (warn_slowpath_common+0x4c/0x64) from
> [<c007db3c>] (warn_slowpath_null+0x18/0x1c)
> [   56.584568] [<c007db3c>] (warn_slowpath_null+0x18/0x1c) from
[<c0083138>]
> (__local_bh_enable+0x44/0xac)
> [   56.594425] [<c0083138>] (__local_bh_enable+0x44/0xac) from
[<c008481c>]
> (irq_enter+0x44/0x60)
> [   56.623476] [<c008481c>] (irq_enter+0x44/0x60) from [<c0046018>]
> (asm_do_IRQ+0x18/0x98)
> [   56.631880] [<c0046018>] (asm_do_IRQ+0x18/0x98) from [<c00b9af0>]
> (__ipipe_sync_stage+0x154/0x188)

Make sure to have CONFIG_IPIPE_DEBUG_INTERNAL enabled in your kernel config
btw, this might help.

Gilles, I wonder whether this backtrace could not be the sign of a demux ISR
not going through ipipe_handle_chained_irq()?

>
>
>
>
> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Friday, January 20, 2012 12:32 PM
> To: Terry Fryar
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] rtdm difficulties
>
> On 01/20/2012 07:24 PM, Terry Fryar wrote:
>> Yeh, omap and gpio.....edge irq from a square wave pulse....
>
> Try this patch:
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c 
> index 30cb7d4..114ccf0 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -1272,7 +1272,7 @@ static void gpio_irq_handler(unsigned int irq, 
> struct irq_desc *desc)
>   	u32 retrigger = 0;
>   	int unmasked = 0;
>
> -	desc->irq_data.chip->irq_ack(&desc->irq_data);
> +	desc->irq_data.chip->irq_mask_ack(&desc->irq_data);
>
>   	bank = get_irq_data(irq);
>   #ifdef CONFIG_ARCH_OMAP1
>


--
Philippe.


