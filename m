From: Henning Schild <henning.schild@siemens.com>
Date: Tue, 13 Feb 2018 13:38:21 +0100
Message-Id: <99b834a80072dac92113885f8174bf479caceff9.1518525088.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518525088.git.henning.schild@siemens.com>
References: <cover.1518525088.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518525088.git.henning.schild@siemens.com>
References: <cover.1518525088.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 3/3] debian: increase debian compat level
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

We currently use level 8 which is marked deprecated in Debian stable,
increase the number by one to suppress the following warnings:

> dh_*: Compatibility levels before 9 are deprecated (level 8 in use)

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 debian/compat | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/debian/compat b/debian/compat
index 45a4fb75d..ec635144f 100644
--- a/debian/compat
+++ b/debian/compat
@@ -1 +1 @@
-8
+9
-- 
2.13.6


