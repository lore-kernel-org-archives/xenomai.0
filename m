From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] Use github as PREMIRROR
Message-ID: <1e308eb3-ae0e-a80f-803a-cdc026952739@siemens.com>
Date: Thu, 19 Dec 2019 12:27:40 +0100
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

This removes load from gitlab.denx.de and is likely also more reliable.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kas.yml b/kas.yml
index e3c6641..78bd83d 100644
--- a/kas.yml
+++ b/kas.yml
@@ -41,3 +41,6 @@ local_conf_header:
     ISAR_CROSS_COMPILE = "1"
   xenomai-version: |
     PREFERRED_VERSION_xenomai ?= "stable"
+  github-mirror: |
+    PREMIRRORS_prepend = " \
+        git://gitlab.denx.de/Xenomai/ git://github.com/xenomai-ci/ \n"
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

