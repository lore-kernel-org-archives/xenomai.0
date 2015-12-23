Date: Wed, 23 Dec 2015 13:48:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151223124846.GC29038@hermes.click-hack.org>
References: <CADYNH7X5DJ5WTOfNYfVgoVw8o0cmF8Johhef=zakncwLqHoMQw@mail.gmail.com>
 <20151222024304.GR25177@csclub.uwaterloo.ca>
 <20151222073037.GC29679@hermes.click-hack.org>
 <20151222155429.GS25177@csclub.uwaterloo.ca>
 <56798985.2090803@nta-inc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56798985.2090803@nta-inc.net>
Subject: Re: [Xenomai] NVIDIA Drivers w/ Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: xenomai@xenomai.org

On Tue, Dec 22, 2015 at 11:33:57AM -0600, Jeff Webb wrote:
> On 12/22/2015 09:54 AM, Lennart Sorensen wrote:
> > On Tue, Dec 22, 2015 at 08:30:37AM +0100, Gilles Chanteperdrix wrote:
> >> Last time I looked, NVIDIA drivers used some glue code to adapt to
> >> the particular kernel for which they were compiled. This glue made
> >> use of the standard macro local_irq_save/spin_lock_irqsave, etc...
> >> So, compiling the NVIDIA driver with an I-pipe kernel worked, and so
> >> did running Xenomai programs along side graphic applications. But
> >> that was a long time ago. In any case, running the latency test
> >> while your image processing program is running on the GPU should
> >> allow you to find whether the driver is generating large latencies.
> >
> > OK, maybe it isn't as bad as I was led to believe in the past then.
> >
> > I suppose one could hope there are no interrupt disable calls in the
> > nvidia binary blob directly.
> 
> I have experienced some high worst-case latencies when using the
> NVIDIA drivers along side Xenomai real-time code in the past. The
> open source drivers seemed to be more well-behaved from a
> real-time point of view.

If you are talking about the "nouveau" drivers, unfortunately I am
afraid they will not satisfy the user needs: last time I tried
writing shaders for the nouveau drivers, the shaders were run on the
CPU, not the GPU.

-- 
					    Gilles.
https://click-hack.org

