Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907E15C7
	for <xenomai@lists.linux.dev>; Fri, 25 Nov 2022 13:01:51 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 7C9CC40011;
	Fri, 25 Nov 2022 13:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1669381304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7FOndyw4k5C1E3qB1v+qn3kV0G87fo8Af6V9Q0vX5qI=;
	b=Y097m+7O+P7oTaZTuwjBRMT4haHHVR+7kxGJpgmTcH5+MOAXyP8CN2XGisKXmIuWt9EmYN
	QR1mlLKC+iGQi5H3t3As8ikanUDIXIJxw/8s2/zqyjrIdQPo8IUX//niOHaf/tkiZTxqQ/
	jESMzS2eENGAl3Zo4DLdtK00ea4JTi/3tuJEkVb4avO63sucFXd6CiyD+UKbOpr2NDfay0
	EZmjlKofvAZnPlBi3KZOC43EEqJP18yab6+sNOr0hK+u58ZOsxYGVvLAcsGjqaCBzIZN34
	r+pfuiSQc1+0nCw4o9QOpCuH1yYmSa8/dJ73CzDkO0ntFjhdVy5oNIUk8uJQzw==
References: <20221125090834.617271-1-florian.bezdeka@siemens.com>
 <8e95dbd6-b120-11a0-8c30-ce4f29b1ec84@siemens.com>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev,
 Greg Gallagher <greg@embeddedgreg.com>
Subject: Re: [ipipe 4.19][RFC PATCH] ipipe: Do not report spurious
 interrupts by using printk
Date: Fri, 25 Nov 2022 13:59:16 +0100
In-reply-to: <8e95dbd6-b120-11a0-8c30-ce4f29b1ec84@siemens.com>
Message-ID: <878rjzmbm2.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 25.11.22 10:08, Florian Bezdeka wrote:
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>> 
>> Hi all,
>> 
>> I need this patch to get the Hikey board (part of the Xenomai CI lab) up
>> and running. The problem appeared when updating the test images from
>> Debian 11 to Debian 12 and with that from gcc 10 to gcc 12.
>> 
>> My understanding is:
>>  - During boot a UART hangup occurs, so we release the IRQ
>>  - While that happens there is still on IRQ in flight on a different CPU
>>  - The in-flight IRQ is detected as spurious interrupt
>>  - We try to report that using printk()
>> 
>> printk() internally calls ipipe_unstall_root() - by using one of the 
>> _irqrestore() macros/functions - which unconditionally calls 
>> hard_local_irq_enable() so HW IRQs are enabled now.
>> 
>> I end up in an IRQ stack overflow.
>> 
>> I assume this happens because the UART IRQ is a level-triggered IRQ. So
>> it simply fires again.
>> 
>> Does that make sense?
>> 
>> How to fix that properly? Ideas welcome...
>> 
>> The problem can be reproduced on the hikey board quite well. Nearly
>> every boot ends up in the IRQ stack overflow.
>> 
>> Best regards,
>> Florian
>>  
>> 
>>  kernel/ipipe/core.c | 2 +-
>>  kernel/irq/handle.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
>> index d12e71103424..17ad6f2841f9 100644
>> --- a/kernel/ipipe/core.c
>> +++ b/kernel/ipipe/core.c
>> @@ -1491,7 +1491,7 @@ void __ipipe_dispatch_irq(unsigned int irq, int flags) /* hw interrupts off */
>>  
>>  #ifdef CONFIG_IPIPE_DEBUG
>>  	if (irq >= IPIPE_NR_IRQS) {
>> -		pr_err("I-pipe: spurious interrupt %u\n", irq);
>> +		//pr_err("I-pipe: spurious interrupt %u\n", irq);
>>  		return;
>>  	}
>>  #endif
>> diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
>> index e2f7afcb1ae6..1c3221c72977 100644
>> --- a/kernel/irq/handle.c
>> +++ b/kernel/irq/handle.c
>> @@ -32,7 +32,7 @@ void handle_bad_irq(struct irq_desc *desc)
>>  {
>>  	unsigned int irq = irq_desc_get_irq(desc);
>>  
>> -	print_irq_desc(irq, desc);
>> +	//print_irq_desc(irq, desc);
>>  	kstat_incr_irqs_this_cpu(desc);
>>  	ack_bad_irq(irq);
>>  }
>
> Is this issue 4.19-specific, resolved in 5.4? Or in dovetail?

Dovetail has no such issue because unstalling the in-band stage does not
re-enable hard irqs.

-- 
Philippe.
