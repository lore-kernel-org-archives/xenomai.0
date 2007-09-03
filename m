From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <2ff1a98a0709030832m77661616qfb36eff16b0115b@domain.hid>
References: <46DC2484.6040004@domain.hid>
	<2ff1a98a0709030832m77661616qfb36eff16b0115b@domain.hid>
Content-Type: text/plain
Date: Mon, 03 Sep 2007 19:17:41 +0200
Message-Id: <1188839861.28092.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] VxWorks semaphore usage demo
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Ravid Baruch Naali <ravidbn@domain.hid>, xenomai@xenomai.org

On Mon, 2007-09-03 at 17:32 +0200, Gilles Chanteperdrix wrote:
> On 9/3/07, Ravid Baruch Naali <ravidbn@domain.hid> wrote:
> > Hello again,
> 
> Hi,
> 
> >
> >
> > I'm not sure what is the preferred way to commit my changes, so before I
> > commit i'm Attaching my patch in order to get you remarks and further
> > instructions
> 
> The synchronization on tasks completion with the semID semaphore seems
> broken. The main thread will get the semahore when the first task
> completes, not when all the tasks complete.
> 
> I see too many comments, for instance:
> // Checking for failures
> if (error == ERROR)
> 
> is useless, it is pretty obvious from reading the code that you are
> checking for failure. Comments should tell us things that are not
> obvious.
> 
> Now, about the style, this is C code, so use C style comments. I would
> also prefer that you use the kernel coding style, but this is not
> kernel code, so I am not sure the rule is to use the kernel coding
> style.

It is. We do want a common style regardless of the execution space. TIA,

-- 
Philippe.



