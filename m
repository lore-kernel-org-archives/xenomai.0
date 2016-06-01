Date: Wed, 1 Jun 2016 15:30:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160601133024.GB14103@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A739854@mb2010-1.intra.tut.fi>
 <20160601122543.GA14103@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A73A888@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A73A888@mb2010-1.intra.tut.fi>
Subject: Re: [Xenomai] rtdm_timer_start causes switching to secondary mode
 and Bug
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ali Umair <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Jun 01, 2016 at 01:03:18PM +0000, Ali Umair wrote:
> Hello
> 
> Thanks Gilles and sorry for first incomplete email. The code files and kernel log files are attached with this email

Ok, I see you have not read "Linux devices drivers" as I advised. I
am not going to tell you everything which is wrong in that driver,
because there are to many things really, beginner's programming
error with using memset or off by one errors in indexes, ignorance
of best practices in error handling (in kernel modules or
otherwise), disregard to concurrence issues, disregard to support of
multiple simultaneous file descriptors.

I do see a lot of things wrong in your code, I do not see which is
causing rtdm_timer_start to fail. But I am sure there is nothing
wrong with Xenomai's rtdm_timer_start and that the problem is in
your code. You can see that rtdm_timer_start is working by using
latency -t 1 for instance. If latency -t 1 causes an issue on your
platform, then we will have a look.

Regards.

-- 
					    Gilles.
https://click-hack.org

