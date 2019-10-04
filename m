MIME-Version: 1.0
From: Nitin Kulkarni <nitin.kulkarni@mindmusiclabs.com>
Date: Fri, 4 Oct 2019 18:48:35 +0200
Message-ID: <CAPgPmP3ixSnwSoWuWtS8CtoVVmL+ExALaWuDt3zaorRKy8d4zA@mail.gmail.com>
Subject: Xenomai running on IMX8M mini
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

A few months back I wrote to the mailing list about our attempt to run
Xenomai on IMX8M mini.
We had a bumpy ride but we managed to fix the kernel to run Xenomai.
So we thought it would be helpful to others too and share it with the
mailing list.
We identified the irqchip which was causing the issue and fixed it with the
help of I-pipe porting guidelines. The issue was with the gpc-psci driver
which was not i-pipe aware. I have created a repository with the patches
and kernel which we have got working. I don't know how robust it is but we
haven't seen any issues so far.
Since this is a vendor specific patch and the concerned driver is not yet
in the mainline. I am sending the patch here but there is a repository too.
Here is the link to the repo. I hope it will be helpful.
https://github.com/kknitin/imx8M-linux-ipipe
The main patch that solved the lockup issue.

diff --git a/drivers/soc/imx/gpc-psci.c b/drivers/soc/imx/gpc-psci.c
index d3867e18ee23..2e63c681c3db 100644
--- a/drivers/soc/imx/gpc-psci.c
+++ b/drivers/soc/imx/gpc-psci.c
@@ -29,6 +29,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pm_domain.h>
 #include <soc/imx/fsl_sip.h>
+#include <linux/ipipe.h>

 #define GPC_MAX_IRQS (4 * 32)

@@ -49,40 +50,51 @@ enum imx_gpc_pm_domain_state {

 #define to_imx_gpc_pm_domain(_genpd) container_of(_genpd, struct
imx_gpc_pm_domain, pd)

-static DEFINE_SPINLOCK(gpc_psci_lock);
+static IPIPE_DEFINE_SPINLOCK(gpc_psci_lock);
 static DEFINE_MUTEX(gpc_pd_mutex);

-static void imx_gpc_psci_irq_unmask(struct irq_data *d)
+static void __imx_gpc_psci_irq_unmask(struct irq_data *d)
 {
  struct arm_smccc_res res;

- spin_lock(&gpc_psci_lock);
  arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_UNMASK, d->hwirq,
       0, 0, 0, 0, 0, &res);
- spin_unlock(&gpc_psci_lock);
-
- irq_chip_unmask_parent(d);
 }

-static void imx_gpc_psci_irq_mask(struct irq_data *d)
+static void __imx_gpc_psci_irq_mask(struct irq_data *d)
 {
  struct arm_smccc_res res;

- spin_lock(&gpc_psci_lock);
  arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_MASK, d->hwirq,
       0, 0, 0, 0, 0, &res);
- spin_unlock(&gpc_psci_lock);
+}

+static void imx_gpc_psci_irq_unmask(struct irq_data *d)
+{
+ unsigned long flags;
+ raw_spin_lock_irqsave(&gpc_psci_lock, flags);
+ __imx_gpc_psci_irq_unmask(d);
+ raw_spin_unlock_irqrestore(&gpc_psci_lock, flags);
+ irq_chip_unmask_parent(d);
+}
+
+static void imx_gpc_psci_irq_mask(struct irq_data *d)
+{
+ unsigned long flags;
+ raw_spin_lock_irqsave(&gpc_psci_lock, flags);
+ __imx_gpc_psci_irq_mask(d);
+ raw_spin_unlock_irqrestore(&gpc_psci_lock, flags);
  irq_chip_mask_parent(d);
 }
+
 static int imx_gpc_psci_irq_set_wake(struct irq_data *d, unsigned int on)
 {
  struct arm_smccc_res res;

- spin_lock(&gpc_psci_lock);
+ raw_spin_lock(&gpc_psci_lock);
  arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_SET_WAKE, d->hwirq,
       on, 0, 0, 0, 0, &res);
- spin_unlock(&gpc_psci_lock);
+ raw_spin_unlock(&gpc_psci_lock);

  return 0;
 }
@@ -96,14 +108,36 @@ static int imx_gpc_psci_irq_set_affinity(struct
irq_data *d,

  irq_chip_set_affinity_parent(d, dest, force);

- spin_lock(&gpc_psci_lock);
+ raw_spin_lock(&gpc_psci_lock);
  arm_smccc_smc(FSL_SIP_GPC, 0x4, d->hwirq,
       cpu, 0, 0, 0, 0, &res);
- spin_unlock(&gpc_psci_lock);
+ raw_spin_unlock(&gpc_psci_lock);

  return 0;
 }

+#ifdef CONFIG_IPIPE
+
+static void imx_gpc_psci_hold_irq(struct irq_data *d)
+{
+ raw_spin_lock(&gpc_psci_lock);
+ __imx_gpc_psci_irq_mask(d);
+ raw_spin_unlock(&gpc_psci_lock);
+ irq_chip_hold_parent(d);
+}
+
+static void imx_gpc_psci_release_irq(struct irq_data *d)
+{
+ unsigned long flags;
+
+ raw_spin_lock_irqsave(&gpc_psci_lock, flags);
+ __imx_gpc_psci_irq_unmask(d);
+ raw_spin_unlock_irqrestore(&gpc_psci_lock, flags);
+ irq_chip_release_parent(d);
+}
+
+#endif /* CONFIG_IPIPE */
+
 static struct irq_chip imx_gpc_psci_chip = {
  .name = "GPC-PSCI",
  .irq_eoi = irq_chip_eoi_parent,
@@ -112,6 +146,11 @@ static struct irq_chip imx_gpc_psci_chip = {
  .irq_retrigger = irq_chip_retrigger_hierarchy,
  .irq_set_wake = imx_gpc_psci_irq_set_wake,
  .irq_set_affinity = imx_gpc_psci_irq_set_affinity,
+#ifdef CONFIG_IPIPE
+ .irq_hold = imx_gpc_psci_hold_irq,
+ .irq_release = imx_gpc_psci_release_irq,
+#endif
+ .flags = IRQCHIP_PIPELINE_SAFE,
 };

 static int imx_gpc_psci_domain_translate(struct irq_domain *d,


Regards
Nitin
Mind Music Labs AB, Stockholm
