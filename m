Message-ID: <4B680C45.5040704@domain.hid>
Date: Tue, 02 Feb 2010 12:28:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B5EB6EF.2080306@domain.hid>
In-Reply-To: <4B5EB6EF.2080306@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [pull request] Improved SIGDEBUG (SIGXCPU)
	reporting
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> The following changes since commit 2036a36f132f2456459962ae9baf1f14d93448bd:
>   Gilles Chanteperdrix (1):
>         arm: upgrade I-pipe support to 2.6.30-arm-1.5.10
> 
> are available in the git repository at:
> 
>   git://git.xenomai.org/xenomai-jki.git for-upstream
> 
> Jan Kiszka (1):
>       Rename SIGXCPU to SIGDEBUG and deliver reason via siginfo
> 
>  examples/native/Makefile      |    2 +-
>  examples/native/sigdebug.c    |   82 +++++++++++++++++++++++++++++++++++++++++
>  examples/native/sigxcpu.c     |   70 -----------------------------------
>  include/asm-generic/syscall.h |    9 ++++
>  include/nucleus/shadow.h      |    2 +-
>  ksrc/nucleus/Kconfig          |    2 +-
>  ksrc/nucleus/pod.c            |    3 +-
>  ksrc/nucleus/sched.c          |    2 +-
>  ksrc/nucleus/shadow.c         |   45 ++++++++++++++--------
>  ksrc/nucleus/synch.c          |    6 ++-
>  ksrc/skins/native/syscall.c   |    6 +-
>  ksrc/skins/posix/signal.c     |    2 +-
>  ksrc/skins/posix/thread.c     |    2 +-
>  13 files changed, 135 insertions(+), 98 deletions(-)
>  create mode 100644 examples/native/sigdebug.c
>  delete mode 100644 examples/native/sigxcpu.c
> 
> 
> Would be nice to see this in 2.5.x as well. It comes with no user space
> ABI breakage, only enhancements.

Merged, thanks.

-- 
					    Gilles.

