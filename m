Message-ID: <45055475.2050705@domain.hid>
Date: Mon, 11 Sep 2006 14:20:05 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] No hardware interrupts with xenomai on ppc405
References: <4503EB88.2040309@domain.hid>
	<200609111058.44417.matthias.fuchs@domain.hid>
	<1157970027.4934.6.camel@domain.hid>
	<200609111402.12493.matthias.fuchs@domain.hid>
In-Reply-To: <200609111402.12493.matthias.fuchs@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Matthias Fuchs <matthias.fuchs@domain.hid>
Cc: xenomai@xenomai.org

Matthias Fuchs wrote:
> Hello Philippe,
> 
> that helps. I will do some further testing.
> 
> Matthias
> 
> 
> On Monday 11 September 2006 12:20, Philippe Gerum wrote:
>> It's likely an Adeos issue. Could you try this patch? TIA,
>>
>> --- arch/ppc/syslib/ppc4xx_pic.c~	2005-10-28 02:02:08.000000000 +0200
>> +++ arch/ppc/syslib/ppc4xx_pic.c	2006-09-11 12:18:14.000000000 +0200
>> @@ -72,7 +72,8 @@
>>  		mtdcr(DCRN_UIC_SR(UIC##n), mask);			\
>>  		ACK_UIC##n##_PARENT					\
>>  	}								\
>> -	if (!(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {		\
>> +	if (!ipipe_root_domain_p ||					\
>> +	    !(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {		\
>>  		ppc_cached_irq_mask[n] |= mask;				\
>>  		mtdcr(DCRN_UIC_ER(UIC##n), ppc_cached_irq_mask[n]);	\
>>  	}								\
> 

Philippe, could you please explain the problem in more detail? And what 
are the consequences for other PowerPC ARCs and PICs, also for Linux 2.4?

Thanks.

Wolfgang.


