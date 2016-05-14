Date: Sat, 14 May 2016 16:30:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160514143012.GC30749@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] Please pull from xenomai-gch.git
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

The following changes since commit 73141639fc3902382dfcccdf30dc9023cbc0caa5:

  cobalt/kernel: Trigger missing reschedule after PP deboost (2016-05-14 15:23:40 +0200)

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git next

for you to fetch changes up to 15a799e1edf1da86ad80b5d19cb6d3c704c6e614:

  cobalt/timer: replace bheap with rbtree (2016-05-14 16:00:07 +0200)

----------------------------------------------------------------
Gilles Chanteperdrix (1):
      cobalt/timer: replace bheap with rbtree

 include/cobalt/kernel/Makefile.am |   1 -
 include/cobalt/kernel/bheap.h     | 266 ---------------------------------------------
 include/cobalt/kernel/timer.h     |  80 ++++++++------
 kernel/cobalt/Kconfig             |  14 +--
 kernel/cobalt/clock.c             |   2 +-
 kernel/cobalt/timer.c             |  34 +++++-
 6 files changed, 87 insertions(+), 310 deletions(-)
 delete mode 100644 include/cobalt/kernel/bheap.h


-- 
					    Gilles.
https://click-hack.org

