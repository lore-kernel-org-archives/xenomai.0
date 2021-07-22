From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 3/6] drm/msm/mdp5: irq_pipeline: enable out-of-band interrupt
 handling
Date: Thu, 22 Jul 2021 11:48:56 +0200
Message-Id: <20210722094859.3580166-4-rpm@xenomai.org>
In-Reply-To: <20210722094859.3580166-1-rpm@xenomai.org>
References: <20210722094859.3580166-1-rpm@xenomai.org>
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

From: Philippe Gerum <rpm@xenomai.org>

We must decode the chained interrupts on the out-of-band stage to
enable end-to-end out-of-band delivery. Set IRQF_OOB for the parent
handler.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c
index 8e0f2be155d8625..781d701dfc75457 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c
@@ -255,7 +255,7 @@ int mdp5_mdss_init(struct drm_device *dev)
 	}
 
 	ret = devm_request_irq(dev->dev, platform_get_irq(pdev, 0),
-			       mdss_irq, 0, "mdss_isr", mdp5_mdss);
+			       mdss_irq, IRQF_OOB, "mdss_isr", mdp5_mdss);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "failed to init irq: %d\n", ret);
 		goto fail_irq;
-- 
2.31.1


