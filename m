Subject: Re: [PATCH V3 1/3] rtdm/testing: latmus: introduce latmus driver
References: <20210421050509.31420-1-hongzhan.chen@intel.com>
 <20210421050509.31420-2-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bda1f940-8d6d-25c3-3947-3117c89d998d@siemens.com>
Date: Thu, 20 May 2021 17:54:03 +0200
MIME-Version: 1.0
In-Reply-To: <20210421050509.31420-2-hongzhan.chen@intel.com>
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
To: hongzha1 <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 21.04.21 07:05, hongzha1 via Xenomai wrote:
> To support the latmus application for determining the best
> gravity values for the cobalt core clock, and measuring
> the response time to timer events.
> 
> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
> ---
>  include/rtdm/uapi/testing.h     |   63 ++
>  kernel/drivers/testing/Kconfig  |   10 +
>  kernel/drivers/testing/Makefile |    3 +
>  kernel/drivers/testing/latmus.c | 1237 +++++++++++++++++++++++++++++++
>  4 files changed, 1313 insertions(+)
>  create mode 100644 kernel/drivers/testing/latmus.c
> 

...

> diff --git a/kernel/drivers/testing/latmus.c b/kernel/drivers/testing/latmus.c
> new file mode 100644
> index 000000000..bef662260
> --- /dev/null
> +++ b/kernel/drivers/testing/latmus.c
> @@ -0,0 +1,1237 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + *
> + * Derived from Xenomai Cobalt's autotune driver, https://xenomai.org/
> + * Copyright (C) 2014, 2018 Philippe Gerum  <rpm@xenomai.org>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/sort.h>
> +#include <linux/cdev.h>
> +#include <linux/fs.h>
> +#include <linux/fcntl.h>
> +#include <cobalt/kernel/pipe.h>
> +#include <cobalt/kernel/sched.h>
> +#include <rtdm/ipc.h>
> +#include <rtdm/testing.h>
> +#include <rtdm/driver.h>
> +#include <rtdm/compat.h>
> +
> +#define ONE_BILLION  1000000000
> +#define TUNER_SAMPLING_TIME	500000000UL
> +#define TUNER_WARMUP_STEPS	10
> +#define TUNER_RESULT_STEPS	40
> +
> +#define progress(__runner, __fmt, __args...)				\
> +	do {								\
> +		if ((__runner)->verbosity > 1)				\
> +			printk(XENO_INFO "latmus(%s) " __fmt "\n",	\
> +			       (__runner)->name, ##__args);		\
> +	} while (0)
> +
> +#define cobalt_init_xntimer_on_cpu(__timer, __cpu, __handler)		\
> +		rtdm_timer_init_on_cpu(__timer, __handler,		\
> +			#__handler, __cpu)

Why this wrapper? Why not calling rtdm_timer... directly?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

