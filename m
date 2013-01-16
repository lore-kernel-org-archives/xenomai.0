From: Paul <paul_c@tuxcnc.org>
Date: Wed, 16 Jan 2013 10:21:49 +0000
References: <D9F55F45-EC38-45B2-A922-08F24868BA87@mah.priv.at>
	<50F66131.2000903@siemens.com> <50F662A8.9080904@xenomai.org>
In-Reply-To: <50F662A8.9080904@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201301161021.49867.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] universal application binary: how to auto-detect
	Xenomai/RT-PREEMPT/vanilla kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Wednesday 16 January 2013, Gilles Chanteperdrix wrote:
> I may jump to 3.6, at least for the ARM architecture. As for the
> backports to 3.4, I still intend to re-release 2.6.2, so, it would be
> nice to backport the bugfixes in the core-3.5 branch to the core-3.4
> branch.

If you plan on updating the 3.2.21 ipipe-core patch, any chance you 
could include the fix to timer.c that you kindly provided a patch for 
(see 
http://www.xenomai.org/pipermail/xenomai/2012-August/026015.html )

I notice the bug affects all architectures, not just the ARM across the 
3.2.21 patch set. Other kernel versions already have the fix applied.
Thanks.


Regards, Paul.


