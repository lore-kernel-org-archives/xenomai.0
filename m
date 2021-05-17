Subject: [xenomai-images][PATCH v2 1/9] ci: Create resource groups for all
 LAVA boards
References: <cover.1620808343.git.jan.kiszka@siemens.com>
 <011cc0ea0a524415333b8eebbcca4126964ae327.1620808343.git.jan.kiszka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <73d050c0-141a-53c5-b2b1-74efa01f3a47@siemens.com>
Date: Mon, 17 May 2021 17:37:25 +0200
MIME-Version: 1.0
In-Reply-To: <011cc0ea0a524415333b8eebbcca4126964ae327.1620808343.git.jan.kiszka@siemens.com>
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
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

We currently have only one instance per board in our lab, and there is
only one QEMU instance max, independently of the architecture. So far,
test jobs requesting the same one can start in parallel and will then
wait on the LAVA cli, consuming job time. Avoid this at CI level
already.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - put all QEMUs into one group (misunderstanding of mine...)

 ci/gitlab-ci-base.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 53ae66b..28c383c 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -47,6 +47,7 @@ default:
 
 .lava-test:qemu-amd64:
   extends: .test
+  resource_group: board-qemu
   variables:
     TARGET: qemu-amd64
 
@@ -58,6 +59,7 @@ default:
 
 .lava-test:qemu-armhf:
   extends: .test
+  resource_group: board-qemu
   variables:
     TARGET: qemu-armhf
 
@@ -69,6 +71,7 @@ default:
 
 .lava-test:qemu-arm64:
   extends: .test
+  resource_group: board-qemu
   variables:
     TARGET: qemu-arm64
 
@@ -80,6 +83,7 @@ default:
 
 .lava-test:board-hikey:
   extends: .test
+  resource_group: board-hikey
   variables:
     TARGET: hikey
 
@@ -91,6 +95,7 @@ default:
 
 .lava-test:board-beagle-bone-black:
   extends: .test
+  resource_group: board-beagle-bone-black
   variables:
     TARGET: beagle-bone-black
 
@@ -102,5 +107,6 @@ default:
 
 .lava-test:board-x86-64-efi:
   extends: .test
+  resource_group: board-x86-64-efi
   variables:
     TARGET: x86-64-efi
-- 
2.26.2

