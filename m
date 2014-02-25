MIME-Version: 1.0
In-Reply-To: <CAK4EZFR_L+=-LtSVHkvZ36rPOA8ViVboB9M9rf4Yqk=crfBotw@mail.gmail.com>
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <CAK4EZFRN56pZkzmYwBpyupYkbj+V1mgYUPHk4YfLshSs-zFGGw@mail.gmail.com>
 <CAK4EZFTRhDxJkRdY7epTqQ=f0rpoK570uJckq4aOYnt7z6fzxA@mail.gmail.com>
 <CAEbDrgkAqAGWrap1156fiQnLiuBJ_P6NUdxQQQRBiLkDEKRwGQ@mail.gmail.com>
 <530A8767.4030004@xenomai.org>
 <CAEbDrgmf+RtS5gS5SKO7eq66ge-LHoJ0hTOC=yeRmUgk0MXqog@mail.gmail.com>
 <530BC103.3010809@xenomai.org>
 <CAEbDrgnFr7YvfoMmFQx=PBKSFEWvwJftx0wZx39ySMqRO2X6gQ@mail.gmail.com>
 <530CFB0D.8040001@xenomai.org>
 <CAEbDrgkJCnbWu_J4svoXOU1x2rz=n95A5+3Ee=R_9CpMgx-JmA@mail.gmail.com>
 <530CFC27.5050700@xenomai.org>
 <CAEbDrgnmM_dD3WX42PYawhkW8zTaYczzfozEe1EX7Z5HnERz3g@mail.gmail.com>
 <530D0205.9050406@xenomai.org>
 <CAEbDrgmwch94crHAcrbJDj9MxaiBNaYeLH2U9NtS0tuJKmdDDw@mail.gmail.com>
 <530D0BBD.6070704@xenomai.org>
 <CAK4EZFR_L+=-LtSVHkvZ36rPOA8ViVboB9M9rf4Yqk=crfBotw@mail.gmail.com>
Date: Tue, 25 Feb 2014 23:20:27 +0000
Message-ID: <CAEbDrgk=yrGq8KdpdN8e7RtO7qUpWTtwRXhrg0A0=KbDjqoDng@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

well, this does not work for me. It boots fine when there is no USB device
plugged in.
However, when my WIFI or bluetooth adapter is plugged in, the boot log
shows: http://pastebin.com/vjLJVDGS

I also tried the patch Adam suggests but it does not seem to affect
anything.



On 25 February 2014 22:30, Adam Vaughan <vaughana@umich.edu> wrote:

> I just tried the above patch and the warning doesn't show up at boot
> anymore.  I tried unplugging and plugging in a flash drive / keyboard and
> saw no issues in dmesg.
>
> I mentioned it in a previous email, but just as a friendly reminder this
> patch is still needed to allow you to boot with a disabled FIQ:
>
> diff --git a/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
> b/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
> index 19abea0..78172ea 100644
> --- a/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
> +++ b/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
> @@ -742,8 +742,10 @@ int32_t dwc_otg_hcd_handle_sof_intr(dwc_otg_hcd_t *
> hcd)
>     }
>
>     /* Clear interrupt */
> -   //gintsts.b.sofintr = 1;
> -   //DWC_WRITE_REG32(&hcd->core_if->core_global_regs->gintsts,
> gintsts.d32);
> +   if (!fiq_fix_enable) {
> +       gintsts.b.sofintr = 1;
> +       DWC_WRITE_REG32(&hcd->core_if->core_global_regs->gintsts,
> gintsts.d32);
> +   }
>
>     return 1;
>  }
>
>
> On Tue, Feb 25, 2014 at 4:31 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
>> On 02/25/2014 10:09 PM, Gregory Dymarek wrote:
>> > So the frame freeze I got on my version is on line 145 in here:
>> > https://github.com/raspberrypi/linux/blob/rpi-3.8.y/kernel/irq/handle.c
>> >
>> > The dwc_otg_hcd_handle_intr is here:
>> >
>> https://github.com/raspberrypi/linux/blob/rpi-3.8.y/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
>> >
>> >
>> > Is the line 523 the problem?
>> >     local_fiq_enable();
>>
>> Please try the following patch:
>>
>> diff --git a/arch/arm/include/asm/ipipe_hwirq.h
>> b/arch/arm/include/asm/ipipe_hwirq.h
>> index 6b864aa..bd8cda1 100644
>> --- a/arch/arm/include/asm/ipipe_hwirq.h
>> +++ b/arch/arm/include/asm/ipipe_hwirq.h
>> @@ -200,9 +200,9 @@ static inline void hard_local_irq_restore(unsigned
>> long x)
>>                 ipipe_unstall_root();                   \
>>         } while (0)
>>
>> -#define local_fiq_enable() ipipe_unstall_root()
>> +#define local_fiq_enable() hard_local_fiq_enable_notrace()
>>
>> -#define local_fiq_disable() ipipe_stall_root()
>> +#define local_fiq_disable() hard_local_fiq_disable_notrace()
>>
>>  #define arch_local_irq_restore(flags)                  \
>>         do {                                            \
>>
>>
>> --
>>                                                                 Gilles.
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>>
>
>
