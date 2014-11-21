Date: Fri, 21 Nov 2014 22:48:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141121214839.GF6931@sisyphus.hd.free.fr>
References: <20141121090857.GK4545@sisyphus.hd.free.fr>
 <20141121095305.GA20935@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141121095305.GA20935@localhost.localdomain>
Subject: Re: [Xenomai] RTnet in Xenomai 3, status and future
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Cochran <richardcochran@gmail.com>
Cc: rtnet-developers@lists.sourceforge.net, rtnet-users@lists.sourceforge.net, Xenomai <xenomai@xenomai.org>

On Fri, Nov 21, 2014 at 10:53:05AM +0100, Richard Cochran wrote:
> Hi Gilles,
> 
> On Fri, Nov 21, 2014 at 10:08:57AM +0100, Gilles Chanteperdrix wrote:
> > The drivers, on the other hand, are a bit more worrying. They are
> > based on seriously outdated versions of the corresponding Linux
> > drivers, with support for much less hardware, and probably missing
> > some bug fixes. So, putting the drivers into a better shape and
> > making it easy to track mainline changes will be my first priority.
> 
> This is the reason that, every time I considered using rtnet, I ended
> up deciding against it.

Well, on the other hand, picking one driver, and improving it for
the project which needs it was not an insurmountable task.

> 
> > Please feel free to send any reaction to this mail.
> 
> Good luck,

Thanks.

> this work is *long* overdue!

Well, for it to be overdue, it would have to have been due in the
first place. And since as far as I know, nobody paid for it and was
expecting a result, and nobody ever promised anything (well up to
now, I kind of made the promise, now), I do not really think it was
due. Or maybe I am just misinterpreting the meaning of overdue.

Anyway, to make things perfectly clear on that subject, I am not
doing this because I feel the Xenomai project owes it to anyone,
only because I like the idea of working on that project and that it
may be useful for a lot of Xenomai dual-kernel applications.

Maybe the next step will be to integrate the support for PTP. In
that case, I hope we will get your help to do the job.

Regards.

-- 
					    Gilles.

