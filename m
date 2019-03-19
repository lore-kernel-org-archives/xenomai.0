Subject: Re: [PATCH] kernel: cobalt: replace access_ok with corresponding
 wrappers
References: <20190311143722.21320-1-roman.stratiienko@globallogic.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7e3568e9-a3b2-acce-79d8-ace79b4929ad@siemens.com>
Date: Tue, 19 Mar 2019 21:03:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190311143722.21320-1-roman.stratiienko@globallogic.com>
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
To: roman.stratiienko@globallogic.com, xenomai@xenomai.org

On 11.03.19 15:37, roman.stratiienko--- via Xenomai wrote:
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> Use access_wok / access_rok wrappers to enable support for kernel v5.0
> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> ---
> 
> This patch is also required to support v5.0
> 
>   kernel/cobalt/pipe.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cobalt/pipe.c b/kernel/cobalt/pipe.c
> index 0b8f8cbf8..16e85125c 100644
> --- a/kernel/cobalt/pipe.c
> +++ b/kernel/cobalt/pipe.c
> @@ -28,6 +28,7 @@
>   #include <linux/device.h>
>   #include <linux/uaccess.h>
>   #include <asm/io.h>
> +#include <asm/xenomai/syscall.h>
>   #include <cobalt/kernel/sched.h>
>   #include <cobalt/kernel/heap.h>
>   #include <cobalt/kernel/pipe.h>
> @@ -795,7 +796,7 @@ static ssize_t xnpipe_read(struct file *file,
>   	ssize_t ret;
>   	spl_t s;
>   
> -	if (!access_ok(VERIFY_WRITE, buf, count))
> +	if (!access_wok(buf, count))
>   		return -EFAULT;
>   
>   	xnlock_get_irqsave(&nklock, s);
> @@ -903,7 +904,7 @@ static ssize_t xnpipe_write(struct file *file,
>   	if (count == 0)
>   		return 0;
>   
> -	if (!access_ok(VERIFY_READ, buf, count))
> +	if (!access_rok(buf, count))
>   		return -EFAULT;
>   
>   	xnlock_get_irqsave(&nklock, s);
> 

And this one is in now as well.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

