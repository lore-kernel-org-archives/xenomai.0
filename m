Message-ID: <50A67BB8.2070903@xenomai.org>
Date: Fri, 16 Nov 2012 18:45:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1352989143-32531-1-git-send-email-stefan.roese@gmail.com>
In-Reply-To: <1352989143-32531-1-git-send-email-stefan.roese@gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: stefan.roese@gmail.com
Cc: Stefan Roese <sr@denx.de>, xenomai@xenomai.org

On 11/15/2012 03:19 PM, stefan.roese@gmail.com wrote:
> +/*
> + * NO_DMA:
> + *
> + * Define to enable memcpy() for blockdata transfer instead of DMA
> + * support. This is available only for test purposes. Should be disabled
> + * or even removed in the final driver version.
> + */
> +#if 0
> +#define NO_DMA
> +#endif
> +
> +/*
> + * PRINT_READ_TIME:
> + *
> + * Print min and max times consumed by the blockdata transfer, either
> + * per DMA or per memcpy. Should be disbaled or even removed in the
> + * final driver version.
> + */
> +#if 1
> +#define PRINT_READ_TIME
> +#endif
> +
> +/*
> + * DEBUG:
> + *
> + * Define to print debug informations. Should be disabled in the
> + * final driver of course.
> + */
> +#if 0
> +#define DEBUG
> +#endif

This is dead code, please use Kconfig or remove the dead code entirely.

> +	/*
> +	 * Block until the blockdata is completely read into
> +	 * the buffer (done in interrupt)
> +	 */
> +	ret = rtdm_event_timedwait(&fpga_ctx->read_event,
> +				   fpga_ctx->info->timeout, NULL);
> +
> +	/*
> +	 * Mark blockdata as read
> +	 */
> +	fpga_ctx->blockdata_ready = 0;
> +
> +	if (ret)
> +		return ret;

You set blockdata_ready whatever the return value of
rtdm_event_timedwait so, what if rtdm_event_timedwait fails?
and you do it without any kind of mutual exclusion, so, what if another
thread or an irq is doing something between the call to
rtdm_event_timedwait and the moment where that variable is set to 0?


-- 
					    Gilles.

