From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 22 Dec 2015 10:54:29 -0500
Message-ID: <20151222155429.GS25177@csclub.uwaterloo.ca>
References: <CADYNH7X5DJ5WTOfNYfVgoVw8o0cmF8Johhef=zakncwLqHoMQw@mail.gmail.com>
 <20151222024304.GR25177@csclub.uwaterloo.ca>
 <20151222073037.GC29679@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151222073037.GC29679@hermes.click-hack.org>
Subject: Re: [Xenomai] NVIDIA Drivers w/ Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Dec 22, 2015 at 08:30:37AM +0100, Gilles Chanteperdrix wrote:
> Last time I looked, NVIDIA drivers used some glue code to adapt to
> the particular kernel for which they were compiled. This glue made
> use of the standard macro local_irq_save/spin_lock_irqsave, etc...
> So, compiling the NVIDIA driver with an I-pipe kernel worked, and so
> did running Xenomai programs along side graphic applications. But
> that was a long time ago. In any case, running the latency test
> while your image processing program is running on the GPU should
> allow you to find whether the driver is generating large latencies.

OK, maybe it isn't as bad as I was led to believe in the past then.

I suppose one could hope there are no interrupt disable calls in the
nvidia binary blob directly.

-- 
Len Sorensen

