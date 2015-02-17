Date: Tue, 17 Feb 2015 19:11:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150217181133.GB17681@hermes.click-hack.org>
References: <CALe7ZU0Y4hb0d7ANK9gitLLaQnGFiH8LpH3ZaTQ5MHLCYjAf=w@mail.gmail.com>
 <20150216092513.GA1914@hermes.click-hack.org>
 <20150217173314.GI30245@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150217173314.GI30245@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] rtdm_irq_request not registering irq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: JAY KOTHARI <jaikothari10@gmail.com>, xenomai <xenomai@xenomai.org>

On Tue, Feb 17, 2015 at 12:33:14PM -0500, Lennart Sorensen wrote:
> On Mon, Feb 16, 2015 at 10:25:13AM +0100, Gilles Chanteperdrix wrote:
> > On Mon, Feb 16, 2015 at 10:28:51AM +0530, JAY KOTHARI wrote:
> > > Hello,
> > >          I am requesting interrupt with rtdm_irq_request. API works
> > > without error but not irq is not working. When I look into dmesg I get
> > > back-trace of this API but no error. I even looked in /proc/interrupts
> > > but no sign of registration. What might be wrong with this API for
> > > me??
> > 
> > You will not see an interrupt registered with rtdm_irq_request in
> > /proc/interrupts, /proc/interrupts lists interrupts registered with
> > request_irq. An interrupt registered with rtdm_irq_request appears
> > in /proc/xenomai/irq.
> > 
> > Does exactly the same irq number work when requesting it with
> > request_irq ?
> > 
> > If no, then you may have made an error in the irq number: Linux irqs
> > are now remapped and the irq number passed to request_irq may not be
> > the same as the hardware irq number you would expect.
> > 
> > If yes, then are you running xenomai on an arm platform? If yes, we
> > have a very old bug which has been fixed only recently, normally,
> > requesting the irq both with request_irq and rtrm_irq_request should
> > avoid this bug.
> 
> Is there a git commit number for that fix?  I am curious if that would
> make some things work better for us.

in 3.x

https://git.xenomai.org/xenomai-3.git/commit/?id=a8d0efffc57464b03e93e0d0f4308a34faed21c2

not yet fixed in 2.6 git.

And if your irq chip uses the irq_startup callback:

https://git.xenomai.org/ipipe.git/commit/?id=b3f0bfe5fb1ee0ae079e281b44e591745d1c6c61

-- 
					    Gilles.

