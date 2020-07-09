From: alex_luca@163.com
Subject: [RFC]why xnlock_put and xnlock_clear_irqon release xnlock directly?
Date: Thu,  9 Jul 2020 23:25:09 +0800
Message-Id: <20200709152509.33099-1-alex_luca@163.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Alex_luca@163.com

From: Alex_luca@163.com

hello,list
I have some doubts on *struct nklock* operations. 

Both *xnlock_get* and *xnlock_get_irqsave* is allowed to be called
nested;they will check that if the nklock has been acquired. If so
they won't actually do the "get", but return a value of 2.

But the *xnlock_put*, which corresponding to *xnlock_get* never
checks and will actually release the lock. This is diffrent from
*xnlock_put_irqrestore*.

What puzzles me is the following:
{
    ......
    xnlock_get_irqsave(nklock, s)
    ......
        xnlock_get(nklock)
        ......
        xnlock_put(nklock)
        ......
    xnlock_put_irqrestore(nklock, s)
}

First, *xnlock_get_irqsave* get the nklock, and *xnlock_get* will skip;
Then *xnlock_put* is called, and it released the nklock; after a
while *xnlock_put_irqrestore* is called on the same cpu, it also seems
to release the nklock.

Will this above happen in xenomai?  But I have never seen this happen.
Or *xnlock_get* was guaranteed never been called nesting?

Thank you.


