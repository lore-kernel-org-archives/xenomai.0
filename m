From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b1b25379-83b7-d265-7382-fe8bfc34896d@siemens.com>
Date: Fri, 16 Jun 2017 12:22:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] ipipe-4.4 update
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

The following changes since commit 531597e9b3fdd92fb4b17f08d87e4c54ecceec98:

  ipipe: add support for arm64 to genpatches script (2017-02-13 12:43:55 +0100)

are available in the git repository at:

  git://git.xenomai.org/ipipe-jki for-upstream/4.4

for you to fetch changes up to b2197669dfce41340d9b22e49b86f8dbe4f6aaeb:

  Merge tag 'v4.4.71' into for-upstream/4.4 (2017-06-14 12:28:09 +0200)

----------------------------------------------------------------

[leaving out stable merge]

Jan Kiszka (1):
      ipipe: Fix root domain guard in preempt_schedule_notrace

 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 400a1cd2fbaa..4bf3e3a6b67f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3340,7 +3340,7 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 {
 	enum ctx_state prev_ctx;
 
-	if (likely(!preemptible() || !ipipe_root_p))
+	if (likely(!preemptible() || !ipipe_root_p || hard_irqs_disabled()))
 		return;
 
 	do {

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

