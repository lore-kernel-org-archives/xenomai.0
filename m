Message-ID: <435DD999.9090408@domain.hid>
Date: Tue, 25 Oct 2005 09:07:05 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] RTDM abstraction for priority direction
References: <435D4FEE.10301@domain.hid>
In-Reply-To: <435D4FEE.10301@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> it turned out that it is useful to abstract the priority
> increment/decrement by one level at the RTDM layer - for systems that
> use a different scheme compared to POSIX or Xenomai (so far only classic
> RTAI). Please apply.

Applied, thanks.

> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: skins/rtdm/rtdm_driver.h
> ===================================================================
> --- skins/rtdm/rtdm_driver.h	(Revision 72)
> +++ skins/rtdm/rtdm_driver.h	(Arbeitskopie)
> @@ -831,8 +831,16 @@
>  #define RTDM_TASK_HIGHEST_PRIORITY  XNCORE_HIGH_PRIO
>  /** @} */
> 
> +/*!
> + * @anchor changetaskprio @name Task Priority Modification
> + * Raise or lower task priorities by one level
> + * @{ */
> +#define RTDM_TASK_RAISE_PRIORITY    (+1)
> +#define RTDM_TASK_LOWER_PRIORITY    (-1)
>  /** @} */
> 
> +/** @} */
> +
>  static inline int rtdm_task_init(rtdm_task_t *task, const char *name,
>                                   rtdm_task_proc_t task_proc, void *arg,
>                                   int priority, __u64 period)
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

