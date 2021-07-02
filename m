From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/4] Add RTDM APIs for interrupt affinity configuration
Date: Fri,  2 Jul 2021 16:27:43 +0200
Message-Id: <cover.1625236067.git.jan.kiszka@siemens.com>
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

Requested by users who were already calling lower-level APIs instead.

Jan

Jan Kiszka (4):
  cobalt/intr: Fix cpumask argument type of xnintr_affinity
  cobalt/intr: Add error handling to xnintr_affinity
  cobalt/intr: Enhance xnintr_attach with an initial cpumask
  cobalt/rtdm: Introduce IRQ affinity services

 include/cobalt/kernel/intr.h        |  5 ++-
 include/cobalt/kernel/rtdm/driver.h | 12 +++++++
 kernel/cobalt/dovetail/intr.c       | 24 +++++++++----
 kernel/cobalt/ipipe/intr.c          | 36 +++++++++++++++++---
 kernel/cobalt/rtdm/drvlib.c         | 52 +++++++++++++++++++++++++++--
 5 files changed, 113 insertions(+), 16 deletions(-)

-- 
2.26.2


