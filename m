Message-ID: <43577043.5000007@domain.hid>
Date: Thu, 20 Oct 2005 12:24:03 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] doc fix in rtdm
References: <43568931.8070902@domain.hid>
In-Reply-To: <43568931.8070902@domain.hid>
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
> someone ;) complained about this statement regarding
> rtdm_task_busy_sleep. I think he is right.
>

Applied, thanks.

> --- drvlib.c    (revision 44)
> +++ drvlib.c    (working copy)
> @@ -335,7 +335,7 @@
>   * - Kernel-based task
>   * - User-space task (RT, non-RT)
>   *
> - * Rescheduling: always.
> + * Rescheduling: never.
>   */
>  void rtdm_task_busy_sleep(__u64 delay)
>  {
> 
> Jan
> 
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

