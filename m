Subject: Re: [PATCH] cobalt/rtdm: add explicit declaration of function
 rtdm_nrtsig_init
References: <20200917024947.30859-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a874073a-09a7-ffe9-b2e2-a3f830ae8c47@siemens.com>
Date: Thu, 17 Sep 2020 13:44:37 +0200
MIME-Version: 1.0
In-Reply-To: <20200917024947.30859-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hongzha1 <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 17.09.20 04:49, hongzha1 wrote:
> fix implicit declaration of function error when compile other cobalt
> drivers calling rtdm_nrtsig_init
> 
> ---
> this patch is for wip/dovetail branch
> 
> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

Signed off needs to be above the "---" separator.

> 
> diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
> index 2f10fa797..70bea02be 100644
> --- a/include/cobalt/kernel/rtdm/driver.h
> +++ b/include/cobalt/kernel/rtdm/driver.h
> @@ -902,6 +902,9 @@ struct rtdm_nrtsig {
>   	struct irq_work irq_work;
>   };
>   
> +int rtdm_nrtsig_init(rtdm_nrtsig_t *nrt_sig, rtdm_nrtsig_handler_t handler,
> +		void *arg);
> +
>   void rtdm_schedule_nrt_work(struct work_struct *lostage_work);
>   /** @} rtdm_nrtsignal */
>   
> 

Thanks, applied.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

