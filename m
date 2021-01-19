Subject: Re: [PATCH 1/4] cobalt/kernel: add abstract inband work submission API
References: <20210117151133.478069-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <126ed98f-ee33-6958-d062-d9ae7872860f@siemens.com>
Date: Tue, 19 Jan 2021 14:46:33 +0100
MIME-Version: 1.0
In-Reply-To: <20210117151133.478069-1-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 17.01.21 16:11, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Provide an abstract interface for triggering work handlers on the
> in-band execution stage (aka "secondary mode" in the old jargon),
> which can be implemented using ipipe_post_root_work() from the I-pipe,
> or as a Dovetail-aware irq_work.
> 
> No functional change is introduced in the pre-existing code.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  .../kernel/ipipe/pipeline/inband_work.h       | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 include/cobalt/kernel/ipipe/pipeline/inband_work.h
> 
> diff --git a/include/cobalt/kernel/ipipe/pipeline/inband_work.h b/include/cobalt/kernel/ipipe/pipeline/inband_work.h
> new file mode 100644
> index 000000000..12ef07b00
> --- /dev/null
> +++ b/include/cobalt/kernel/ipipe/pipeline/inband_work.h
> @@ -0,0 +1,32 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2019 Philippe Gerum  <rpm@xenomai.org>
> + */
> +
> +#ifndef _COBALT_KERNEL_IPIPE_INBAND_WORK_H
> +#define _COBALT_KERNEL_IPIPE_INBAND_WORK_H
> +
> +#include <linux/ipipe.h>
> +
> +/*
> + * This field must be named inband_work and appear first in the
> + * container work struct.
> + */
> +struct pipeline_inband_work {
> +	struct ipipe_work_header work;
> +};
> +
> +#define PIPELINE_INBAND_WORK_INITIALIZER(__work, __handler)		\
> +	{								\
> +		.work = {						\
> +			.size = sizeof(__work),				\
> +			.handler = (void (*)(struct ipipe_work_header *)) \
> +			__handler,					\
> +		},							\
> +	}
> +
> +#define pipeline_post_inband_work(__work)	\
> +	ipipe_post_work_root(__work, inband_work.work)
> +
> +#endif /* !_COBALT_KERNEL_IPIPE_INBAND_WORK_H */
> 

All 4 applied to next.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

