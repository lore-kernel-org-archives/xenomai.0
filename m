Message-ID: <4A27AF25.8050108@domain.hid>
Date: Thu, 04 Jun 2009 13:25:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <325d766d0906040408w7d9712a0gb8927529796a3913@domain.hid>
	<4A27ACEA.6010500@domain.hid>
In-Reply-To: <4A27ACEA.6010500@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Support for Atmel AT91SAM9G20 processor
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: martin mangard <dothemango@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> martin mangard wrote:
>> Hello
>>
>> I made a patch in order to support the Atmel AT91SAM9G20 processor,
>> which has to be applied after the "adeos-ipipe-2.6.27-arm-*" patch.
>> Due to the similarities between the AT91SAM9260 and the AT91SAM9G20
>> processor, only a few changes were necessary. I booted the system on a
>> "AT91SAM9G20-EK" development
>> board and executed "latencytest" and "clocktest". Are there plans to
>> officially support this processor in the future?
> 
> Well, now that you sent the patch, this should be included in the next
> adeos patch. However:
> - your mailer mangled the patch, so I can not apply it, please configure
> your mailer to avoid mangling the patch, or if that is not possible,
> send the patch as attachment;
> -  there is one change in your patch that I do not like:
> 
>>  #ifdef CONFIG_ARCH_AT91SAM9260
>>  #define cpu_is_at91sam9xe()    (at91_arch_identify() == ARCH_FAMILY_AT91SAM9XE)
>> -#define cpu_is_at91sam9260()   ((at91_cpu_identify() ==
>> ARCH_ID_AT91SAM9260) || cpu_is_at91sam9xe())
>> +#define cpu_is_at91sam9260()   ((at91_cpu_identify() ==
>> ARCH_ID_AT91SAM9260) || cpu_is_at91sam9xe() ||
>> (at91_cpu_identify()==ARCH_ID_AT91SAM9G20)))
> 
> You are touching mailine code here. It this patch is really needed by
> mainline, then post it to the linux arm kernel mailing list.
> 

Also, please send it as a patch to the current kernel i.e. 2.6.29.

-- 
					    Gilles.

