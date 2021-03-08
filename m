Subject: Re: [PATCH 8/8] cobalt/assert: remove extraneous header inclusion
References: <20210220124527.401015-1-rpm@xenomai.org>
 <20210220124527.401015-8-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a65ae718-2920-2a0f-8f15-4418909f724e@siemens.com>
Date: Mon, 8 Mar 2021 12:28:07 +0100
MIME-Version: 1.0
In-Reply-To: <20210220124527.401015-8-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 20.02.21 13:45, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> In the same move, fix places which depend on such inclusion but fail
> to pull the related headers directly.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  include/cobalt/kernel/assert.h | 3 ---
>  kernel/cobalt/heap.c           | 1 +
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/cobalt/kernel/assert.h b/include/cobalt/kernel/assert.h
> index 8d004476b..abe044100 100644
> --- a/include/cobalt/kernel/assert.h
> +++ b/include/cobalt/kernel/assert.h
> @@ -20,9 +20,6 @@
>  #define _COBALT_KERNEL_ASSERT_H
>  
>  #include <linux/kconfig.h>
> -#include <pipeline/pipeline.h>
> -#include <cobalt/kernel/trace.h>
> -#include <cobalt/kernel/ancillaries.h>
>  
>  #define XENO_INFO	KERN_INFO    "[Xenomai] "
>  #define XENO_WARNING	KERN_WARNING "[Xenomai] "
> diff --git a/kernel/cobalt/heap.c b/kernel/cobalt/heap.c
> index 5d14a4739..9e184d4c3 100644
> --- a/kernel/cobalt/heap.c
> +++ b/kernel/cobalt/heap.c
> @@ -27,6 +27,7 @@
>  #include <cobalt/kernel/assert.h>
>  #include <cobalt/kernel/heap.h>
>  #include <cobalt/kernel/vfile.h>
> +#include <cobalt/kernel/ancillaries.h>
>  
>  /**
>   * @ingroup cobalt_core
> 

Thanks, all 8 applied to next, testing now.

Please make sure to address my minor remarks when touching the
placeholder files in upcoming patches.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

