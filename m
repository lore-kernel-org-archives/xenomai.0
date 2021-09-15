From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Drop resource_group from qemu targets
Message-ID: <76f49db6-307b-5f9d-a7f6-c93ea4990f99@siemens.com>
Date: Wed, 15 Sep 2021 07:55:35 +0200
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

We now have 4 available, so the risk having to wait for a free one is
significantly reduced.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Thanks for making this possible, Hongzhan!

 ci/gitlab-ci-base.yml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 13d37b0..8a1dbfb 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -68,7 +68,6 @@ default:
 
 .lava-test:qemu-amd64:
   extends: .test
-  resource_group: board-qemu
   variables:
     TARGET: qemu-amd64
 
@@ -80,7 +79,6 @@ default:
 
 .lava-test:qemu-armhf:
   extends: .test
-  resource_group: board-qemu
   variables:
     TARGET: qemu-armhf
 
@@ -92,7 +90,6 @@ default:
 
 .lava-test:qemu-arm64:
   extends: .test
-  resource_group: board-qemu
   variables:
     TARGET: qemu-arm64
 
-- 
2.31.1

