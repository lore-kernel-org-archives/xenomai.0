Message-ID: <50616788.7070109@xenomai.org>
Date: Tue, 25 Sep 2012 10:12:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANKLDmsUnaOGUb9KQf=c-68h1YHB7R=Uc-GvMzsJL_L1jG2cJw@mail.gmail.com>
In-Reply-To: <CANKLDmsUnaOGUb9KQf=c-68h1YHB7R=Uc-GvMzsJL_L1jG2cJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] No TSC in SMP on Intel Atom
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: xenomai@xenomai.org

On 09/24/2012 03:33 PM, Henri Roosen wrote:
> Hi,
> 
> I'm currently doing some tests on an Intel ATOM D2700 and try to run
> Xenomai threads on different cores. Currently using kernel 3.4.6,
> x86-32 SMP, and Xenomai 2.6.1 SMP.
> 
> It seems the kernel detects the ATOM's TSC as unusable in SMP
> configuration and switches to the jiffies clock. This because there is
> an offset between both TSC counters of both cores. It seems even
> though the CPU has constant_tsc and nonstop_tsc, there is no guarantee
> for the counters to have the same value. I guess just the offset stays
> the same.
> 
> My question is what are the implications for Xenomai not being able to
> have a TSC in SMP configuration, as Xenomai heavily relies on the TSC?

Xenomai should not take what Linux does into accout, and continue to use
the TSC, you should see if that is the case by running
cat /proc/xenomai/timer

Something else you should check is whether Linux stops using the TSC
without CONFIG_IPIPE, because the fact that Linux declares the TSC
unusable may be an unwanted consequence of the I-pipe patch, for
instance the changes done for dynamic tsc detection.

-- 
					    Gilles.

