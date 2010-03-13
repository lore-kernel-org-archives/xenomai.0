From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B9BCB7F.9070307@domain.hid>
References: <1268327902.27899.106.camel@domain.hid>
	<4B9BC504.8070704@domain.hid>  <4B9BCB7F.9070307@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 13 Mar 2010 19:42:10 +0100
Message-ID: <1268505730.27899.173.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL REQUEST] Blackfin upgrade and minor fixes
 for 2.5.x
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Sat, 2010-03-13 at 18:29 +0100, Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> >> The following changes since commit 55b0aa9de28891fcfd4b4ab097583bd7619223ab:
> >>   Philippe Gerum (1):
> >>         native: introduce rt_task_same()
> >>
> >> are available in the git repository at:
> >>
> >>   git://xenomai.org/xenomai-rpm.git for-upstream
> >>
> >> Philippe Gerum (5):
> >>       testsuite/latency: fix false positive in mode switch detection
> >>       powerpc: remove dandling reference
> >>       blackfin: upgrade I-pipe support to 2.6.33-blackfin-1.13-00
> > 
> > Could you upgrade the blackfin README file to include the tag to use,
> > for applying this patch?
> > 
> 
> In fact, it seems the ipipe-blackfin git has no tags.
> 
> 

ipipe-blackfin only contains reference snapshots of the kernel code for
the pre 2.6.33 releases we still support; the Blackfin dev trunk we used
to be based on is periodically rebased, which requires us to keep those
stable snapshots.

ipipe-blackfin is now dead, only kept for reference. The pipeline dev
now occurs in ipipe-2.6 with other supports for mainlined architectures.

-- 
Philippe.



