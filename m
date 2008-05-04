Message-ID: <481D77E7.4010402@domain.hid>
Date: Sun, 04 May 2008 10:46:31 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <d3c1a9c622573.481ade4e@domain.hid>
In-Reply-To: <d3c1a9c622573.481ade4e@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] MSI Interrupt Crash
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: thomasschaefer@domain.hid
Cc: xenomai@xenomai.org

Thomas Schaefer wrote:
>> -----Original Message-----
> 
>> From: Philippe Gerum [mailto:philippe.gerum@domain.hid] On Behalf Of
> 
>> Philippe Gerum
> 
>> Sent: Friday, May 02, 2008 8:02 AM
> 
>> To: Thomas Schaefer
> 
>> Cc: Jeff Koftinoff; xenomai@xenomai.org
> 
>> Subject: Re: [Xenomai-help] MSI Interrupt Crash
> 
>>
> 
>> Thomas Schaefer wrote:
> 
>> >
> 
>> >> Does this help?
> 
>> >>
> 
>> >> --- include/asm-x86/wrappers_64.h    (revision 3719)
> 
>> >> +++ include/asm-x86/wrappers_64.h    (revision 3720)
> 
>> >> @@ -31,8 +31,8 @@
> 
>> >>  #define rthal_irq_descp(irq)        (irq_desc + irq)
> 
>> >>  #define rthal_irq_desc_status(irq)  (rthal_irq_descp(irq)->status)
> 
>> >>
> 
>> >> -#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip-
> 
>> >>> enable(irq); 0; })
> 
>> >> -#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip-
> 
>> >>> disable(irq); 0; })
> 
>> >> +#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip-
> 
>> >>> unmask(irq); 0; })
> 
>> >> +#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip-
> 
>> >>> mask(irq); 0; })
> 
>> >>  #define rthal_irq_chip_end(irq)      ({ rthal_irq_descp(irq)-
> 
>> >>> ipipe_end(irq, rthal_irq_descp(irq));
> 
>> >> 0; })
> 
>> >>
> 
>> >>  typedef irq_handler_t rthal_irq_host_handler_t;
> 
>> >
> 
>> > We are using the current version from the SVN repository and those
> 
>> > changes are already in there.
> 
>> >
> 
>>
> 
>> Please send the output back:
> 
>>
> 
>>
> 
>> --
> 
>> Philippe.
> 
>  
> 
> Here it is:
> 
>  
> 
> Xenomai: NULL unmask handler for irq 248, chip none

You are trying to use an interrupt which has been allocated by the kernel, but
for which it has not defined any controller (i.e. set_irq_chip()); in that case,
mask/unmask are left to NULL pointers in the default invalid controller struct,
hence the crash. Xenomai can only use interrupts for which a valid controller
exists. You may want to check why interrupt #248 is not completely initialized.

-- 
Philippe.

