Message-ID: <49B63332.6050209@domain.hid>
Date: Tue, 10 Mar 2009 10:30:26 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <49B62D9A.9030406@domain.hid>
In-Reply-To: <49B62D9A.9030406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Suppress switch warnings while debugging
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Don't raise SIGXCPU while the process is being debugged. These mode
> changes are expected, and reporting them doesn't provide any helpful
> information to the application. Rather, it may raise error storms on the
> application side.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
> 
>  ksrc/nucleus/shadow.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
> index bcf3b8b..91cf499 100644
> --- a/ksrc/nucleus/shadow.c
> +++ b/ksrc/nucleus/shadow.c
> @@ -1082,7 +1082,8 @@ void xnshadow_relax(int notify)
>  
>  	xnstat_counter_inc(&thread->stat.ssw);	/* Account for secondary mode switch. */
>  
> -	if (notify && xnthread_test_state(thread, XNTRAPSW))
> +	if (notify && xnthread_test_state(thread, XNTRAPSW) &&
> +	    !xnthread_test_state(thread, XNDEBUG))
>  		/* Help debugging spurious relaxes. */
>  		send_sig(SIGXCPU, current, 1);
>

I would rather identify the source of the switch and clear the notify flag 
appropriately from the relax call site.

> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

