From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/2] Some Dovetail/I-pipe unification
Date: Mon, 14 Jun 2021 14:07:34 +0200
Message-Id: <cover.1623672456.git.jan.kiszka@siemens.com>
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
Cc: Philippe Gerum <philippe.gerum@ixblue.com>

See patches for details.

Jan

Jan Kiszka (2):
  cobalt/ipipe: Drop tests for IPIPE_KEVT_*
  cobalt: Move common debug handling code out of pipeline diversion
    again

 kernel/cobalt/dovetail/kevents.c |  75 ++--------------------
 kernel/cobalt/ipipe/kevents.c    | 105 +++----------------------------
 kernel/cobalt/ipipe/sched.c      |   2 -
 kernel/cobalt/posix/process.c    |  63 +++++++++++++++++++
 kernel/cobalt/posix/process.h    |   6 ++
 5 files changed, 82 insertions(+), 169 deletions(-)

-- 
2.26.2


