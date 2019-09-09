From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [PATCH 2/2] debian/rules: Add missing bootstrap step
Date: Mon,  9 Sep 2019 17:28:42 +0200
Message-Id: <20190909152842.1326-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20190909152842.1326-1-Quirin.Gylstorff@siemens.com>
References: <20190909152842.1326-1-Quirin.Gylstorff@siemens.com>
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

To build a debian package it is necessary to execute
scripts/bootstrap to generate the configure. Add the missing
 step to the debian rules file.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 debian/rules | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/debian/rules b/debian/rules
index 3d5729c22..08562c7ab 100755
--- a/debian/rules
+++ b/debian/rules
@@ -38,7 +38,12 @@ build-indep-stamp: config.status
 	dh_testdir
 	touch build-indep-stamp
 
-config.status: configure-stamp
+config.status: bootstrap configure-stamp
+
+bootstrap:
+	dh_testdir
+	./scripts/bootstrap
+
 configure-stamp:
 	dh_testdir
 	./configure $(CONFIG_OPTS)
-- 
2.20.1


