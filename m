Message-ID: <50AC9EB4.1020705@gmail.com>
Date: Wed, 21 Nov 2012 10:28:20 +0100
From: Stefan Roese <stefan.roese@gmail.com>
MIME-Version: 1.0
References: <1353481805-28850-1-git-send-email-stefan.roese@gmail.com>
	<20121121090913.B53842003CF@gemini.denx.de>
In-Reply-To: <20121121090913.B53842003CF@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2] mpc5200: Add RTDM LPBFIFO driver and demo
 RTDM FPGA device driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Denk <wd@denx.de>
Cc: xenomai@xenomai.org

Hi Wolfgang,

On 11/21/2012 10:09 AM, Wolfgang Denk wrote:
> In message <1353481805-28850-1-git-send-email-stefan.roese@gmail.com> you wrote:
>>
>> This patch adds support for the RTDM LPB (LocalPlusBus) FIFO driver
>> for the MPC5200. It will be used for DMA support in an RTDM FPGA
>> device driver. This rt-fpga.c driver is a custom device driver,
>> but might be useful for other developers as well. Thats why I
>> included it here too.
> ...
>> --- /dev/null
>> +++ b/ksrc/drivers/mpc5200_dma/Config.in
>> @@ -0,0 +1,10 @@
>> +#
>> +# Xenomai configuration for Linux v2.4
> 
> Linux v2.4 ??? 
> 
> I am pretty sure this driver will not run with a 2.4 Linux kenrel...

Yes. I just put it in since all drivers in ksrc had it as well. Will
remove in the next version.

>> +#define dbg(format, arg...)						\
>> +	printk("%s (%d): " format, __func__, __LINE__, ##arg)
>> +#else
>> +#define dbg(format, arg...)						\
>> +do {									\
>> +	if (0)								\
>> +		printk("%s (%d): " format, __func__, __LINE__, ##arg);	\
>> +} while (0)
>> +#endif
> 
> Why do you define your own (incomaptible to everything else) debug
> facilities?  Can you not rather use the existing kernel debug
> macros?

I'll move to a common kernel debug function/macro in the next patch version.

>> +#ifdef PRINT_READ_TIME
> 
> I see no translation happening anywhere between PRINT_READ_TIME and
> CONFIG_XENO_DRIVERS_MPC5200_DMA_PRINT_READ_TIME - am I missing
> something?
> 
>> +#ifdef NO_DMA
> 
> Ditto for NO_DMA versus CONFIG_XENO_DRIVERS_MPC5200_DMA_NO_DMA ?

Good catch. I forgot to switch all occurrences of these defines. Will
fix in next version.

Thanks,
Stefan



