Subject: Re: [PATCH 20/32] x86: fix include for drivers
References: <20180925103809.4932-1-rpm@xenomai.org>
 <20180925103809.4932-21-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <42a8d3eb-b06e-5514-949a-7fe7dd16b3e9@siemens.com>
Date: Tue, 2 Jul 2019 17:57:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180925103809.4932-21-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org, Henning Schild <henning.schild@siemens.com>

On 25.09.18 12:37, Philippe Gerum wrote:
> From: Henning Schild <henning.schild@siemens.com>
> 
> ---
>   include/linux/gpio.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/gpio.h b/include/linux/gpio.h
> index 8ef7fc0ce0f0..41554f9e098d 100644
> --- a/include/linux/gpio.h
> +++ b/include/linux/gpio.h
> @@ -3,6 +3,7 @@
>   #define __LINUX_GPIO_H
>   
>   #include <linux/errno.h>
> +#include <linux/ipipe.h>
>   
>   /* see Documentation/gpio/gpio-legacy.txt */
>   
> 

Where did this come from? It's also incorrectly tagged as "x86", though it's 
touching generic code.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

