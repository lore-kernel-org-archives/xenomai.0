From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v2 2/8] ci: Disable partition expanding for
 all real test boards
Date: Wed, 13 Oct 2021 14:17:26 +0200
Message-Id: <20211013121732.140595-3-florian.bezdeka@siemens.com>
In-Reply-To: <20211013121732.140595-1-florian.bezdeka@siemens.com>
References: <20211013121732.140595-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Trying to expand the partition during first boot doesn't make sense
as we use NFS for deployment. Removing it helps to reduce the first boot
time a bit.

It is disabled on all qemu machines in the machine config, as we can
handle all qemu machines at once there. For real boards we want it to
stay, but not when building for CI tests.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 opt-ci-board.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/opt-ci-board.yml b/opt-ci-board.yml
index 9c33da6..d894fe7 100644
--- a/opt-ci-board.yml
+++ b/opt-ci-board.yml
@@ -18,3 +18,5 @@ header:
 local_conf_header:
   image-type: |
     IMAGE_TYPE = "targz-img"
+  xenomai-ci: |
+    IMAGE_INSTALL_remove += "expand-on-first-boot"
\ No newline at end of file
-- 
2.31.1


