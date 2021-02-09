From: Giulio Moro <g.moro@qmul.ac.uk>
Subject: [xenomai-images][PATCH] Fix linux repo for 5.10 ARM
Message-ID: <0bf0a241-624c-0d9e-7dc8-25eaa69de85e@qmul.ac.uk>
Date: Tue, 9 Feb 2021 17:49:11 +0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro via Xenomai <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>

From: Giulio Moro <giuliomoro@yahoo.it>

Signed-off-by: Giulio Moro <giuliomoro@yahoo.it>
---
  recipes-kernel/linux/linux-xenomai_latest.bb | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index bbec6b0..e6834fd 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -25,7 +25,7 @@ def is_kernel(d, ver):
  GIT_REPO_amd64 = "${@'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) else 'git://git.evlproject.org/linux-evl.git' if is_kernel(d, '5.10') else 'git://github.com/xenomai-ci/ipipe-x86.git'}"
  GIT_BRANCH_amd64 = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'dovetail/master' if is_kernel(d, '5.10') else 'ipipe-x86-5.4.y' if is_kernel(d, '5.4') else 'ipipe-x86-4.19.y-cip'}"

-GIT_REPO_armhf = "${@'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) else 'git://github.com/xenomai-ci/ipipe-arm.git'}"
+GIT_REPO_armhf = "${@'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) else 'git://git.evlproject.org/linux-evl.git' if is_kernel(d, '5.10') else 'git://github.com/xenomai-ci/ipipe-arm.git'}"
  GIT_BRANCH_armhf = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'dovetail/master' if is_kernel(d, '5.10') else 'ipipe/5.4.y' if is_kernel(d, '5.4') else 'ipipe/4.19-y-cip'}"

  GIT_REPO_arm64 = "git://github.com/xenomai-ci/ipipe-arm64.git"
--
2.17.1

