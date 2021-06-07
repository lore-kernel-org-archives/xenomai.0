From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH v3 0/3] Fix state corruption on fault migration,
 cleanups
Date: Mon,  7 Jun 2021 08:19:36 +0200
Message-Id: <cover.1623046779.git.jan.kiszka@siemens.com>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Changes in v3:
 - do not track oob stalling on iryentry
 - add check that oob is unstalled on irqentry

Jan

Jan Kiszka (3):
  irq_pipeline: Clean up stage_info field and users
  irq_pipeline: Account for stage migration across faults
  irq_pipeline: Warn when calling irqentry_enter with oob stalled

 arch/x86/kernel/irq_pipeline.c |  2 +-
 arch/x86/mm/fault.c            |  2 +-
 include/linux/entry-common.h   | 11 ++++++++---
 kernel/entry/common.c          | 17 ++++++++++-------
 4 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.26.2


