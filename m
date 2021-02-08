From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 1/2] linux-xenomai: Fix arm/arm64 latest
 branches, add 5.4 option
Message-ID: <ca6c935b-a10c-589c-502d-0b9e439c7089@siemens.com>
Date: Mon, 8 Feb 2021 21:48:22 +0100
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

ipipe/master was no longer tracking the latest arm/arm64 I-pipe
versions.

While at it, add the new 5.4 branches.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_latest.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index f7d9e1b..9dd4c93 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -26,10 +26,10 @@ GIT_REPO_amd64 = "${@'ipipe.git' if is_xeno_3_0(d) else 'ipipe-x86.git'}"
 GIT_BRANCH_amd64 = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe-x86-5.4.y' if is_5_4_branch(d) else 'ipipe-x86-4.19.y-cip'}"
 
 GIT_REPO_armhf = "${@'ipipe.git' if is_xeno_3_0(d) else 'ipipe-arm.git'}"
-GIT_BRANCH_armhf = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe/master'}"
+GIT_BRANCH_armhf = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'ipipe/5.4.y' if is_5_4_branch(d) else 'ipipe/4.19-y-cip'}"
 
 GIT_REPO_arm64 = "ipipe-arm64.git"
-GIT_BRANCH_arm64 = "ipipe/master"
+GIT_BRANCH_arm64 = "${@'ipipe/5.4.y' if is_5_4_branch(d) else 'ipipe/4.19.y-cip'}"
 
 SRC_URI += "git://github.com/xenomai-ci/${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
-- 
2.26.2

