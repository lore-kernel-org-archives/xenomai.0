From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 13/17] cobalt/tick: dovetail: Drop pointless inline specifier
 from pipeline_must_force_program_tick
Date: Fri, 11 Jun 2021 20:05:39 +0200
Message-Id: <45cdd37e28e904735e8d9c32200f75dc07d64c6d.1623434743.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623434743.git.jan.kiszka@siemens.com>
References: <cover.1623434743.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/tick.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/tick.h b/include/cobalt/kernel/dovetail/pipeline/tick.h
index 8ac4760ec..372d8323f 100644
--- a/include/cobalt/kernel/dovetail/pipeline/tick.h
+++ b/include/cobalt/kernel/dovetail/pipeline/tick.h
@@ -11,6 +11,6 @@ void pipeline_uninstall_tick_proxy(void);
 
 struct xnsched;
 
-inline bool pipeline_must_force_program_tick(struct xnsched *sched);
+bool pipeline_must_force_program_tick(struct xnsched *sched);
 
 #endif /* !_COBALT_KERNEL_IPIPE_TICK_H */
-- 
2.26.2


