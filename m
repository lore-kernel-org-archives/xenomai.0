Message-Id: <C88E27E5-9B12-44C3-BA38-70D5A38A401A@gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date: Thu, 10 Apr 2014 09:58:55 +0100
Subject: [Xenomai] Analogy: subdev list not intitialized if driver private
	data is NULL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Currently my analogy driver for a new DAQ board doesn't need the  
private data struct of the driver, so I set the size to 0:

/* Analogy driver structure */
static a4l_drv_t a4l_drv_pandadaq = {
     .owner = THIS_MODULE,
     .board_name = "analogy_pandadaq",
     .attach = dev_pandadaq_attach,
     .detach = dev_pandadaq_detach,
     .privdata_size = 0,
};

However, due to a potential bug the kernel crashes with a NULL ptr  
exception after linking analogy0 to my driver.

If I apply this patch to the git head of xenomai-2.6 everything works  
for me:

diff --git a/ksrc/drivers/analogy/device.c b/ksrc/drivers/analogy/ 
device.c
index b93ae72..c4095a2 100644
--- a/ksrc/drivers/analogy/device.c
+++ b/ksrc/drivers/analogy/device.c
@@ -278,15 +278,14 @@ int a4l_assign_driver(a4l_cxt_t * cxt,
         a4l_dev_t *dev = a4l_get_dev(cxt);

         dev->driver = drv;
+
+       INIT_LIST_HEAD(&dev->subdvsq);

         if (drv->privdata_size == 0)
                 __a4l_dbg(1, core_dbg,
                           "a4l_assign_driver: warning! "
                           "the field priv will not be usable\n");
         else {
-
-               INIT_LIST_HEAD(&dev->subdvsq);
-
                 dev->priv = rtdm_malloc(drv->privdata_size);
                 if (dev->priv == NULL && drv->privdata_size != 0) {
                         __a4l_err("a4l_assign_driver: "


A.



