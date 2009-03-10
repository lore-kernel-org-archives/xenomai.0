From: Andreas Glatz <andreasglatz@domain.hid>
In-Reply-To: <49B54BB7.5040705@domain.hid>
References: <1236608449.3587.32.camel@domain.hid>
	<49B53EE4.1030008@domain.hid> <1236616652.3531.57.camel@domain.hid>
	<49B54BB7.5040705@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Mar 2009 08:43:19 -0400
Message-Id: <1236688999.3531.75.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-core] rt_queue_create in RT task?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi,

On Mon, 2009-03-09 at 18:02 +0100, Philippe Gerum wrote:
> Andreas Glatz wrote:
> > Hi,
> > 
> > On Mon, 2009-03-09 at 17:08 +0100, Philippe Gerum wrote:
> >> Andreas Glatz wrote:
> >>> Hi,
> >>>
> >>> Calling rt_queue_create in a real-time task is supposed to fail
> >>> according to the documentation. 
> >>>
> >> It fails from kernel space, otherwise, from user-space, your application would 
> >> simply be moved to a Linux context automatically for processing the 
> >> rt_queue_create() syscall.
> > 
> > Currently, we are developing in Userspace, so everything works fine. But
> > we still would like to have the option to run in kernel-space if for
> > some reason the user-space performance is too poor. 
> >
> 
> Could you elaborate a bit about this? What was bad, latency? If so, what is your 
> target arch/platform, and which typical latency do you require?
> 

Interrupt latency is an issue. But we are still in the development phase
and I don't have detailed figures available. I'll post them when I get
them!

Thanks for yr help,
Andreas

