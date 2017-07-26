References: <87b5e4c1-a800-83ee-94af-c797091a3a13@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8b5e06eb-6440-ff4f-f969-2d9fca9b3995@xenomai.org>
Date: Wed, 26 Jul 2017 17:49:41 +0200
MIME-Version: 1.0
In-Reply-To: <87b5e4c1-a800-83ee-94af-c797091a3a13@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] Remote thread suspension vs. info flags
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 07/25/2017 08:54 PM, Jan Kiszka wrote:
> Hi all,
> 
> don't we need this?
> 
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index ab457da70..604179f68 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -920,8 +920,13 @@ void xnthread_suspend(struct xnthread *thread, int mask,
>  			    (oldstate & XNTRAPLB) != 0)
>  				goto lock_break;
>  		}
> -		xnthread_clear_info(thread,
> -				    XNRMID|XNTIMEO|XNBREAK|XNWAKEN|XNROBBED|XNKICKED);
> +		/*
> +		 * Do not destroy the info left behind by yet unprocessed
> +		 * wakeups when suspending a remote thread.
> +		 */
> +		if (thread == sched->curr)
> +			xnthread_clear_info(thread, XNRMID|XNTIMEO|XNBREAK|
> +						    XNWAKEN|XNROBBED|XNKICKED);
>  	}
>  
>  	/*
> 
> Let's assume a high prio thread is running and a low-prio is waiting for
> a timeout. Now the timeout occurs, and the low-prio is woken up but
> can't run yet. If the high-prio suspends the low-prio, XNWIMEO will be
> lost.
> 
> I've run into this with complex out-of-tree modifications, but this
> seems to affect upstream as well, no?
> 

Definitely, yes.

-- 
Philippe.

