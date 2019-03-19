From: roman.stratiienko@globallogic.com
Subject: [PATCH] travis: add checkpatch analysis
Date: Tue, 19 Mar 2019 16:28:22 +0200
Message-Id: <20190319142822.31027-1-roman.stratiienko@globallogic.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Roman Stratiienko <roman.stratiienko@globallogic.com>

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

Check last 10 commits with checkpatch.pl before build

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index 0cd9e571f..6fb604bf2 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -78,6 +78,7 @@ before_script:
   - popd
 
 script:
+  - ${KDIR}/scripts/checkpatch.pl --git HEAD~10..HEAD
   - scripts/prepare-kernel.sh --ipipe=/tmp/ipipe.patch --arch=${ARCH} --linux=${KDIR}
   - pushd ${KDIR}
   - make -j $(nproc) olddefconfig
-- 
2.17.1


