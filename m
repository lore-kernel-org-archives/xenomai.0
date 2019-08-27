From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 1/3] README: Add subsection physical targets
Date: Tue, 27 Aug 2019 11:07:50 +0200
Message-Id: <20190827090752.13072-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20190827090752.13072-1-Quirin.Gylstorff@siemens.com>
References: <20190827090752.13072-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

List all physical targets with their kas-yml files.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 README.md | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index e6b2349..f65eac7 100644
--- a/README.md
+++ b/README.md
@@ -30,7 +30,12 @@ The QEMU ARM64 target is selected by `... kas.yml:board-qemu-arm64.yml` and
 started via `start-qemu.sh arm64`. Make sure to have `qemu-aarch64-system`
 installed.
 
-Physical targets will generate ready-to-boot images under
+### Physical Targets
+
+This repository contains recipes for x86 (`board-simatic-ipc227e`),
+armhf(`board-beagle-bone-black`) and arm64(`board-hikey`) targets.
+
+Each physical target will generate ready-to-boot images under
 `build/tmp/deploy/images/`. To flash, e.g., the HiKey image to an SD card, run
 
     dd if=build/tmp/deploy/images/hikey/demo-image-hikey-xenomai-demo-hikey.wic.img \
-- 
2.20.1


