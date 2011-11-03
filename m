Message-ID: <4EB2B58F.3070600@domain.hid>
Date: Thu, 03 Nov 2011 16:38:55 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20111102201210.GY30117@domain.hid>	<4EB1B691.9020801@domain.hid>
	<20111103151353.GB30117@domain.hid>
In-Reply-To: <20111103151353.GB30117@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] irq related kernel crash with adeos 3.0.4 powerpc.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Lennart Sorensen <lsorense@domain.hid>
Cc: adeos-main@gna.org

On 11/03/2011 04:13 PM, Lennart Sorensen wrote:
> On Wed, Nov 02, 2011 at 10:30:57PM +0100, Philippe Gerum wrote:
>> Does this help? If not, then your .config would be welcome.
>>
>> diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
>> index 707d297..c1e0b7e 100644
>> --- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
>> +++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
>> @@ -257,6 +257,9 @@ static struct irq_chip qe_ic_irq_chip = {
>>   	.irq_unmask = qe_ic_unmask_irq,
>>   	.irq_mask = qe_ic_mask_irq,
>>   	.irq_mask_ack = qe_ic_mask_irq,
>> +#ifdef CONFIG_IPIPE
>> +	.irq_eoi = qe_ic_mask_irq,
>> +#endif
>>   };
>>
>>   static int qe_ic_host_match(struct irq_host *h, struct device_node *node)
> 
> No, that unfortunately didn't help.
> 
> So here is the capture of the entire boot, and the .config file I am using.
> 

Thanks. Meanwhile you may want to try this one. This is aimed at fixing an issue with acking
cascaded IPIC irqs over the pipeline.

http://download.gna.org/adeos/patches/v3.x/powerpc/adeos-ipipe-3.0.8-powerpc-2.13-04.patch

> 
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.

