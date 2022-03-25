From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH] kernel-shark: Add instroduction of external Xenomai plugin
Date: Fri, 25 Mar 2022 10:37:26 -0400
Message-Id: <20220325143726.20904-2-hongzhan.chen@intel.com>
In-Reply-To: <20220325143726.20904-1-hongzhan.chen@intel.com>
References: <20220325143726.20904-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

There is external Xenomai plugin which can be built standalone
introduced in README as a reference.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/README b/README
index 37ccd95..724d4c9 100644
--- a/README
+++ b/README
@@ -114,6 +114,12 @@ CMake examples:
 
     cmake -DCMAKE_BUILD_TYPE=Package -DCMAKE_C_FLAGS_PACKAGE="-O3 -pedantic"  ../
 
+External plugin example:
+------------------------------------------------------------
+    KernelShark also support standalone plugin building. There is a real example
+    under https://source.denx.de/Xenomai/xenomai/-/tree/next/tracing/kernelshark/
+    which is to visualize out-of-band state of realtime task when there is
+    cobalt context switches in Xenomai.
 
 Contributions:
 ------------------------------------------------------------
-- 
2.17.1


