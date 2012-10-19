Message-ID: <5080DC32.5050603@xenomai.org>
Date: Fri, 19 Oct 2012 06:50:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50795024.4010506@xenomai.org>
	<1350127811-776-1-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1350127811-776-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/1] rtdm: get spinlocks to lock the scheduler
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 10/13/2012 01:30 PM, Gilles Chanteperdrix wrote:

> diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
> index 7c56abc..0f801fe 100644
> --- a/ksrc/nucleus/pod.c
> +++ b/ksrc/nucleus/pod.c
> @@ -2203,6 +2203,12 @@ reschedule:
>  	if (!need_resched)
>  		goto signal_unlock_and_exit;
>  #endif /* !XENO_DEBUG(NUCLEUS) */
> +	if (xnthread_test_state(curr, XNTHREAD_BLOCK_BITS|XNLOCK) == XNLOCK) {


We probably want to add XNZOMBIE here, as we may want to destroy a
thread, even if it has locked the scheduler.

-- 
                                                                Gilles.

