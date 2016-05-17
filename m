Date: Tue, 17 May 2016 11:41:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160517094127.GC2668@hermes.click-hack.org>
References: <f5af5dc73c2046f789592c7f15246c24@AM3PR48MB0177.041d.mgd.msft.net>
 <20160514123051.GB27354@hermes.click-hack.org>
 <3CC67847-B96B-4A25-A4C0-D92F267E4E3F@temporubato.com>
 <28dcd6ac421c4696a7f60ccef160c8ef@AM3PR48MB0177.041d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28dcd6ac421c4696a7f60ccef160c8ef@AM3PR48MB0177.041d.mgd.msft.net>
Subject: Re: [Xenomai] system freeze on IMX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: TALBI Ahmed -EXT <ahmed.talbi-ext@alstom.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, May 17, 2016 at 09:11:09AM +0000, TALBI Ahmed -EXT wrote:
> In the logs I attached I can see that xnlock  is locked in do_taskexit_event (by CPU0) and then in the same context we try to lock it a second time in xintr_clock_handler. May this be the issue ? or is xnlock a recursive lock ?

You are misreading the logs. xnintr_clock_handler tries to get the
lock on one cpu, while do_taskexit_event got it on another cpu. The
root cause of the problem is a fault when xnlock_spin is trying to
print some message. Probably because it has spin for too long. You
can try to disable spinlock debugging, but I am afraid you will get
a lockup instead.

-- 
					    Gilles.
https://click-hack.org

