Message-ID: <520A877B.2080609@xenomai.org>
Date: Tue, 13 Aug 2013 21:22:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <520A7DE7.5000906@xenomai.org>
In-Reply-To: <520A7DE7.5000906@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] pull request for ipipe-3.8 branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 08/13/2013 08:41 PM, Gilles Chanteperdrix wrote:
> The following changes since commit ab0f844da1e47a650fa36244713f08584f7ccf8a:
> 
>   blackfin/ipipe: introduce support for bf60x (2013-06-24 16:07:25 +0200)
> 
> are available in the git repository at:
>   git://git.xenomai.org/ipipe-gch.git for-ipipe-3.8
> 
> Gilles Chanteperdrix (7):
>       x86/ipipe: fix compilation without I-pipe
>       arm/ipipe: fix mxs interrupt handler
>       ipipe/tracer: fix console messages alignment
>       arm/ipipe: rework context switch with VIVT caches
>       arm/ipipe: fix unlocked context switch with FCSE best-effort
>       arm/ipipe: add debug checks
>       arm/ipipe: split full L2 cache flush

Sorry, one commit got forgotten:

The following changes since commit ab0f844da1e47a650fa36244713f08584f7ccf8a:

  blackfin/ipipe: introduce support for bf60x (2013-06-24 16:07:25 +0200)

are available in the git repository at:
  git://git.xenomai.org/ipipe-gch.git for-ipipe-3.8

Gilles Chanteperdrix (8):
      x86/ipipe: fix compilation without I-pipe
      arm/ipipe: fix mxs interrupt handler
      ipipe/tracer: fix console messages alignment
      arm/ipipe: rework context switch with VIVT caches
      arm/ipipe: fix unlocked context switch with FCSE best-effort
      arm/ipipe: add debug checks
      arm/ipipe: invert ipipe_syscall_root return value sign
      arm/ipipe: split full L2 cache flush

 arch/arm/include/asm/fcse.h        |   26 +++++++++---
 arch/arm/include/asm/mmu_context.h |   36 +++++++++--------
 arch/arm/kernel/entry-common.S     |    4 +-
 arch/arm/kernel/entry-header.S     |   12 ++++++
 arch/arm/kernel/ipipe.c            |   75 +++++++++++++++++++++++++++--------
 arch/arm/mach-mxs/icoll.c          |    2 +-
 arch/arm/mm/cache-l2x0.c           |   39 ++++++++++++++++++
 arch/arm/mm/fcse.c                 |   70 ++++++++++++++++++++-------------
 kernel/ipipe/tracer.c              |    2 +-
 kernel/time/clocksource.c          |    2 +
 10 files changed, 198 insertions(+), 70 deletions(-)


-- 
                                                                Gilles.

