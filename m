From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <56CB534A.50800@siemens.com>
Date: Mon, 22 Feb 2016 19:28:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] Fixes for timer read-back and around shared
	libraries
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit 671a0ef832b0bdc958e85d919f18cef87530a669:

  doc/rtdm: work around Doxygen weirdness (2016-02-16 12:08:31 +0100)

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-forge

for you to fetch changes up to ae50d6aa377ad34f01f8de8fa1ab694a2573927a:

  cobalt/posix/timer: Return interval value also for stopped timers (2016-02-22 18:45:22 +0100)

----------------------------------------------------------------
Jan Kiszka (4):
      boilerplate: Allow for enabling Xenomai only in shared libs
      cobalt/posix/timer: Allow extension to override timer_gettimeout value
      cobalt/posix/timer: Remove redundant test for stopped timers
      cobalt/posix/timer: Return interval value also for stopped timers

 kernel/cobalt/posix/timer.c      | 22 +++++++---------------
 lib/boilerplate/init/Makefile.am |  1 +
 lib/boilerplate/wrappers.c       |  5 ++++-
 3 files changed, 12 insertions(+), 16 deletions(-)

