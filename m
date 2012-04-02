Message-ID: <4F79C007.9080700@domain.hid>
Date: Mon, 02 Apr 2012 17:04:39 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4F7333E7.7030608@domain.hid> <4F7339A8.6060701@domain.hid>
	<4F735716.4020508@domain.hid>
In-Reply-To: <4F735716.4020508@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt latency greater than 250ms. Question.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Makarand Pradhan <makarandpradhan@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/28/2012 08:23 PM, Makarand Pradhan wrote:
> Hi Philippe,
>
> On 28/03/12 12:17 PM, Philippe Gerum wrote:
>> The log says your code wants to control when the IRQ is enabled again,
>> by calling rt_intr_enable() from userland. I guess you are setting
>> I_NOAUTOENA too. Correct?
>
> That is correct. I_NOAUTOENA is used in rt_intr_create. Otherwise the
> level trigerred interrupt will not allow the userland processing of the
> int. The userland handler is very small and it unconditionally
> rt_intr_enables the intr.
>
> Testing indicates that the interrupt is always enabled from user space
> within 250 usec after kernel gets the interrupt.
>
> I have noted that unless I see "#end 0x0000002b" and a hit to the
> ipic_unmask_irq, the next interrupt is not processed.
>
> And this is getting delayed once in a while which causes a delay in
> processing the next interrupt.
>
> So the sequence of events leading to the problem is:
>
> 1. Get interrupt: #begin 0x0000002b noted in ipipe trace
> 2. Intr enabled from user space. Always happens roughly within 250usec.
> 3. #end 0x0000002b noted in ipipe trace where the int is unmasked by ipipe.
>
> When I see the problem, step 3 is delayed. I am trying to capture a
> trace where the begin, int enable and end are captured.
>
> Your thoughts on what might cause this delay would be appreciated.
>

Which IRQ are you re-enabling from user-space, the multiplexed IRQ 33, 
or the cascaded one you receive?

> Rgds,
> Mak.
>
>
>
>
>


-- 
Philippe.

