From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Tune config
Message-ID: <417b55d7-464c-9bb9-3742-b9e3edf8369f@siemens.com>
Date: Tue, 9 Apr 2019 21:37:04 +0200
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
Cc: Roman Stratiienko <roman.stratiienko@globallogic.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

- disable DEBUG_INFO which bloats the build out and, thus, the ccache
- grant more size to the ccache, specifically for arm64

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .travis.yml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 2139e499e4..32ae8d2b1c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -14,7 +14,7 @@ env:
   global:
     - KDIR=/tmp/kernel
     - USE_CCACHE=1
-    - CCACHE_MAXSIZE=400M
+    - CCACHE_MAXSIZE=1G
 
 install:
   - git clone --depth 1 --branch ${IPIPE_REV} ${IPIPE_KERNEL} ${KDIR}
@@ -40,6 +40,11 @@ before_script:
   - export PATH=~/ccache:$PATH
   - pushd ${KDIR}
   - make -j $(nproc) ${KERNEL_DEFCONFIG}
+
+  # Generic settings
+  - ./scripts/config -d DEBUG_INFO
+
+  # I-pipe and Xenomai settings
   - ./scripts/config -e IPIPE
   - ./scripts/config -e XENOMAI
   - ./scripts/config -e XENO_OPT_SCHED_CLASSES
@@ -135,6 +140,7 @@ script:
   - scripts/bootstrap
   - ./configure --enable-smp ${CONFIGURE_OPTS}
   - make -j $(nproc)
+
   - ccache -s
 
 matrix:
-- 
2.16.4

