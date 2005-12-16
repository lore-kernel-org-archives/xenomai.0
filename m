Message-ID: <43A3514C.4030308@domain.hid>
Date: Sat, 17 Dec 2005 00:44:12 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [doc-patch] rt_task_create & user stack size
References: <43988465.1020102@domain.hid>
In-Reply-To: <43988465.1020102@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
> Please apply this, the statement is no longer valid.
>

Applied, thanks.

> --- ksrc/skins/native/task.c    (revision 243)
> +++ ksrc/skins/native/task.c    (working copy)
> @@ -117,7 +117,7 @@
>   *
>   * @param stksize The size of the stack (in bytes) for the new
>   * task. If zero is passed, a reasonable pre-defined size will be
> - * substituted. This parameter is ignored for user-space tasks.
> + * substituted.
>   *
>   * @param prio The base priority of the new task. This value must
>   * range from [1 .. 99] (inclusive) where 1 is the lowest effective
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

