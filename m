Message-ID: <e24f9de7-7170-5c5e-cb8f-07c778b67c21@siemens.com>
Date: Thu, 17 Feb 2022 16:12:54 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] ipipe: Fix ipipe level irq end
Content-Language: en-US
References: <94f8dc12-d019-4736-2423-bfacc6b3b0b2@siemens.com>
 <20220217084830.712756-1-gunter.grau@philips.com>
 <dddc8d33-0379-eb0c-f994-264a20bef4e6@siemens.com>
 <CALLqZ8QTq+g7pLx_L68K76ez1XJum8-OkjbC9RJP7tW-VaxdEA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CALLqZ8QTq+g7pLx_L68K76ez1XJum8-OkjbC9RJP7tW-VaxdEA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Gunter Grau <gunter.grau@philips.com>, xenomai@xenomai.org

On 17.02.22 15:11, Greg Gallagher wrote:
> 
> 
> On Thu, Feb 17, 2022 at 4:15 AM Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     On 17.02.22 09:48, Gunter Grau via Xenomai wrote:
>     > The following commit in the vanilla kernel introduced
>     > a check for the cached interrupt mask flag in mask_irq():
>     >
>     > bf22ff45bed6 ("genirq: Avoid unnecessary low level irq function
>     calls")
>     >
>     > This means if the flag is not serviced correctly
>     > the real bit in the hardware interrupt controller may not be
>     > cleared or set.
>     > The __ipipe_end_level_irq() function does not follow this rule.
>     > It unmasks the bit in the hardware without setting the cached flags
>     > accordingly. So after the first level interrupt is finished the
>     > mask cache has a wrong state. If now the next interrupt fires,
>     > the mask_irq() function will not really mask the interrupt in
>     > the hardware which causes a interrupt storm after reenabeling
>     > the hard irqs.
>     > The fix now also updates the shadow flag correctly.
>     > ---
>     >  kernel/irq/chip.c | 1 +
>     >  1 file changed, 1 insertion(+)
>     >
>     > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>     > index 7c03e2931189..ff9a8b3f33db 100644
>     > --- a/kernel/irq/chip.c
>     > +++ b/kernel/irq/chip.c
>     > @@ -988,6 +988,7 @@ void __ipipe_ack_level_irq(struct irq_desc *desc)
>     >  void __ipipe_end_level_irq(struct irq_desc *desc)
>     >  {
>     >         desc->irq_data.chip->irq_unmask(&desc->irq_data);
>     > +       irq_state_clr_masked(desc);
>     >  }
>     >
>     >  void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)
>     > --
>     > 2.25.1
>     >
> 
>     Thanks, applied to ipipe-noarch. I had to do that manually as you email
>     client managed the patch (tabs->spaces, trailing spaces removed). Use
>     git-send-email or a client that avoids this mangling.
> 
>     Greg, I will apply this to ipipe-x86 (4.19-cip and 5.4), could you do
>     the same for arm and arm64?
> 
>     Thanks,
>     Jan
> 
>     -- 
>     Siemens AG, Technology
> 
> 
>     Competence Center Embedded Linux
> 
> 
> Yep, I’ve applied the patch locally, I’ll update arm and arm64 shortly.
> 

Just force-updated ipipe/noarch to have Gunter's address and signed-off
fixed up. Please use that version.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

