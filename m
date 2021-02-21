From: Fino Meng <fino.meng@linux.intel.com>
Subject: [PATCH 2/2] drm/i195: control LLC CLOS for gpu via debugfs interface
Date: Sun, 21 Feb 2021 23:01:36 +0800
Message-Id: <20210221150136.22456-1-fino.meng@linux.intel.com>
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

On CPU side, the Intel CAT(Cache-Allocation-Technology) can partition the
LLC (Last-Level-Cache). However, when LLC is shared between CPU and GPU,
GPU has no notion about the LLC partitions thus can thrash the cache lines.
By default the graphics device is configured to use as much of cache as
possible.

There is a register field to set CLOS(Class of Service) which restrict
the GPU's LLC usage globally to one of the supported CLOS levels. When
writes the minimum CLOS (3) to this debugfs file, the cache usage
for both render and non-render targets will be restricted to the top
1/16th way of the cache (for 16 way cache).

CAUTION: this patch is a work around operation, formal solution is not
merged into Linux upstream yet. The allocation of certain LLC ways to
different class of service settings is a project dependent decision
and listed in the Bspec.

Ref:
https://01.org/sites/default/files/documentation/
intel-gfx-prm-osrc-kbl-vol05-memory_views.pdf
https://lists.freedesktop.org/archives/intel-gfx/2019-October/216196.html

[Fino: original patch was from Reinette Chatre]
Signed-off-by: Fino Meng <fino.meng@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index eefeb3994d1d..0e28b499fd5a 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -3684,7 +3684,7 @@ i915_cache_sharing_get(void *data, u64 *val)
 	intel_wakeref_t wakeref;
 	u32 snpcr = 0;
 
-	if (!(IS_GEN_RANGE(dev_priv, 6, 7)))
+	if (!(IS_GEN_RANGE(dev_priv, 6, 12)))
 		return -ENODEV;
 
 	with_intel_runtime_pm(&dev_priv->runtime_pm, wakeref)
@@ -3701,7 +3701,7 @@ i915_cache_sharing_set(void *data, u64 val)
 	struct drm_i915_private *dev_priv = data;
 	intel_wakeref_t wakeref;
 
-	if (!(IS_GEN_RANGE(dev_priv, 6, 7)))
+	if (!(IS_GEN_RANGE(dev_priv, 6, 12)))
 		return -ENODEV;
 
 	if (val > 3)
@@ -3716,6 +3716,7 @@ i915_cache_sharing_set(void *data, u64 val)
 		snpcr &= ~GEN6_MBC_SNPCR_MASK;
 		snpcr |= val << GEN6_MBC_SNPCR_SHIFT;
 		I915_WRITE(GEN6_MBCUNIT_SNPCR, snpcr);
+		I915_WRITE(HSW_IDICR, I915_READ(HSW_IDICR) | IDIHASHMSK(0xf) | val << 22);
 	}
 
 	return 0;
-- 
2.20.1


