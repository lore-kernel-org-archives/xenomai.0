References: <0ab5b536-2e75-fdfe-96e9-f6321aca107d@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8e002d9f-6357-2177-f53e-59580707c27b@xenomai.org>
Date: Wed, 3 Oct 2018 19:24:11 +0200
MIME-Version: 1.0
In-Reply-To: <0ab5b536-2e75-fdfe-96e9-f6321aca107d@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] cobalt/posix/mqueue: Remove unused cobalt_mqq
 and fix error cleanup bug
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 10/02/2018 07:03 PM, Jan Kiszka wrote:
> cobalt_mqq was only maintained but never queried. Remove it.
> 
> This also simplify the fix for the broken error recovery in mq_open: If
> xnregistry_enter, we never entered the new element in cobalt_mqq and
> also already decremented the reference counter. But then we asked via
> rtdm_fd_close to remove the entry as if it was registered. That could
> easily crash the system.
> 

This looks like a logic which got orphaned when Cobalt stopped being a
module unlike the 2.6.x nucleus. However, Cobalt services can be
dynamically stopped via corectl, and we should reclaim the named queues
that may have persisted until that happens. Re-connecting that logic
when the core is switched to the stopped state may be a better choice.

> @@ -354,10 +349,6 @@ static int mq_open(int uqd, const char *name, int oflags,
>  
>  		xnlock_get_irqsave(&nklock, s);
>  		err = xnregistry_enter(mq->name, mq, &mq->handle, NULL);
> -		if (err < 0)
> -			--mq->refs;

AFAICS, this change would make mq memory stale. ->refs starts at 2 from
mq_init(), and rtdm_fd_close->mqd_close->mq_unref[_inner] would never
drop the refcount to zero.

-- 
Philippe.

