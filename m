From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/3] More pipeline abstraction cleanups
Date: Tue, 15 Jun 2021 08:56:30 +0200
Message-Id: <cover.1623740192.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

More de-duplications, see patches for details

Jan

Jan Kiszka (3):
  cobalt: Move common affinity handling code out of pipeline diversion
    again
  cobalt: Move common cleanup code out of pipeline diversion again
  cobalt: Move common user-return code out of pipeline diversion again

 .../cobalt/kernel/dovetail/pipeline/kevents.h |   2 +
 .../cobalt/kernel/ipipe/pipeline/kevents.h    |   2 +
 kernel/cobalt/dovetail/kevents.c              | 258 +----------------
 kernel/cobalt/ipipe/kevents.c                 | 260 +-----------------
 kernel/cobalt/posix/process.c                 | 242 ++++++++++++++++
 kernel/cobalt/posix/process.h                 |  14 +
 6 files changed, 286 insertions(+), 492 deletions(-)

-- 
2.26.2


