Message-ID: <5347EADC.3070402@xenomai.org>
Date: Fri, 11 Apr 2014 15:15:08 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <C88E27E5-9B12-44C3-BA38-70D5A38A401A@gmail.com>
In-Reply-To: <C88E27E5-9B12-44C3-BA38-70D5A38A401A@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Analogy: subdev list not intitialized if driver
 private data is NULL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Glatz <andi.glatz@gmail.com>, xenomai@xenomai.org

On 04/10/2014 10:58 AM, Andreas Glatz wrote:
> Currently my analogy driver for a new DAQ board doesn't need the private
> data struct of the driver, so I set the size to 0:
>
> /* Analogy driver structure */
> static a4l_drv_t a4l_drv_pandadaq = {
>      .owner = THIS_MODULE,
>      .board_name = "analogy_pandadaq",
>      .attach = dev_pandadaq_attach,
>      .detach = dev_pandadaq_detach,
>      .privdata_size = 0,
> };
>
> However, due to a potential bug the kernel crashes with a NULL ptr
> exception after linking analogy0 to my driver.
>
> If I apply this patch to the git head of xenomai-2.6 everything works
> for me:
>
> diff --git a/ksrc/drivers/analogy/device.c b/ksrc/drivers/analogy/device.c
> index b93ae72..c4095a2 100644
> --- a/ksrc/drivers/analogy/device.c
> +++ b/ksrc/drivers/analogy/device.c
> @@ -278,15 +278,14 @@ int a4l_assign_driver(a4l_cxt_t * cxt,
>          a4l_dev_t *dev = a4l_get_dev(cxt);
>
>          dev->driver = drv;
> +
> +       INIT_LIST_HEAD(&dev->subdvsq);
>
>          if (drv->privdata_size == 0)
>                  __a4l_dbg(1, core_dbg,
>                            "a4l_assign_driver: warning! "
>                            "the field priv will not be usable\n");
>          else {
> -
> -               INIT_LIST_HEAD(&dev->subdvsq);
> -
>                  dev->priv = rtdm_malloc(drv->privdata_size);
>                  if (dev->priv == NULL && drv->privdata_size != 0) {
>                          __a4l_err("a4l_assign_driver: "
>
>

Makes sense. This release routine may also attempt to free a NULL 
pointer, which is fortunately caught by the underlying allocator, but is 
definitely invalid. Finally, the open-coded iterator for subdevices 
reinvents a wheel. Could you try this patch adding a few fixups to 
yours? TIA,

diff --git a/ksrc/drivers/analogy/device.c b/ksrc/drivers/analogy/device.c
index b93ae72..60b2977 100644
--- a/ksrc/drivers/analogy/device.c
+++ b/ksrc/drivers/analogy/device.c
@@ -278,17 +278,15 @@ int a4l_assign_driver(a4l_cxt_t * cxt,
  	a4l_dev_t *dev = a4l_get_dev(cxt);

  	dev->driver = drv;
+	INIT_LIST_HEAD(&dev->subdvsq);

  	if (drv->privdata_size == 0)
  		__a4l_dbg(1, core_dbg,
  			  "a4l_assign_driver: warning! "
  			  "the field priv will not be usable\n");
  	else {
-
-		INIT_LIST_HEAD(&dev->subdvsq);
-
  		dev->priv = rtdm_malloc(drv->privdata_size);
-		if (dev->priv == NULL && drv->privdata_size != 0) {
+		if (dev->priv == NULL) {
  			__a4l_err("a4l_assign_driver: "
  				  "call(alloc) failed\n");
  			ret = -ENOMEM;
@@ -325,27 +323,26 @@ out_assign_driver:

  int a4l_release_driver(a4l_cxt_t * cxt)
  {
-	int ret = 0;
  	a4l_dev_t *dev = a4l_get_dev(cxt);
+	a4l_subd_t *subd, *tmp;
+	int ret = 0;

  	if ((ret = dev->driver->detach(dev)) != 0)
  		goto out_release_driver;

-	/* Decrease module's count
-	   so as to allow module unloading */
  	module_put(dev->driver->owner);

  	/* In case, the driver developer did not free the subdevices */
-	while (&dev->subdvsq != dev->subdvsq.next) {
-		struct list_head *this = dev->subdvsq.next;
-		a4l_subd_t *tmp = list_entry(this, a4l_subd_t, list);
-
-		list_del(this);
-		rtdm_free(tmp);
-	}
+	if (!list_empty(&dev->subdvsq))
+		list_for_each_entry_safe(subd, tmp, &dev->subdvsq, list) {
+			list_del(&subd->list);
+			rtdm_free(subd);
+		}

  	/* Free the private field */
-	rtdm_free(dev->priv);
+	if (dev->priv)
+		rtdm_free(dev->priv);
+
  	dev->driver = NULL;

  out_release_driver:

-- 
Philippe.

