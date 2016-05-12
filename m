Date: Thu, 12 May 2016 18:31:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160512163142.GC18298@hermes.click-hack.org>
References: <5734A9F8.10305@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5734A9F8.10305@siemens.com>
Subject: Re: [Xenomai] RTDM syscalls & switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, May 12, 2016 at 06:06:16PM +0200, Jan Kiszka wrote:
> Gilles,
> 
> regarding commit bec5d0dd42 (rtdm: make syscalls conforming rather than
> current) - I remember a discussion on that topic, but I do not find its
> traces any more. Do you have a pointer
> 
> In any case, I'm confronted with a use case for the old (Xenomai 2),
> lazy switching behaviour: lightweight, performance sensitive IOCTL
> services that can (and should) be called without any switching from both
> domains.

Why not using a plain linux driver? ioctl_nrt callbacks are
redundant with plain linux drivers.

> 
> What were the arguments in favour of migrating threads to real-time first?
> 
> I currently see the real need only for IOCTLs, but the question is then
> if we shouldn't go back to "__xn_exec_current" in all RTDM cases to
> avoid unwanted migration costs (which are significantly higher than
> syscall restarts).

I do not find commit bec5d0dd42 in xenomai-2.6 git tree, and I do
not remember merging this. However I find commit
13bfdd477ab880499d2e8f3b82c49ef4d2cccff0 from 2010 which seems to
explain the reason pretty clear.

At the time of the discussion we had concluded that it was the way
to go. With __xn_exec_current you may enter the ioctl_rt callback
from secondary domain, which is counter-intuitive, error-prone, and
forces you to cripple driver code for checks for the current domain.
It optimizes the secondary mode case at the expense of the primary
mode case which is the inverse of what should be done. With
__xn_exec_conforming, you have the guarantee to enter ioctl_rt over
primary domain and ioctl_nrt over secondary domain.

See Philippe prose here also:
https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Adaptive_syscalls

-- 
					    Gilles.
https://click-hack.org

