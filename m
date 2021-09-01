Subject: Re: [PATCH] driver/gpio: gpio-cherryview: call correct api to remove
 gpio device
References: <20210901052121.15500-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d1db2a69-3604-75f9-8c2a-f9855d084b9d@siemens.com>
Date: Wed, 1 Sep 2021 08:33:03 +0200
MIME-Version: 1.0
In-Reply-To: <20210901052121.15500-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset=utf-8
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 01.09.21 07:21, Hongzhan Chen via Xenomai wrote:
> call correct api to remove gpio device.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/kernel/drivers/gpio/gpio-cherryview.c b/kernel/drivers/gpio/gpio-cherryview.c
> index 826faff3a..1234a3e12 100644
> --- a/kernel/drivers/gpio/gpio-cherryview.c
> +++ b/kernel/drivers/gpio/gpio-cherryview.c
> @@ -35,7 +35,7 @@ module_init(cherryview_gpio_init);
>  
>  static void __exit cherryview_gpio_exit(void)
>  {
> -	rtdm_gpiochip_remove(RTDM_SUBCLASS_CHERRYVIEW);
> +	rtdm_gpiochip_remove_by_type(RTDM_SUBCLASS_CHERRYVIEW);
>  }
>  module_exit(cherryview_gpio_exit);
>  
> 

Oh, indeed. Please send a new version of the affected commit (top of
next right now anyway). And please also update the kernel configs for CI
(xenomai/.gitlab-ci.yml) at this chance so that this new driver is built
whenever possible.

We may also want to enable it in xenomai-images eventually.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

