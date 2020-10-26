From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] linux-xenomai: Move latest x86 to 5.4
Message-ID: <d6136f8d-55f5-161f-9e5c-71b82e5b2900@siemens.com>
Date: Mon, 26 Oct 2020 13:35:10 +0100
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
To: Xenomai <xenomai@xenomai.org>, Quirin Gylstorff <quirin.gylstorff@siemens.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Quirin, I wonder if we could afford testing 4.19 head as well. And how 
to model that best.

 recipes-kernel/linux/linux-xenomai_latest.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 9ad8e56..9fc6a63 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -19,7 +19,7 @@ def is_xeno_3_0(d):
     return xeno_ver.startswith('3.0') or xeno_ver == 'stable-3.0.x'
 
 GIT_REPO_amd64 = "${@'ipipe.git' if is_xeno_3_0(d) else 'ipipe-x86.git'}"
-GIT_BRANCH_amd64 = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe-x86-4.19.y-cip'}"
+GIT_BRANCH_amd64 = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe-x86-5.4.y'}"
 
 GIT_REPO_armhf = "${@'ipipe.git' if is_xeno_3_0(d) else 'ipipe-arm.git'}"
 GIT_BRANCH_armhf = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe/master'}"
-- 
2.26.2

