From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] linux-xenomai: Disable I-pipe debugging on bbb also for
 4.4-latest
Message-ID: <21a296a1-f797-a386-ce37-475c2bf88f75@siemens.com>
Date: Fri, 13 Aug 2021 16:47:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This was missed by 1ba9500dd5.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_latest.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 09df461..836fa52 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -34,4 +34,6 @@ GIT_BRANCH_arm64 = "${@'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') else 'i
 SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
 
+SRC_URI_append_armhf = " ${@ 'file://bbb_4.4.cfg' if is_xeno_3_0(d) and d.getVar('MACHINE') == 'beagle-bone-black' else '' }"
+
 S = "${WORKDIR}/git"
-- 
2.31.1

