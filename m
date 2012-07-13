Message-ID: <50005F43.20206@xenomai.org>
Date: Fri, 13 Jul 2012 19:47:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F534D1A615F544D95E57BFD8460658301CBE3B9@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE189C.7060504@xenomai.org>	<4F534D1A615F544D95E57BFD8460658301CBE3BD@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE8B7C.60506@xenomai.org>	<4F534D1A615F544D95E57BFD8460658301CBE3C2@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>	<4FFFEB98.7060106@xenomai.org>	<4F534D1A615F544D95E57BFD8460658302FEBCEB@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>	<500001AC.5040706@xenomai.org>	<4F534D1A615F544D95E57BFD8460658302FEBD85@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>	<50000D7C.2010809@siemens.com>
	<4F534D1A615F544D95E57BFD8460658302FEC034@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
In-Reply-To: <4F534D1A615F544D95E57BFD8460658302FEC034@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] BUG: Unhandled exception over domain Xenomai -
 switching to ROOT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Jorge Ramirez Ortiz, HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/13/2012 06:27 PM, Jorge Ramirez Ortiz, HCL Europe wrote:
> Please can we go back and reframe the discussion?
> 
> But first I'll reiterate: do ignore the marginal issue I had with the
> framework (I ported and went over 44,785 lines of ANSI-C(kernel/user)
> and 1995 lines of C++ code  in just a few days -this one was a big
> pci driver-....I am not really losing my sleep over it) . Besides It
> is not really relevant to the point I am trying to make and the
> reason why I am posting here.
> 
> My point is: yes, absolutely, I would expect the framework to allow
> wakeup calls to linux services from interrupt context. Why not? Why
> is this the wrong expectation to have?

Because waking up a task means interacting with Linux scheduler, which,
in turn, means interacting with the scheduler data structures. But the
reason why xenomai has low latencies is because its interrupts may
interrupt linux anywhere, including in the middle of a critical section
where the scheduler data structures are in an inconsistent state. So,
you see, it can not work.


> And anyhow, failing that, I would have expected the real-time driver
> model to give the user the option to chose the back door context he
> wants to register to (which is my whole point and what  PREEMPT_RT
> actually does in the linux domain). And I would expect an rtdm
> interface for that.

rtdm has an interface for that, it is called rtdm_nrtsig.

-- 
					    Gilles.

