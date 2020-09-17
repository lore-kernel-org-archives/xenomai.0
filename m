From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH] cobalt/rtdm: add explicit declaration of function
 rtdm_nrtsig_init
Date: Wed, 16 Sep 2020 22:49:47 -0400
Message-Id: <20200917024947.30859-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com
Cc: hongzha1 <hongzhan.chen@intel.com>

fix implicit declaration of function error when compile other cobalt
drivers calling rtdm_nrtsig_init

---
this patch is for wip/dovetail branch

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 2f10fa797..70bea02be 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -902,6 +902,9 @@ struct rtdm_nrtsig {
 	struct irq_work irq_work;
 };
 
+int rtdm_nrtsig_init(rtdm_nrtsig_t *nrt_sig, rtdm_nrtsig_handler_t handler,
+		void *arg);
+
 void rtdm_schedule_nrt_work(struct work_struct *lostage_work);
 /** @} rtdm_nrtsignal */
 
-- 
2.17.1


