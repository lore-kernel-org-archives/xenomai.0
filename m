Subject: Re: [PATCH] cobalt/thread: initialize sigarray in __xnthread_init
References: <20210616021943.13526-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b4a9412c-a39a-b28d-4240-6e58947a21ff@siemens.com>
Date: Wed, 16 Jun 2021 07:35:06 +0200
MIME-Version: 1.0
In-Reply-To: <20210616021943.13526-1-hongzhan.chen@intel.com>
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 16.06.21 04:19, Hongzhan Chen via Xenomai wrote:
> Add missing sigarray initialization to avoid missing signal in
> __xnthread_signal.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index d096a20d3..49913accc 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -287,6 +287,8 @@ int __xnthread_init(struct xnthread *thread,
>  	thread->cookie = NULL;
>  	init_completion(&thread->exited);
>  	memset(xnthread_archtcb(thread), 0, sizeof(struct xnarchtcb));
> +	memset(thread->sigarray, 0, sizeof(thread->sigarray[0]) *
> +				XNTHREAD_MAX_SIGNALS);
>  
>  	gravity = flags & XNUSER ? XNTIMER_UGRAVITY : XNTIMER_KGRAVITY;
>  	xntimer_init(&thread->rtimer, &nkclock, timeout_handler,
> 

Good catch! Queued, though like this:

memset(thread->sigarray, 0, sizeof(thread->sigarray));

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

