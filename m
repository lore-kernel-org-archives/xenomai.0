From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 3/3] distro/include: Allow overwrite
 PREFERRED_VERSION
Date: Tue, 27 Aug 2019 11:07:52 +0200
Message-Id: <20190827090752.13072-4-Quirin.Gylstorff@siemens.com>
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

To build arm64 PREFERRED_VERSION_linux-xenomai must be
set to 4.14% instead of 4.19 for next. To allow overwrites
by machine configurations change the operator from = to ?=.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/include/xenomai-version.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index f14f458..524ca39 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -14,4 +14,4 @@ XENOMAI_STABLE_VERSION_LIST = "stable 3.0 3.0% 3.0.% 3.0.9"
 XENOMAI_STABLE_KERNEL_VERSION = "4.14%"
 # if PREFERRED_VERSION_xenomai contains any item from XENOMAI_STABLE_VERSION_LIST use
 # XENOMAI_STABLE_KERNEL_VERSION
-PREFERRED_VERSION_linux-xenomai = "${@bb.utils.contains_any('PREFERRED_VERSION_xenomai','${XENOMAI_STABLE_VERSION_LIST}','${XENOMAI_STABLE_KERNEL_VERSION}','${XENOMAI_NEXT_KERNEL_VERSION}',d) }"
+PREFERRED_VERSION_linux-xenomai ?= "${@bb.utils.contains_any('PREFERRED_VERSION_xenomai','${XENOMAI_STABLE_VERSION_LIST}','${XENOMAI_STABLE_KERNEL_VERSION}','${XENOMAI_NEXT_KERNEL_VERSION}',d) }"
-- 
2.20.1


