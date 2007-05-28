Message-ID: <465ADB44.2070705@domain.hid>
Date: Mon, 28 May 2007 15:38:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

Fillod Stephane wrote:
> You may also need this patch:
> 
> --- skins/native/task.c 20 Mar 2007 08:16:41 -0000      1.1.1.1
> +++ skins/native/task.c 28 Mar 2007 13:53:03 -0000      1.2
> @@ -135,7 +135,12 @@
>         pthread_attr_setstacksize(&thattr, stksize);
>         if (!(mode & T_JOINABLE))
>                 pthread_attr_setdetachstate(&thattr, PTHREAD_CREATE_DETACHED);
> -       if (prio > 0) {
> +       /* There's a limitation in libpthread
> +        * that returns EPERM upon SCHED_FIFO
> +        * for non priviledged users.
> +        * So workaround this for now. FIXME (in uClibc/pthread).
> +        */
> +       if (prio > 0 && geteuid() == 0) {
>                 pthread_attr_setschedpolicy(&thattr, SCHED_FIFO);
>                 param.sched_priority = sched_get_priority_max(SCHED_FIFO);
>         }

I do not think it is a good idea, I prefer rt_task_create to fail loudly
because it needs root priviledge, rather than silently creating a non
real-time thread.

-- 
                                                 Gilles Chanteperdrix

