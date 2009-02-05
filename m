Message-ID: <498B12E4.6010001@domain.hid>
Date: Thu, 05 Feb 2009 17:25:08 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4B3F8896E1733D4787DDB0EA1C7FF91F6B58D5@domain.hid>
	<4988830A.7070800@domain.hid>
	<4B3F8896E1733D4787DDB0EA1C7FF91F6B58DC@ukmail.uk.wirelessworld.airvananet.com>
	<498B0BC5.3060808@domain.hid>
	<4B3F8896E1733D4787DDB0EA1C7FF91F704346@domain.hid>
In-Reply-To: <4B3F8896E1733D4787DDB0EA1C7FF91F704346@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ reservation and config
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
To: Mike McTernan <mmcternan@domain.hid>
Cc: xenomai@xenomai.org

Mike McTernan wrote:
>> Mike McTernan wrote:
>>> Hi,
>>>
>>> Right - I want the interrupt to be handled in realtime.
>>>
>>> Is there a way to configure the interrupt as level sensitive under
>>> Xenomai?  I can't see how to do it, hence the thought of using
>>> request_irq(), which can do that.
>>>
>> rtdm_irq_request() assumes that the platform-dependent code did set
> the
>> correct IRQ type/sense already.
> 
> Cool.  So I think you are saying it is valid to first request_irq() to
> setup and config the interrupt, then hook it with rtdm_irq_request() for
> the realtime handler afterwards. 
>

Yes; the IRQ could even be freed right away, since you only want request_irq()
to set the IRQ sense, and free_irq() won't undo anything.

> I was unsure about mixing calls to the rtdm with the normal APIs, but it
> sounds like in this case it is not a problem and the recommended method.
> 

I would say that the recommended method is rather to have the BSP code do
whatever is needed to set the damn thing properly, but if it does not, plan B
may be to count on request_irq() to call the set_type() callback of the related
interrupt chip for the IRQ in question. That should work (Famous Last Words).

> Many Thanks,
> 
> Mike
> 
> 


-- 
Philippe.

