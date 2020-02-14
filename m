From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH v2 8/9] recipes-xenomai/xenomai.inc: Add
 missing libxenomai-dev
Date: Fri, 14 Feb 2020 13:27:02 +0100
Message-Id: <20200214122703.7947-9-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200214122703.7947-1-Quirin.Gylstorff@siemens.com>
References: <20200214122703.7947-1-Quirin.Gylstorff@siemens.com>
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

To build against libxenomai headers are necessary.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-xenomai/xenomai/xenomai.inc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index bd07347..3df635c 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -11,8 +11,7 @@
 
 inherit dpkg
 
-PROVIDES += "xenomai-kernel-source xenomai-runtime xenomai-runtime-dbgsym libxenomai1-dbgsym"
-
+PROVIDES += "xenomai-kernel-source xenomai-runtime xenomai-runtime-dbgsym libxenomai1 libxenomai-dev libxenomai1-dbgsym"
 # use bitbake get_srcrev to get the current commit id
 COMMIT="${@bb.fetch2.get_srcrev(d).strip('AUTOINC+')}"
 do_prepare_build() {
-- 
2.20.1


