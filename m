Message-ID: <50F7B644.5070402@xenomai.org>
Date: Thu, 17 Jan 2013 09:28:52 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <50F6FCDB.1020109@siemens.com>
In-Reply-To: <50F6FCDB.1020109@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] ipipe: Re-fix migration helper for legacy
	users
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 01/16/2013 08:17 PM, Jan Kiszka wrote:
> In the legacy use case, __ipipe_switch_tail will be invoked over the
> non-root domain after hardening. So clearing of TASK_HARDENING must not
> be restricted to root.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> For the case my analysis was right. With this, Xenomai 2.6 works again
> here.
>
>   kernel/ipipe/core.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
> index 6929156..4695ba8 100644
> --- a/kernel/ipipe/core.c
> +++ b/kernel/ipipe/core.c
> @@ -1124,7 +1124,9 @@ int __ipipe_switch_tail(void)
>   	hard_local_irq_disable();
>   #endif
>   	x = __ipipe_root_p;
> +#ifndef CONFIG_IPIPE_LEGACY
>   	if (x)
> +#endif
>   		complete_domain_migration();
>
>   #ifndef CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH
>

We need this in the non-legacy case as well. Otherwise, a 
gatekeeper-less system like the one we use in 3.x would spuriously run 
the migration hook over the head domain.

-- 
Philippe.

