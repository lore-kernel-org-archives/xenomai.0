Date: Wed, 10 Dec 2014 20:01:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141210190114.GQ1524@hermes.click-hack.org>
References: <8119909587ec45d1ba5696722a1b0945@EX132MBOX1A.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8119909587ec45d1ba5696722a1b0945@EX132MBOX1A.de2.local>
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Dec 10, 2014 at 06:58:26PM +0000, Stoidner, Christoph wrote:
> > That is strange, are these tasks
> > running with the SCHED_OTHER policy ?
> No, they are running with sched fifo.

Ok, next, are they using
rt_timer_mode_set
or
RT drivers which return -ENOSYS in their rt handlers ?

-- 
					    Gilles.

