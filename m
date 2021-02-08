Subject: Re: [PATCH 09/18] cobalt/thread: dovetail: define out-of-band state
 accessors
References: <20210207160434.2869121-1-rpm@xenomai.org>
 <20210207160434.2869121-9-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9be9fa4b-2671-bacd-e993-5f7910ec7c9b@siemens.com>
Date: Mon, 8 Feb 2021 20:03:43 +0100
MIME-Version: 1.0
In-Reply-To: <20210207160434.2869121-9-rpm@xenomai.org>
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

On 07.02.21 17:04, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  .../cobalt/kernel/dovetail/pipeline/thread.h  | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 include/cobalt/kernel/dovetail/pipeline/thread.h
> 
> diff --git a/include/cobalt/kernel/dovetail/pipeline/thread.h b/include/cobalt/kernel/dovetail/pipeline/thread.h
> new file mode 100644
> index 000000000..1e6b0f091
> --- /dev/null
> +++ b/include/cobalt/kernel/dovetail/pipeline/thread.h
> @@ -0,0 +1,27 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2019 Philippe Gerum  <rpm@xenomai.org>
> + */
> +
> +#ifndef _COBALT_KERNEL_DOVETAIL_THREAD_H
> +#define _COBALT_KERNEL_DOVETAIL_THREAD_H
> +
> +#include <linux/dovetail.h>
> +
> +struct xnthread;
> +
> +#define cobalt_threadinfo oob_thread_state
> +
> +static inline struct cobalt_threadinfo *pipeline_current(void)
> +{
> +	return dovetail_current_state();
> +}
> +
> +static inline
> +struct xnthread *pipeline_thread_from_task(struct task_struct *p)
> +{
> +	return dovetail_task_state(p)->thread;
> +}
> +
> +#endif /* !_COBALT_KERNEL_DOVETAIL_THREAD_H */
> 

Applied up to here to next.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

