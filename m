Date: Sat, 3 Oct 2015 15:33:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151003133341.GC31137@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] xenomai-3 pull request
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit 8d2fb51e0cd41ee9ccfbc6a51acdbcf682172df8:

  demo/posix/cyclictest: drop conflicting definitions (2015-10-03 11:18:18 +0200)

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-forge

for you to fetch changes up to 82bb96c63c8413f2e0d6cd050caeee676aaf6d77:

  rtnet/macb: add compatible string for sama5d3 gem (2015-10-03 14:40:12 +0200)

----------------------------------------------------------------
Gilles Chanteperdrix (4):
      cobalt/cond: fix autoinit
      smokey/posix-cond: add testcase for autoinit
      posix/mutex: fix autoinit
      rtnet/macb: add compatible string for sama5d3 gem

 kernel/drivers/net/drivers/macb.c        |  1 +
 lib/cobalt/cond.c                        |  5 ----
 lib/cobalt/init.c                        |  2 +-
 lib/cobalt/internal.h                    |  2 +-
 lib/cobalt/mutex.c                       | 26 +++++++++++++++--
 testsuite/smokey/posix-cond/posix-cond.c | 53 ++++++++++++++++++++++++++++++++++
 6 files changed, 79 insertions(+), 10 deletions(-)

-- 
					    Gilles.
https://click-hack.org

