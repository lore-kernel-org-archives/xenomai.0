From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [PATCH v2] gitlab-ci: add cache to decrease build times
Date: Mon, 26 Oct 2020 10:21:06 +0100
Message-Id: <20201026092106.18119-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org, Jan.kiszka@siemens.com

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add the variable CCACHE_DIR to the build to move the ccache from ~/.ccache
to the current directory and upload the cache from each build.

Each job uses a separate cache.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

You can find an example build at:
https://gitlab.com/Quirin.Gy/xenomai/-/pipelines/207559342/builds
On this setup the build time is decrease from 2h to 20min.
Each build has 0.5 cores available.

Changes V2:
 - Move ccache dir to $(pwd)/.ccache instead of .ccache in each build dir.

 .gitlab-ci.yml | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 59bd1d355..d76c9e25e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -56,14 +56,12 @@ variables:
       export CONFIGURE_OPTS="--enable-dlopen-libs --enable-lazy-setsched"
       ;;
       esac
-    - mkdir ~/ccache
-    - ln -s /usr/bin/ccache ~/ccache/aarch64-linux-gnu-gcc
-    - ln -s /usr/bin/ccache ~/ccache/arm-linux-gnueabihf-gcc
-    - ln -s /usr/bin/ccache ~/ccache/powerpc-linux-gnu-gcc
-    - export PATH=~/ccache:$PATH
+    - ln -s /usr/lib/ccache/${CROSS_COMPILE}gcc-8 /usr/lib/ccache/${CROSS_COMPILE}gcc
+    - export PATH=/usr/lib/ccache:$PATH
     - ${CROSS_COMPILE}gcc --version
 
   script:
+    - export CCACHE_DIR=$(pwd)/.ccache
     - pushd ${KDIR}
     - make -j $(nproc) ${KERNEL_DEFCONFIG}
     # Generic settings
@@ -162,7 +160,10 @@ variables:
     - ./configure --enable-smp ${CONFIGURE_OPTS}
     - make -j $(nproc)
     - ccache -s
-
+  cache:
+    key: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
+    paths:
+      - .ccache
 
 arm-4.19-release:
   extends: .build
-- 
2.20.1


