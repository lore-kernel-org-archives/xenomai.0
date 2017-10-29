References: <20171023145944.11262-1-christoph.muellner@theobroma-systems.com>
 <20171023145944.11262-2-christoph.muellner@theobroma-systems.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <25908224-f350-f057-bdab-ecba63b9a762@xenomai.org>
Date: Sun, 29 Oct 2017 18:29:44 +0100
MIME-Version: 1.0
In-Reply-To: <20171023145944.11262-2-christoph.muellner@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/3] cobalt: rtdm: Add function
 rtdm_irq_affinity().
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Christoph Muellner <christoph.muellner@theobroma-systems.com>, xenomai@xenomai.org

On 10/23/2017 04:59 PM, Christoph Muellner wrote:
> This patch adds a RTDM API to set a IRQ's CPU affinity.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> ---
>  include/cobalt/kernel/rtdm/driver.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
> index 0c7b62e75..803cdbfe4 100644
> --- a/include/cobalt/kernel/rtdm/driver.h
> +++ b/include/cobalt/kernel/rtdm/driver.h
> @@ -874,6 +874,12 @@ static inline int rtdm_irq_disable(rtdm_irq_t *irq_handle)
>  	xnintr_disable(irq_handle);
>  	return 0;
>  }
> +
> +static inline int rtdm_irq_affinity(rtdm_irq_t *irq_handle, cpumask_t tgt)
> +{
> +	xnintr_affinity(irq_handle, tgt);
> +	return 0;
> +}
>  #endif /* !DOXYGEN_CPP */
>  
>  /* --- non-real-time signalling services --- */
> 

A bit of documentation is missing in drvlib.c for this new call (could
follow the doc for rtdm_irq_disable() there).

-- 
Philippe.

