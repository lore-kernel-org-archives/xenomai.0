Subject: Re: [PATCH] cobalt/dovetail: Resolve pipeline_clock_name TODO
References: <7724f1f3-85b7-4dcf-2993-d70ac49d5345@siemens.com>
 <MN2PR11MB428568233A7AABDF916DE243F2679@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c7886d5c-2839-71a0-a5cd-d1a02fd6150e@siemens.com>
Date: Tue, 30 Nov 2021 07:46:02 +0100
MIME-Version: 1.0
In-Reply-To: <MN2PR11MB428568233A7AABDF916DE243F2679@MN2PR11MB4285.namprd11.prod.outlook.com>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, Xenomai <xenomai@xenomai.org>

On 30.11.21 01:47, Chen, Hongzhan wrote:
> Hi Jan
> 
> What about following patch? Try to get clocksource name via sys fs.
> 
> From aa6fdc59a22f9b1ddca145c72a75f2aa1f776e85 Mon Sep 17 00:00:00 2001
> From: Hongzhan Chen <hongzhan.chen@intel.com>
> Date: Wed, 24 Nov 2021 02:08:27 -0500
> Subject: [PATCH] cobalt/clock: dovetail: get current clocksource name via sys
>  fs
> 
> Dovetail share the same clocksource that in-band is using. We try
> to get the name of current clocksource under sys filesystem.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
> index d8c94ab43..ffe4ad083 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/clock.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
> @@ -7,11 +7,14 @@
> 
>  #include <cobalt/uapi/kernel/types.h>
>  #include <cobalt/kernel/assert.h>
> +#include <linux/fs.h>
>  #include <linux/ktime.h>
>  #include <linux/errno.h>
> 
>  struct timespec64;
> 
> +#define SYS_CUR_CLOCKSOURCE "/sys/devices/system/clocksource/clocksource0/current_clocksource"
> +
>  static inline u64 pipeline_read_cycle_counter(void)
>  {
>         /*
> @@ -41,7 +44,25 @@ const char *pipeline_timer_name(void);
>  static inline const char *pipeline_clock_name(void)
>  {
>         /* Return the name of the current clock source. */
> -       TODO();
> +       struct file *curs;
> +       static loff_t pos;
> +       long r;
> +
> +       curs = filp_open(SYS_CUR_CLOCKSOURCE, O_RDONLY, 0);
> +       if (IS_ERR(curs))
> +               goto RTN_UNKNOWN;
> +
> +       memset(cobalt_pipeline.clocksource_name, 0, CLOCKSOURCE_NAME_MAXLEN);
> +       pos = 0;
> +       r = kernel_read(curs, cobalt_pipeline.clocksource_name, CLOCKSOURCE_NAME_MAXLEN - 1 , &pos);
> +       filp_close(curs, NULL);
> +
> +
> +       if (r < 0)
> +               goto RTN_UNKNOWN;
> +
> +       return cobalt_pipeline.clocksource_name;
> +
> +RTN_UNKNOWN:

I considered this briefly as well, but this is rather ugly (even when
using kernel_read_file_from_path), and you can simply get the
information from that original path as well - and that reliably, because
userspace knows better of there is sysfs under /sys or elsewhere.

Once we remove I-pipe support, we will also simply drop this entry in
/proc, thus the need for this abstraction.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

