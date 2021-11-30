From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] linux-xenomai: Define default GIT_REPO/BRANCH
 in latest recipe
Message-ID: <5db209a2-9676-37c4-21cb-06c11471512a@siemens.com>
Date: Tue, 30 Nov 2021 07:52:45 +0100
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

This allows to build the layer against i386 DISTRO_ARCH.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_latest.bb | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 836fa52..05946f7 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -22,8 +22,9 @@ def is_kernel(d, ver):
     linux_ver = d.getVar('LATEST_GIT_BRANCH') or ''
     return linux_ver.startswith(ver)
 
-GIT_REPO_amd64 = "${@'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) else 'git://source.denx.de/xenomai/linux-dovetail.git' if is_kernel(d, '5.10') else 'git://github.com/xenomai-ci/ipipe-x86.git'}"
-GIT_BRANCH_amd64 = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') else 'ipipe-x86-5.4.y' if is_kernel(d, '5.4') else 'ipipe-x86-4.19.y-cip'}"
+# default: amd64 or i386
+GIT_REPO = "${@'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) else 'git://source.denx.de/xenomai/linux-dovetail.git' if is_kernel(d, '5.10') else 'git://github.com/xenomai-ci/ipipe-x86.git'}"
+GIT_BRANCH = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') else 'ipipe-x86-5.4.y' if is_kernel(d, '5.4') else 'ipipe-x86-4.19.y-cip'}"
 
 GIT_REPO_armhf = "${@'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) else 'git://source.denx.de/xenomai/linux-dovetail.git' if is_kernel(d, '5.10') else 'git://github.com/xenomai-ci/ipipe-arm.git'}"
 GIT_BRANCH_armhf = "${@'ipipe-4.4.y-cip' if is_xeno_3_0(d) else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') else 'ipipe/5.4.y' if is_kernel(d, '5.4') else 'ipipe/4.19.y-cip'}"
-- 
2.31.1

