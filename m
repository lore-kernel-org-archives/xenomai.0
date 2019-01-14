From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] Remove last version naming fragment
Message-ID: <813e895f-43c3-7b4f-9ba1-1f8c1a22ca0d@siemens.com>
Date: Mon, 14 Jan 2019 10:57:00 +0100
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

That file was removed with f1da4876271d.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 config/Makefile.am | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config/Makefile.am b/config/Makefile.am
index 96786b4ac0..9ce4a9c843 100644
--- a/config/Makefile.am
+++ b/config/Makefile.am
@@ -4,5 +4,4 @@ EXTRA_DIST= 		\
 	apirev		\
 	version-label	\
 	version-code	\
-	version-name	\
 	ac_prog_cc_for_build.m4
-- 
2.16.4

