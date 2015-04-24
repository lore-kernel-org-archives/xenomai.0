Date: Fri, 24 Apr 2015 17:18:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150424151841.GM7109@hermes.click-hack.org>
References: <1b27d68cb89340489802b18862a2b2d7@zue-s-199.zue.zwick.de>
 <5539E86A.7000104@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5539E86A.7000104@web.de>
Subject: Re: [Xenomai] Corruption after phtread_mutex_destroy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Apr 24, 2015 at 08:53:30AM +0200, Jan Kiszka wrote:
> Am 2015-04-23 um 20:42 schrieb Meier, Hans:
> > Hi everybody,
> > 
> > First of all thanks a lot for your excellent work, we are using Xenomai 
> > for about 8 years now in quite a complex application together with ACE 
> > based on the POSIX skin and most of the time it just works fine.
> > 
> > But now we have a situation we think needs to be reported. 
> > 
> > Consider the following:
> > We have a thread H with high priority, a thread L with low priority and 
> > a mutex M (recursive, prio-inherit). L locks M and then H tries to lock M, 
> > L gets boosted until it unlocks M, then H succeeds in locking M, then H 
> > unlocks M. If H then immediately destroys and frees M, we get a corruption 
> > where M's pthread_mutex_t was stored (a byte gets decremented), as soon as 
> > L gets scheduled again.
> > 
> > According to man page PTHREAD_MUTEX_DESTROY(3P), section "Destroying 
> > Mutexes" - close to the end - "Implementations are required to allow an 
> > object to be destroyed and freed ... immediately after the object is 
> > unlocked". So that is what we do here, we destroy and free the mutex 
> > immediately after it is unlocked. Certainly in a simple scenario we could 
> > easily work around this problem by destroying and freeing M later, but 
> > what if this code is buried deep inside a framework lib (here ACE)? 
> 
> Not saying that ACE is to be blamed in this case (until the issue is
> fully understood),

The issue is fully understood, the mutex is considered in-use as
long as all threads have not exited all the mutex services. In the
case of the example posted, the "worker" thread is still in the
pthread_mutex_unlock service while the other thread is trying to
call pthread_mutex_destroy, which cause pthread_mutex_destroy to
return EINVAL.

Xenomai 3 does not have this issue.

-- 
					    Gilles.

