From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] linux-xenomai: Switch x86 latest to CIP feed
Message-ID: <844a360a-005b-32ae-b203-5d961325945e@siemens.com>
Date: Tue, 17 Mar 2020 20:13:00 +0100
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_latest.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 8f6636b..9ad8e56 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -19,7 +19,7 @@ def is_xeno_3_0(d):
     return xeno_ver.startswith('3.0') or xeno_ver == 'stable-3.0.x'
 
 GIT_REPO_amd64 = "${@'ipipe.git' if is_xeno_3_0(d) else 'ipipe-x86.git'}"
-GIT_BRANCH_amd64 = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe-x86-4.19.y'}"
+GIT_BRANCH_amd64 = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe-x86-4.19.y-cip'}"
 
 GIT_REPO_armhf = "${@'ipipe.git' if is_xeno_3_0(d) else 'ipipe-arm.git'}"
 GIT_BRANCH_armhf = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe/master'}"
-- 
2.16.4


