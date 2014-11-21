Date: Fri, 21 Nov 2014 23:08:44 +0100
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20141121220844.GB4020@localhost.localdomain>
References: <20141121090857.GK4545@sisyphus.hd.free.fr>
 <20141121095305.GA20935@localhost.localdomain>
 <20141121214839.GF6931@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141121214839.GF6931@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] RTnet in Xenomai 3, status and future
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: rtnet-developers@lists.sourceforge.net, rtnet-users@lists.sourceforge.net, Xenomai <xenomai@xenomai.org>

On Fri, Nov 21, 2014 at 10:48:39PM +0100, Gilles Chanteperdrix wrote:
> On Fri, Nov 21, 2014 at 10:53:05AM +0100, Richard Cochran wrote:
> > This is the reason that, every time I considered using rtnet, I ended
> > up deciding against it.
> 
> Well, on the other hand, picking one driver, and improving it for
> the project which needs it was not an insurmountable task.

Except when you have a napi driver. Then, although not insurmountable,
it still is a formidable task. (But that is changing, now ;)

> > this work is *long* overdue!
> 
> Well, for it to be overdue, it would have to have been due in the
> first place. And since as far as I know, nobody paid for it and was
> expecting a result, and nobody ever promised anything (well up to
> now, I kind of made the promise, now), I do not really think it was
> due. Or maybe I am just misinterpreting the meaning of overdue.

I did mean that you or anyone else owed anyone anything. I only meant
to say that it was unfortunate that rtnet has stagnated, especially
considering the wide industry interest in real time Ethernet.

And for paying the bill, no one wants to pay for preempt_rt either!

> Maybe the next step will be to integrate the support for PTP. In
> that case, I hope we will get your help to do the job.

Happy to help, if I can. If the drivers can stay close to mainline,
then probably there isn't too much to do. The ptp stack itself does
not need real time guarantees in order to operate. The one thing I can
think of that might be needed is synchronization from the MAC clock to
the xenomai system clock.

Also, regarding rtnet, the i210 is an inexpensive card that allows
transmission scheduling at given time. That might be something to take
advantage of.

Thanks,
Richard

