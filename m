References: <20171106094646.28769-1-christoph.muellner@theobroma-systems.com>
 <20171106094646.28769-2-christoph.muellner@theobroma-systems.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <72e1f7b8-a609-edac-5709-bed9d2fea325@xenomai.org>
Date: Thu, 9 Nov 2017 11:00:09 +0100
MIME-Version: 1.0
In-Reply-To: <20171106094646.28769-2-christoph.muellner@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [PATCH v2 1/3] cobalt: rtdm: Add function
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

On 11/06/2017 10:46 AM, Christoph Muellner wrote:
> This patch adds a RTDM API to set a IRQ's CPU affinity.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> ---
>  include/cobalt/kernel/rtdm/driver.h |  6 ++++++
>  kernel/cobalt/rtdm/drvlib.c         | 18 ++++++++++++++++++
>  2 files changed, 24 insertions(+)
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

At the end of the day, we should be passing cpumasks by address only.

So, in order to preserve this new routine from future change regarding
the cpumask argument once ipipe_set_irq_affinity() (or its successor) is
fixed, what about receiving a pointer to cpumask_t instead, fixing the
signature of xnintr_affinity() along the way too? The latter belongs to
the internal Cobalt API, we have no backward compatibility issue there.

-- 
Philippe.

