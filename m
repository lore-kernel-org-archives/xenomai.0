Message-ID: <53875E0E.4080701@xenomai.org>
Date: Thu, 29 May 2014 18:19:26 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1401378135.12445.YahooMailNeo@web171606.mail.ir2.yahoo.com>
In-Reply-To: <1401378135.12445.YahooMailNeo@web171606.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_mutex_init on forge
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/29/2014 05:42 PM, Matthias Schneider wrote:
> Hi all,
>
> I have a question about rtdm_mutex_init in forge. BUG_ON is
> triggered each time I create an rtdm_mutex. This seems to be
> due to a check in xnsynch_init, while apparently some
> implementation is still missing in rtdm_mutex_init():
>
> void rtdm_mutex_init(rtdm_mutex_t *mutex)
> {
>          spl_t s;
>
>          /* Make atomic for re-initialisation support */
>          xnlock_get_irqsave(&nklock, s);
>
>          xnsynch_init(&mutex->synch_base,
>                       XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_OWNER, NULL);
>
>          xnlock_put_irqrestore(&nklock, s);
> }
>
>
> void xnsynch_init(struct xnsynch *synch, int flags, atomic_long_t *fastlock)
> {
>          if (flags & XNSYNCH_PIP)
>                  flags |= XNSYNCH_PRIO | XNSYNCH_OWNER;  /* Obviously... */
>
>          synch->status = flags & ~XNSYNCH_CLAIMED;
>          synch->owner = NULL;
>          synch->cleanup = NULL;  /* Only works for PIP-enabled objects. */
>          synch->wprio = -1;
>          INIT_LIST_HEAD(&synch->pendq);
>
>          if (flags & XNSYNCH_OWNER) {
>                  BUG_ON(fastlock == NULL); // <---------- Obviously this is
>                                            //             always occurs for an
>                                            //             rtdm_mutex.
>                  synch->fastlock = fastlock;
>                  atomic_long_set(fastlock, XN_NO_HANDLE);
>          } else
>                  synch->fastlock = NULL;
> }
>
> At the moment I am not sure if the atomic_long_t counter needs be added to
> rtdm_mutex or the flags need to be changed. Thanks for your help,
>

RTDM mutexes cannot and do not have to provide fast locking memory, the 
assertion I have added to xnsynch_init() is broken. Will fix.
-- 
Philippe.

