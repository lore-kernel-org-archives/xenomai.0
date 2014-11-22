Date: Sat, 22 Nov 2014 09:56:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141122085647.GJ6931@sisyphus.hd.free.fr>
References: <20141121090857.GK4545@sisyphus.hd.free.fr>
 <20141121095305.GA20935@localhost.localdomain>
 <20141121214839.GF6931@sisyphus.hd.free.fr>
 <20141121220844.GB4020@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141121220844.GB4020@localhost.localdomain>
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

On Fri, Nov 21, 2014 at 11:08:44PM +0100, Richard Cochran wrote:
> On Fri, Nov 21, 2014 at 10:48:39PM +0100, Gilles Chanteperdrix wrote:
> > On Fri, Nov 21, 2014 at 10:53:05AM +0100, Richard Cochran wrote:
> > > This is the reason that, every time I considered using rtnet, I ended
> > > up deciding against it.
> > 
> > Well, on the other hand, picking one driver, and improving it for
> > the project which needs it was not an insurmountable task.
> 
> Except when you have a napi driver. Then, although not insurmountable,
> it still is a formidable task. (But that is changing, now ;)
> 
> > > this work is *long* overdue!
> > 
> > Well, for it to be overdue, it would have to have been due in the
> > first place. And since as far as I know, nobody paid for it and was
> > expecting a result, and nobody ever promised anything (well up to
> > now, I kind of made the promise, now), I do not really think it was
> > due. Or maybe I am just misinterpreting the meaning of overdue.
> 
> I did mean that you or anyone else owed anyone anything. I only meant
> to say that it was unfortunate that rtnet has stagnated, especially
> considering the wide industry interest in real time Ethernet.

If you need a project, and you let it stagnate, then you can not
really complain, you are just as responsible as every other user
doing the same.

> 
> And for paying the bill, no one wants to pay for preempt_rt either!

I did not say no one pays the bill for Xenomai! Just that no one
paid for refreshing RTNet. For the record, just speaking for myself,
it is quite the contrary. The contribution to RTnet of support for
NIC statistics and Xenomai and RTnet support for the select service,
to name the most significant patches, was made while I was paid to
work with Xenomai and RTnet. Since then, I have been doing my
maintainer job mostly as a hobbyist, which BTW, I believe did not
result in a dramatic decrease in either the quality or the quantity
of my contributions. You can find on this page:

http://www.denx.de/en/Software/SoftwareXenomaiProjects 

some ports of Xenomai to ARM boards for which I earned money (and a
little more which are not on the page, Freescale i.MX53, i.MX6Q,
i.MX28 and ST SPEAr600). And finally, I have received donations of
boards from several companies, for which I thank them, it is really
helping me doing the maintainer job. I am not going to list the
companies here, because I am not sure all of them want it to be
publicly known that they use Xenomai (Xenomai has that kind of
users), but I can give the boards list: Cogent Computer CSB637, a
custom board based on AT91SAM9260, an Advantech board based on AMD
Geode, an AOpen mini-PC based on Intel Core 2 duo, a Calao systems
USBA9263, an ISEE IGEPv2, recently an Atmel Xplained board, based on
the brand new AT91SAMA5D3, and just yesterday, a mail from a company
proposing me an i.MX6Q based board.


> > Maybe the next step will be to integrate the support for PTP. In
> > that case, I hope we will get your help to do the job.
> 
> Happy to help, if I can. If the drivers can stay close to mainline,
> then probably there isn't too much to do. The ptp stack itself does
> not need real time guarantees in order to operate. The one thing I can
> think of that might be needed is synchronization from the MAC clock to
> the xenomai system clock.

This is going to be hard. Maybe easier, we could add a posix clock
ID, like CLOCK_PTP, to have access to that clock from primary mode.

> 
> Also, regarding rtnet, the i210 is an inexpensive card that allows
> transmission scheduling at given time. That might be something to take
> advantage of.

Ok, thanks, will look into it.

Regards.

-- 
					    Gilles.

