Message-ID: <5077BDEF.6070307@xenomai.org>
Date: Fri, 12 Oct 2012 08:51:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5077B799.5000408@xenomai.org>
	<1350023177-8123-1-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1350023177-8123-1-git-send-email-gilles.chanteperdrix@xenomai.org>
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

On 10/12/2012 08:26 AM, Gilles Chanteperdrix wrote:

> In a context where callbacks are called with spinlocks held, it is not
> possible for drivers callbacks to wake up threads without holding any
> spinlock. So, we need a mechanism to lock the scheduler when a spinlock
> is grabbed. As xnpod_lock_sched/xnpod_unlock_sched may be a bit heavy
> weight for this case, we try and reimplement a lighter version.


There is a concurrence issue if, say, xnpod_suspend_thread or
xnpod_reset_thread is called on another cpu while the thread which holds
the scheduler lock is using an rtdm spinlock. I guess the rtdm spinlocks
have to take the nklock to serialize access to the scheduler structures,
so, use xnpod_lock_sched/xnpod_unlock_sched instead of
__xnpod_lock_sched / __xnpod_unlock_sched.

-- 
                                                                Gilles.

