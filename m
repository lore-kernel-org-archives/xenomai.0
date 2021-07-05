From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] README: Update board list
Message-ID: <01b3cb12-7135-27be-76de-8146dee6577a@siemens.com>
Date: Mon, 5 Jul 2021 20:02:17 +0200
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

We replaced the ipc227e with a generic x86-efi target long ago. Also
include the .yml endings in the mentioning to make the relationship
clearer.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index 69b3e13..d97c6aa 100644
--- a/README.md
+++ b/README.md
@@ -32,8 +32,8 @@ installed.
 
 ### Physical Targets
 
-This repository contains recipes for x86 (`board-simatic-ipc227e`),
-armhf(`board-beagle-bone-black`) and arm64(`board-hikey`) targets.
+This repository contains recipes for x86 (`board-x86-64-efi.yml`),
+armhf(`board-beagle-bone-black.yml`) and arm64(`board-hikey.yml`) targets.
 
 Each physical target will generate ready-to-boot images under
 `build/tmp/deploy/images/`. To flash, e.g., the HiKey image to an SD card, run
-- 
2.26.2

