Message-ID: <538B74F8.7020008@xenomai.org>
Date: Sun, 01 Jun 2014 20:46:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <538B5F2C.9030608@xenomai.org>
In-Reply-To: <538B5F2C.9030608@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Please pull from xenomai-gch.git
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 06/01/2014 07:13 PM, Gilles Chanteperdrix wrote:
> The following changes since commit c00754093d283247695356d416608daab0979786:
> 
>   cobalt/rtdm/mutex: add fast locking support (2014-05-29 21:33:12 +0200)
> 
> are available in the git repository at:
> 
>   git://git.xenomai.org/xenomai-gch.git for-forge

Fixed an issue with debugging, and rebased on forge/next.

The following changes since commit b0d68713102f8ecd81d1c7a4a1ef66d51ac4c99c:

  analogy/testing: continue the main loop until task destruction (2014-05-30 12:59:56 -0400)

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-forge

for you to fetch changes up to 5fbfaeb911cc590a82f5b713d1231e20ec86a6be:

  regression: add clock_settime test (2014-06-01 20:44:18 +0200)

----------------------------------------------------------------
Gilles Chanteperdrix (3):
      cobalt/sched: fix compilation without SCHED_QUOTA
      cobalt/timers: avoid periodic timer drift
      regression: add clock_settime test

 include/cobalt/kernel/timer.h              |   60 ++++++---
 kernel/cobalt/clock.c                      |   40 +++---
 kernel/cobalt/posix/sched.c                |    6 +-
 kernel/cobalt/posix/sched.h                |    2 +
 kernel/cobalt/posix/timer.c                |    6 +-
 kernel/cobalt/posix/timerfd.c              |    2 +-
 kernel/cobalt/thread.c                     |    2 +-
 kernel/cobalt/timer.c                      |   44 ++-----
 testsuite/regression/posix/Makefile.am     |    1 +
 testsuite/regression/posix/clock_settime.c |  224 ++++++++++++++++++++++++++++++++
 10 files changed, 320 insertions(+), 67 deletions(-)
 create mode 100644 testsuite/regression/posix/clock_settime.c



-- 
                                                                Gilles.

