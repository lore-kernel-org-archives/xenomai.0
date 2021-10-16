From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 0/3] More latest glibc/gcc build fixes
Date: Sat, 16 Oct 2021 20:31:22 +0200
Message-Id: <cover.1634409085.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Found while test-building against ALT linux.

Jan


CC: Jan Kiszka <jan.kiszka@siemens.com>

Jan Kiszka (3):
  testsuite/latency: Use corresponding pclose for popen
  lib/boilerplate: Convert pthread_mutexattr_setrobust_np stub into
    inline function
  lib: Switch to pthread_mutexattr_setrobust

 configure.ac                |  1 +
 include/boilerplate/libc.h  | 14 +++++++++++---
 lib/alchemy/mutex.c         |  4 ++--
 lib/vxworks/semLib.c        |  4 ++--
 testsuite/latency/latency.c |  2 +-
 5 files changed, 17 insertions(+), 8 deletions(-)

=2D-
2.31.1


