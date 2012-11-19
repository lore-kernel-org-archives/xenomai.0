Message-ID: <50AA2D11.2060505@gmail.com>
Date: Mon, 19 Nov 2012 13:58:57 +0100
From: Stefan Roese <stefan.roese@gmail.com>
MIME-Version: 1.0
References: <1352989143-32531-1-git-send-email-stefan.roese@gmail.com>
	<50A67BB8.2070903@xenomai.org>
In-Reply-To: <50A67BB8.2070903@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] mpc5200: Add RTDM LPBFIFO driver and demo
 RTDM FPGA device driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

On 11/16/2012 06:45 PM, Gilles Chanteperdrix wrote:
> On 11/15/2012 03:19 PM, stefan.roese@gmail.com wrote:
>> +/*
>> + * NO_DMA:
>> + *
>> + * Define to enable memcpy() for blockdata transfer instead of DMA
>> + * support. This is available only for test purposes. Should be disabled
>> + * or even removed in the final driver version.
>> + */
>> +#if 0
>> +#define NO_DMA
>> +#endif
>> +
>> +/*
>> + * PRINT_READ_TIME:
>> + *
>> + * Print min and max times consumed by the blockdata transfer, either
>> + * per DMA or per memcpy. Should be disbaled or even removed in the
>> + * final driver version.
>> + */
>> +#if 1
>> +#define PRINT_READ_TIME
>> +#endif
>> +
>> +/*
>> + * DEBUG:
>> + *
>> + * Define to print debug informations. Should be disabled in the
>> + * final driver of course.
>> + */
>> +#if 0
>> +#define DEBUG
>> +#endif
> 
> This is dead code, please use Kconfig or remove the dead code entirely.

Yes. Will move to Kconfig option.

>> +	/*
>> +	 * Block until the blockdata is completely read into
>> +	 * the buffer (done in interrupt)
>> +	 */
>> +	ret = rtdm_event_timedwait(&fpga_ctx->read_event,
>> +				   fpga_ctx->info->timeout, NULL);
>> +
>> +	/*
>> +	 * Mark blockdata as read
>> +	 */
>> +	fpga_ctx->blockdata_ready = 0;
>> +
>> +	if (ret)
>> +		return ret;
> 
> You set blockdata_ready whatever the return value of
> rtdm_event_timedwait so, what if rtdm_event_timedwait fails?

Even when rtdm_event_timedwait() fails (timeout) the blockdata_ready
flag needs to be reset. As it marks the last read access from the
application (task) to be finished. So re-setting it to 0 even in the
timeout case was done intentionally here.

> and you do it without any kind of mutual exclusion, so, what if another
> thread or an irq is doing something between the call to
> rtdm_event_timedwait and the moment where that variable is set to 0?

Only one thread can access the read function at a time (synchronized
with ctx->reading). So there can be no clashes with other read-threads
here. And the interrupt shall set the blockdata_ready flag upon the
cycle data interrupt. To signal new data ready for reading. So I don't
see where some synchronization method is needed here.

Thanks for the review,
Stefan



