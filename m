Date: Thu, 11 Dec 2014 17:06:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141211160616.GA27793@hermes.click-hack.org>
References: <20141210190114.GQ1524@hermes.click-hack.org>
 <6f637a6b60964c49bbc08e3204c8eae3@EX132MBOX1A.de2.local>
 <20141211100520.GA21808@hermes.click-hack.org>
 <88cb5162a0ca44fb8251aa8161a8d8d8@EX132MBOX1A.de2.local>
 <20141211102249.GB21808@hermes.click-hack.org>
 <14309ee2cb7e45c9a01e6e1504c5bed5@EX132MBOX1A.de2.local>
 <20141211104713.GC21808@hermes.click-hack.org>
 <67263b7a47034e2fba906d0b68b3277f@EX132MBOX1A.de2.local>
 <20141211144711.GD21808@hermes.click-hack.org>
 <26e587954f4c46119fa524af7a3a454e@EX132MBOX1A.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26e587954f4c46119fa524af7a3a454e@EX132MBOX1A.de2.local>
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

On Thu, Dec 11, 2014 at 03:47:36PM +0000, Stoidner, Christoph wrote:
> 
> > Ok, maybe we have some hope with the tracer though. What should
> > trigger a trace is the fact that a relax request has been sent, but
> > that the next linux scheduling point does not wake up the said task.
> > This is all debug code, so it does not need to be clean. You can
> > define a per-cpu variable (if running on SMP systems, otherwise a
> > global variable will do) with the last request posted. And when a
> > linux scheduling happens, test that the newly scheduled task is the
> > task that was passed to the relax, if that is not the case, trigger
> > a trace freeze. The point where the nucleus is informed of a Linux
> > task switch is do_schedule_event(). The trick is that if you have
> > some tasks with a higher priority than the relaxed task, it is
> > normal that the relaxed task is not scheduled immediately, so if you
> > want the condition to hold, you need to run the xenomai tasks which
> > relax with the highest priority. Also, obviously, after the test,
> > the pointer should be reset to NULL, because there are several task
> > queued, and with a global variable you have no way of knowing which
> > is next.
> 
> I will do so. Do I have to change the gatekeeper's priority behind the relaxing
> task to assure that the gatekeeper would be scheduled before?

The gatekeeper is not involved.

-- 
					    Gilles.

