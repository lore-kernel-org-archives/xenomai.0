Date: Wed, 1 Jun 2016 16:12:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160601141238.GC14103@hermes.click-hack.org>
References: <574D9B03.8080706@sigmatek.at>
 <20160531141646.GG5951@hermes.click-hack.org>
 <574EE886.2020907@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <574EE886.2020907@sigmatek.at>
Subject: Re: [Xenomai] Performance impact after switching from 2.6.2.1 to
 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Cc: xenomai@xenomai.org

On Wed, Jun 01, 2016 at 03:52:06PM +0200, Wolfgang Netbal wrote:
> 
> 
> Am 2016-05-31 um 16:16 schrieb Gilles Chanteperdrix:
> > On Tue, May 31, 2016 at 04:09:07PM +0200, Wolfgang Netbal wrote:
> >> Dear all,
> >>
> >> we have moved our application from "XENOMAI 2.6.2.1 + Linux 3.0.43" to
> >> "XENOMAI 2.6.4. + Linux 3.10.53". Our target is an i.MX6DL. The system
> >> is now up and running and works stable. Unfortunately we see a
> >> difference in the performance. Our old combination (XENOMAI 2.6.2.1 +
> >> Linux 3.0.43) was slightly faster.
> >>
> >> At the moment it looks like that XENOMAI 2.6.4 calls
> >> xnpod_schedule_handler much more often then XENOMAI 2.6.2.1 in our old
> >> system.  Every call of xnpod_schedule_handler interrupts our main
> >> XENOMAI task with priority = 95.
> >>
> >> I have compared the configuration of both XENOMAI versions but did not
> >> found any difference. I checked the source code (new commits) but did
> >> also not find a solution.
> > Have you tried Xenomai 2.6.4 with Linux 3.0.43 ? In order to see
> > whether it comes from the kernel update or the Xenomai udpate?
> I've tried Linux 3.0.43 with Xenomai 2.6.4 an there is no difference to 
> Xenomai 2.6.2.1
> Looks like there is an other reason than Xenomai.

Ok, one thing to pay attention to on imx6 is the L2 cache write
allocate policy. You want to disable L2 write allocate on imx6 to
get low latencies. I do not know which patches exactly you are
using, so it is difficult to check, but the kernel normally displays
the value set in the L2 auxiliary configuration register, you can
check in the datasheet if it means that L2 write allocate is
disabled or not. And check if you get the same value with 3.0 and
3.10.

-- 
					    Gilles.
https://click-hack.org

